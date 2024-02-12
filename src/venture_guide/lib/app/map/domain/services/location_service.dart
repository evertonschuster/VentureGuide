import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

class LocationResult {
  final Position? position;
  final String? errorMessage;

  LocationResult({this.position, this.errorMessage});

  bool get isSuccess => position != null;
}


abstract class LocationService {
  Future<LocationResult> getCurrentLocation();
}

@Injectable(as: LocationService)
class GeolocatorLocationService implements LocationService {
  @override
  Future<LocationResult> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationResult(
          errorMessage: 'Os serviços de localização estão desabilitados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationResult(
            errorMessage: 'Permissões de localização negadas.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationResult(
          errorMessage:
              'As permissões de localização foram permanentemente negadas, não podemos solicitar permissões.');
    }

    try {
      final Position position = await Geolocator.getCurrentPosition();
      return LocationResult(position: position);
    } catch (e) {
      return LocationResult(
          errorMessage: 'Erro ao obter a localização: ${e.toString()}');
    }
  }
}