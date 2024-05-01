import 'package:venture_guide/app/map/domain/models/marker.dart';

abstract class MarkerApi {
  Future<List<Marker>> getNearbyPlaces(double lat, double lng);

  Future<List<Marker>> getPlaces(int x, int y);
}
