import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:venture_guide/app/map/domain/models/marker.dart';
import 'package:venture_guide/app/map/domain/services/marker_service.dart';
import 'package:venture_guide/app/map/domain/services/tile_service.dart';

@Singleton()
class MarkerMapService {
  final Map<Point<int>, LoadStatus> titleLoader = HashMap();
  final _mapEventStream = StreamController<List<Marker>>.broadcast();

  final List<Marker> markers = [];
  bool isWorking = false;

  final TitleService _titleService;
  final MarkerService _markerService;

  MarkerMapService(this._titleService, this._markerService) {
    _markerService.titleLoaderStream.listen((event) {
      if (titleLoader.containsKey(event.title)) {
        for (var marker in event.markers) {
          if (!markers.any((m) => m.id == marker.id)) {
            markers.add(marker);
          }
        }
        _emitEvent(event.markers);
      }
    });
  }

  Stream<List<Marker>> get mapEventStream => _mapEventStream.stream;
  StreamSink<List<Marker>> get _mapEventSink => _mapEventStream.sink;

  void loadFromLocation(LatLng location) {
    var title = _titleService.latLngToTile(location);
    _toLoadTitle(title);
    _triggerWorker();
  }

  void loadFromBound(LatLng southWest, LatLng northEast) {
    var tiles = _titleService.latLngBoundsToTiles(southWest, northEast);
    for (var element in tiles) {
      _toLoadTitle(element);
    }
    _triggerWorker();
  }

  void _toLoadTitle(Point<int> title) {
    if (titleLoader.containsKey(title)) {
      return;
    }

    titleLoader.addEntries([MapEntry(title, LoadStatus.pending)]);
  }

  Future<void> _triggerWorker() async {
    if (isWorking) {
      return;
    }

    isWorking = true;

    print(
        "======================================================== object entrei");

    try {
      while (titleLoader.values
          .where((element) => element == LoadStatus.pending)
          .isNotEmpty) {
        await _loaderTitles();
      }
    } finally {
      isWorking = false;
    }

    print(
        "======================================================== object sair");
  }

  Future _loaderTitles() async {
    var pending = titleLoader.entries
        .where((element) => element.value == LoadStatus.pending)
        .toList();

    const int sublistSize = 10;
    for (int i = 0; i < pending.length; i += sublistSize) {
      final sublist = pending.sublist(i, min(i + sublistSize, pending.length));

      final tasks = sublist.map((element) {
        return _loadTitle(element.key);
      });

      var taskResult = await Future.wait(tasks);
      var marks = taskResult.expand((element) => element).toList();

      _emitEvent(marks);
    }
  }

  Future<List<Marker>> _loadTitle(Point<int> title) async {
    try {
      var value = await _markerService.getMarkers(title);
      markers.addAll(value);

      titleLoader.addEntries([MapEntry(title, LoadStatus.loaded)]);
      debugPrint("Carregou marcadores do tile ${value.length}");

      return value;
    } catch (e) {
      titleLoader.addEntries([MapEntry(title, LoadStatus.error)]);
      debugPrint("Erro ao carregar marcadores do tile: $e");
    }

    return [];
  }

  void _emitEvent(List<Marker> newMarkers) {
    _mapEventSink.add(newMarkers);
  }
}

enum LoadStatus {
  pending,
  loaded,
  error,
}
