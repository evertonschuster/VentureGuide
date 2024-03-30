import 'package:injectable/injectable.dart';
import 'package:venture_guide/app/map/domain/models/system_settings/system_markers_init.dart';
import 'package:venture_guide/app/map/domain/services/system_settings_service.dart';

abstract class SyncService {
  Future<void> initApp();
}

@Injectable(as: SyncService)
class SyncServiceImpl implements SyncService {

  final SystemSettingsService _systemService;

  SyncServiceImpl(this._systemService);

  @override
  Future<void> initApp() async {
    var isSystemSync = await _systemService.getConfiguration<SystemMarkersInit>();
    await _systemService.setConfiguration(isSystemSync);

  }
}
