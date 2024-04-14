import 'dart:async';
import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:venture_guide/app/map/domain/api/marker_api.dart';
import 'package:venture_guide/app/map/domain/models/marker.dart';
import 'package:venture_guide/app/map/domain/repositories/marker_repository.dart';
import 'package:venture_guide/app/map/domain/services/location_service.dart';
import 'package:venture_guide/app/shared/Iterable/group_by_extension.dart';

abstract class MarkerService {
  Stream<TitleMarker> get titleLoaderStream;

  Future<List<Marker>> getMarkers(Point<int> title);

  Future<void> saveMarkers(List<Marker> markers);

  Future<void> syncMarkers();
}

class TitleMarker {
  final Point title;
  final List<Marker> markers;

  TitleMarker(this.title, this.markers);
}

@Singleton(as: MarkerService)
class MarkerServiceImpl implements MarkerService {
  final MarkerRepository _markerRepository;
  final MarkerApi _markerApi;
  final LocationService _locationService;

  final _titleLoaderStream =
      StreamController<TitleMarker>.broadcast(sync: true);

  @override
  Stream<TitleMarker> get titleLoaderStream => _titleLoaderStream.stream;
  StreamSink<TitleMarker> get titleLoaderSink => _titleLoaderStream.sink;

  MarkerServiceImpl(
      this._markerRepository, this._markerApi, this._locationService);

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

    var titlesMarkers = markers.groupBy((p0) => Point(p0.titleX, p0.titleY));

    titlesMarkers.forEach((key, tilemarkers) {
      const int sublistSize = 100;
      for (int i = 0; i < tilemarkers.length; i += sublistSize) {
        final sublist =
            tilemarkers.sublist(i, min(i + sublistSize, tilemarkers.length));
        _markerRepository.saveMarkers(sublist);
      }
      titleLoaderSink.add(TitleMarker(key, tilemarkers));
    });
  }
}
