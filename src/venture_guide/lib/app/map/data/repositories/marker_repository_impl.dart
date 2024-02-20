import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:venture_guide/app/map/data/data_base.dart';
import 'package:venture_guide/app/map/domain/models/marker.dart';
import 'package:venture_guide/app/map/domain/repositories/marker_repository.dart';

@Injectable(as: MarkerRepository)
class MarkerRepositoryImpl implements MarkerRepository {
  final DatabaseProvider _databaseProvider;

  MarkerRepositoryImpl(this._databaseProvider);

  @override
  Future<List<Marker>> getMarkers(Point<int> title) {
    final db = _databaseProvider.database;
    return db.query(
      'markers',
      where: 'titleX = ? AND titleY = ?',
      whereArgs: [title.x, title.y],
    ).then((value) {
      return value.map((e) {
        return Marker(
          id: e['id'] as String,
          title: e['title'] as String,
          description: e['description'] as String,
          latitude: e['latitude'] as double,
          longitude: e['longitude'] as double,
          titleX: e['titleX'] as int,
          titleY: e['titleY'] as int,
          verifiedAt: DateTime.parse(e['verifiedAt'] as String),
        );
      }).toList();
    });
  }

  @override
  Future<void> saveMarkers(List<Marker> markers) {
    final db = _databaseProvider.database;
    final batch = db.batch();

    for (final marker in markers) {
      batch.insert(
        'markers',
        {
          'id': marker.id,
          'title': marker.title,
          'description': marker.description,
          'latitude': marker.latitude,
          'longitude': marker.longitude,
          'titleX': marker.titleX,
          'titleY': marker.titleY,
          'verifiedAt': marker.verifiedAt.toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    return batch.commit();
  }
}
