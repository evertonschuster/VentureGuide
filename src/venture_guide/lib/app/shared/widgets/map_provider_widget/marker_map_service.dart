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
  final Map<Point<int>, LoadStatus> _tileLoader = HashMap();
  final _mapEventController = StreamController<List<Marker>>.broadcast();
  final List<Marker> _markers = [];
  bool _isWorking = false;

  final TitleService _titleService;
  final MarkerService _markerService;

  MarkerMapService(this._titleService, this._markerService) {
    _markerService.titleLoaderStream.listen(_processEvent);
  }

  Stream<List<Marker>> get mapEventStream => _mapEventController.stream;

  void loadFromLocation(LatLng location) {
    final tile = _titleService.latLngToTile(location);
    _queueTileForLoading(tile);
    _processQueue();
  }

  void loadFromBound(LatLng southWest, LatLng northEast) {
    final tiles = _titleService.latLngBoundsToTiles(southWest, northEast);
    tiles.forEach(_queueTileForLoading);
    _processQueue();
  }

  void _queueTileForLoading(Point<int> tile) {
    _tileLoader.putIfAbsent(tile, () => LoadStatus.pending);
  }

  Future<void> _processQueue() async {
    if (_isWorking) return;

    _isWorking = true;
    try {
      while (_tileLoader.values.contains(LoadStatus.pending)) {
        await _loadPendingTiles();
      }
    } finally {
      _isWorking = false;
    }
  }

  Future<void> _loadPendingTiles() async {
    const int batchSize = 10;
    final pendingTiles = _tileLoader.entries
        .where((entry) => entry.value == LoadStatus.pending)
        .toList();

    for (var i = 0; i < pendingTiles.length; i += batchSize) {
      final batch = pendingTiles.sublist(i, min(i + batchSize, pendingTiles.length));
      final tasks = batch.map((entry) => _loadTile(entry.key));
      final results = await Future.wait(tasks);

      final newMarkers = results.expand((list) => list).toList();
      _emitEvent(newMarkers);
    }
  }

  Future<List<Marker>> _loadTile(Point<int> tile) async {
    try {
      final markers = await _markerService.getMarkers(tile);
      _markers.addAll(markers);
      _tileLoader[tile] = LoadStatus.loaded;
      debugPrint("Loaded ${markers.length} markers for tile $tile");
      return markers;
    } catch (e) {
      _tileLoader[tile] = LoadStatus.error;
      debugPrint("Failed to load markers for tile $tile: $e");
      return [];
    }
  }

  void _emitEvent(List<Marker> newMarkers) {
    _mapEventController.add(newMarkers);
  }

  void _processEvent(TitleMarker event) {
    if (_tileLoader.containsKey(event.title)) {
      final newMarkers = event.markers.where((marker) => !_markers.any((m) => m.id == marker.id));
      _markers.addAll(newMarkers);
      _emitEvent(newMarkers.toList());
    }
  }

  void dispose() {
    _mapEventController.close();
  }
}

enum LoadStatus {
  pending,
  loaded,
  error,
}
