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
        return db.execute(
          "CREATE TABLE systemSettings(id TEXT PRIMARY KEY, value TEXT)",
        );
      },
      version: 1,
    );
  }

  Database get database => _database!;
}
