import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:venture_guide/app/map/data/data_base.dart';
import 'package:venture_guide/app/map/domain/models/system_setting.dart';
import 'package:venture_guide/app/map/domain/repositories/system_settings_repository.dart';

@Singleton(as: SystemSettingsRepository)
class SystemSettingsRepositoryImpl implements SystemSettingsRepository {
  late DatabaseProvider databaseProvider;
  SystemSettingsRepositoryImpl(this.databaseProvider);

  @override
  Future<SystemSetting?> get(String key) async {
    var results = await databaseProvider.database.query(
      'systemSettings',
      where: 'key = "$key"',
      limit: 1,
    );

    if (results.isEmpty) {
      return null;
    }

    return SystemSetting.fromJson(results.first);
  }

  @override
  Future<void> save(SystemSetting systemSetting) async {
    await databaseProvider.database.insert(
      'systemSettings',
      {
        'key': systemSetting.key,
        'value': systemSetting.value,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
