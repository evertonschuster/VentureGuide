import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@Injectable()
class TitleService {
  final double zoom = 7;

  Point<int> latLngToTile(LatLng latLng) {
    double lat = latLng.latitude;
    double lng = latLng.longitude;

    // Converter coordenadas para radianos
    double latRad = lat * pi / 180;

    // Cálculo da projeção de Mercator
    double mercN = log(tan((pi / 4) + (latRad / 2)));

    // Calculando as coordenadas do tile
    int x = ((lng + 180) / 360 * pow(2, zoom)).toInt();
    int y = ((1 - mercN / pi) / 2 * pow(2, zoom)).toInt();

    return Point<int>(x, y);
  }

  List<Point<int>> latLngBoundsToTiles(LatLng latLng1, LatLng latLng2) {
    final southWest = latLngToTile(latLng1);
    final northEast = latLngToTile(latLng2);

    var tiles = <Point<int>>[];
    for (var lat = northEast.y; lat <= southWest.y; lat++) {
      for (var lon = southWest.x; lon <= northEast.x; lon++) {
        tiles.add(Point(lon, lat));
      }
    }
    return tiles;
  }
}
