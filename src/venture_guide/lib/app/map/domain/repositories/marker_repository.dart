import 'dart:math';

import 'package:venture_guide/app/map/domain/models/marker.dart';
import 'package:venture_guide/app/map/domain/models/marker_title.dart';

abstract class MarkerRepository {
  Future<List<Marker>> getMarkers(Point<int> title);

  Future<void> saveMarkers(List<Marker> markers);
 
  Future<MarkerTitle?> getMarkerTitle(Point<int> title);
  
  Future saveMarkerTitle(MarkerTitle markerTitle);
}