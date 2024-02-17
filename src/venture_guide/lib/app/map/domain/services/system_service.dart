import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:venture_guide/app/map/data/data_base.dart';

abstract class SystemService {
  Future<Position?> getLastKnowLocation();

  saveLastKnowLocation(Position location);
}

@Singleton(as: SystemService )
class SystemServiceImpl implements SystemService {
  late DatabaseProvider databaseProvider;
  SystemServiceImpl(this.databaseProvider);

  @override
  Future<Position?> getLastKnowLocation() async {
    var results = await databaseProvider.database.query(
      'systemSettings',
      where: 'id =  "lastKnowLocation"',
      limit: 1,
    );

    if (results.isNotEmpty) {
      var conf = json.decode(results[0]["value"].toString());
      return Position.fromMap(conf);
    }
    return null;
  }

  @override
  saveLastKnowLocation(Position location) {
    var value = json.encode(location);
    databaseProvider.database
        .insert(
          'systemSettings',
          {
            'id': 'lastKnowLocation',
            'value': value ,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
        .then((value) => {});
  }
}
