import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:venture_guide/app/map/domain/services/system_settings_service.dart';

class LocationResult {
  final Position? position;
  final String? errorMessage;

  LocationResult({this.position, this.errorMessage});

  bool get isSuccess => position != null;
  bool get isFail => position == null;
}

abstract class LocationService {
  Future<LocationResult> getCurrentLocation();

  Future<LocationResult> getLastLocation();
}

@Injectable(as: LocationService)
class GeolocatorLocationService implements LocationService {
  final SystemSettingsService systemService;
  static bool isLocationPermission = false;

  GeolocatorLocationService(this.systemService);

  @override
  Future<LocationResult> getLastLocation() async {
    final lastKnowLocation = await systemService.getLastKnowLocation();
    if (lastKnowLocation != null) {
      return LocationResult(position: lastKnowLocation);
    }

    var result = await _checkLocationPermission();
    if (result != null) {
      return result;
    }

    try {
      final position = await Geolocator.getLastKnownPosition();
      return LocationResult(position: position);
    } catch (e) {
      return LocationResult(
        errorMessage: 'Erro ao obter a localização: ${e.toString()}',
      );
    }
  }

  @override
  Future<LocationResult> getCurrentLocation() async {
    var result = await _checkLocationPermission();
    if (result != null) {
      return result;
    }

    try {
      final Position position = await Geolocator.getCurrentPosition();
      await systemService.saveLastKnowLocation(position);
      return LocationResult(position: position);
    } catch (e) {
      return LocationResult(
        errorMessage: 'Erro ao obter a localização: ${e.toString()}',
      );
    }
  }

  Future<LocationResult?> _checkLocationPermission() async {
    try {
      var permission = await Geolocator.checkPermission();
      return await handlePermission(permission);
    } catch (e) {
      log(e.toString());
      return LocationResult(errorMessage: e.toString());
    } finally {
      isLocationPermission = false;
    }
  }

  Future<LocationResult?> handlePermission(
      LocationPermission permission) async {
    if (permission == LocationPermission.deniedForever) {
      return LocationResult(
          errorMessage: 'Permissão de localização negada permanentemente');
    }

    if (permission == LocationPermission.denied) {
      return await handleDeniedPermission();
    }

    if (permission == LocationPermission.unableToDetermine) {
      return LocationResult(
          errorMessage:
              'Não foi possível determinar a permissão de localização');
    }

    return null;
  }

  Future<LocationResult?> handleDeniedPermission() async {
    while (isLocationPermission) {
      await Future.delayed(const Duration(seconds: 5));
    }
    isLocationPermission = true;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return null;
    }

    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return LocationResult(errorMessage: 'Permissão de localização negada');
    }

    return null;
  }
}
