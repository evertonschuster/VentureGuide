import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:venture_guide/app/map/domain/models/marker.dart' as domain;
import 'package:venture_guide/app/shared/widgets/map_provider_widget/marker_map_service.dart';

@Injectable()
class MapProviderController extends ChangeNotifier {
  LatLng position = const LatLng(-23.5505, -46.6333);
  MapController mapController = MapController();
  final Map<Point<int>, List<domain.Marker>?> loadTitle = HashMap();
  final List<domain.Marker> markers = [];

  final MarkerMapService _markerMapService;

  MapProviderController(this._markerMapService);

  void changeLocation(Position newPosition) {
    position = LatLng(newPosition.latitude, newPosition.longitude);
    mapController.move(position, 13);
    _loadMapaMarker();
  }

  void onMapReady() {
    _markerMapService.mapEventStream.listen((event) {
      markers.addAll(event);
      notifyListeners();
    });

    mapController.mapEventStream.listen((event) {
      if (event is MapEventMoveEnd) {
        _loadMapaMarker();
      }
    });

    _loadMapaMarker();
  }

  Future<void> _loadMapaMarker() async {
    if (mapController.camera.zoom < 7) {
      return;
    }

    var location = mapController.camera.center;
    _markerMapService.loadFromLocation(location);

    var bounds = mapController.camera.visibleBounds;
    var southWest = bounds.southWest;
    var northEast = bounds.northEast;


    _markerMapService.loadFromBound(southWest, northEast);
  }
}
