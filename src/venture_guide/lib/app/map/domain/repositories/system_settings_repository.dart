import 'package:venture_guide/app/map/domain/models/system_setting.dart';

abstract class SystemSettingsRepository {
  Future<SystemSetting?> get(String key);

  Future<void> save(SystemSetting systemSetting);
}