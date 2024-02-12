import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapProviderController extends ChangeNotifier {
  LatLng position = const LatLng(-23.5505, -46.6333);
  MapController mapController = MapController();

  void changeLocation(Position newPosition) {
    position = LatLng(newPosition.latitude, newPosition.longitude);
    mapController.move(position, 13);
  }
}
