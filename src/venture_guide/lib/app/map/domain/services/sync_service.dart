import 'package:injectable/injectable.dart';
import 'package:venture_guide/app/map/domain/models/system_settings/system_markers_init.dart';
import 'package:venture_guide/app/map/domain/services/marker_service.dart';
import 'package:venture_guide/app/map/domain/services/system_settings_service.dart';

abstract class SyncService {
  Future<void> initApp();
}

@Injectable(as: SyncService)
class SyncServiceImpl implements SyncService {
  final SystemSettingsService _systemService;
  final MarkerService _markerService;

  SyncServiceImpl(this._systemService, this._markerService);

  @override
  Future<void> initApp() async {
    var isSystemSync =
        await _systemService.getConfiguration<SystemMarkersInit>();
        
    if (isSystemSync.isSystemSync == true) {
      return;
    }

    await _markerService.syncMarkers();
    isSystemSync.isSystemSync = true;
    await _systemService.setConfiguration(isSystemSync);
  }
}
