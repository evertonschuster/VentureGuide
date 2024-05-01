import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@singleton
class DatabaseProvider {
  Database? _database;

  DatabaseProvider() {
    initializeDatabase().then((value) => null);
  }

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'venture_guide.db'),
      onCreate: (db, version) {
        try {
          db.execute(
            "CREATE TABLE systemSettings(key TEXT PRIMARY KEY, value TEXT)",
          );

          db.execute('''
          CREATE TABLE markers (
            id TEXT PRIMARY KEY,
            title TEXT,
            description TEXT,
            latitude REAL,
            longitude REAL,
            titleX INTEGER,
            titleY INTEGER,
            categoryId TEXT,
            verifiedAt DATETIME
          );

          CREATE INDEX markers_titleX_titleY ON markers(titleX, titleY);
        ''');

          db.execute('''
          CREATE TABLE markerTitles (
            titleX INTEGER,
            titleY INTEGER,
            downloadedAt DATETIME,
            PRIMARY KEY (titleX, titleY)
          );

        ''');
        } catch (e) {
          print(e);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) => {},
      version: 1,
    );
  }

  Database get database => _database!;
}
