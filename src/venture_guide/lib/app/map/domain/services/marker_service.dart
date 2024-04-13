import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:venture_guide/app/map/domain/api/marker_api.dart';
import 'package:venture_guide/app/map/domain/models/marker.dart';
import 'package:venture_guide/app/map/domain/repositories/marker_repository.dart';
import 'package:venture_guide/app/map/domain/services/location_service.dart';

abstract class MarkerService {
  Future<List<Marker>> getMarkers(Point<int> title);

  Future<void> saveMarkers(List<Marker> markers);

  Future<void> syncMarkers();
}

@Injectable(as: MarkerService)
class MarkerServiceImpl implements MarkerService {
  final MarkerRepository _markerRepository;
  final MarkerApi _markerApi;
  final LocationService _locationService;

  MarkerServiceImpl(this._markerRepository, this._markerApi,
      this._locationService);

  @override
  Future<List<Marker>> getMarkers(Point<int> title) {
    return _markerRepository.getMarkers(title);
  }

  @override
  Future<void> saveMarkers(List<Marker> markers) {
    return _markerRepository.saveMarkers(markers);
  }

  @override
  Future<void> syncMarkers() async {
    final location = await _locationService.getCurrentLocation();

    if (location.isFail) {
      return;
    }

    final latitude = location.position!.latitude;
    final longitude = location.position!.longitude;
    final markers = await _markerApi.getNearbyPlaces(latitude, longitude);

    const int sublistSize = 100;
    for (int i = 0; i < markers.length; i += sublistSize) {
      final sublist = markers.sublist(i, min(i + sublistSize, markers.length));
      _markerRepository.saveMarkers(sublist);
    }
  }
}
