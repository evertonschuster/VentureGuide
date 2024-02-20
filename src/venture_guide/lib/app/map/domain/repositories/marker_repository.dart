import 'dart:math';

import 'package:venture_guide/app/map/domain/models/marker.dart';

abstract class MarkerRepository {
  Future<List<Marker>> getMarkers(Point<int> title);

  Future<void> saveMarkers(List<Marker> markers);
}