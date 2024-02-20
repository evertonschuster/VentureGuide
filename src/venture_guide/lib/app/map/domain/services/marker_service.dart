import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:venture_guide/app/map/domain/models/marker.dart';
import 'package:venture_guide/app/map/domain/repositories/marker_repository.dart';
import 'package:venture_guide/app/map/domain/services/tile_service.dart';

abstract class MarkerService {
  Future<List<Marker>> getMarkers(Point<int> title);

  Future<void> saveMarkers(List<Marker> markers);

  Future<void> syncMarkers();
}

@Injectable(as: MarkerService)
class MarkerServiceImpl implements MarkerService {
  final MarkerRepository _markerRepository;
  final TitleService _titleService;

  MarkerServiceImpl(this._markerRepository, this._titleService);

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
    final String response =
        await rootBundle.loadString('lib/assets/database/places_brazil.json');
    final data = await json.decode(response);

    final markers = (data as List).map((e) {
      final id = e['id'] as int;
      final title = e['name'] as String;
      final description = e['description'] as String;
      final latitude = e['location']["latitude"] as double;
      final longitude = e['location']["longitude"] as double;
      final verifiedAt = e['date_verified'] as String;

      final titleValue =
          _titleService.latLngToTile(LatLng(latitude, longitude));

      return Marker(
        id: id.toString(),
        title: title,
        description: description,
        latitude: latitude,
        longitude: longitude,
        titleX: titleValue.x,
        titleY: titleValue.y,
        verifiedAt: DateTime.parse(verifiedAt),
      );
    }).toList();

    const int sublistSize = 100;
    for (int i = 0; i < markers.length; i += sublistSize) {
      final sublist = markers.sublist(i, min(i + sublistSize, markers.length));
      _markerRepository.saveMarkers(sublist);
    }
  }
}
