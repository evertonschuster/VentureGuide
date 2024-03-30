import 'package:venture_guide/app/map/domain/services/system_settings_service.dart';
import 'package:venture_guide/app/reflector.dart';

@reflector
class SystemMarkersInit extends TSystemSetting {
  bool? isSystemSync = false;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isSystemSync'] = isSystemSync;
    return data;
  }

  SystemMarkersInit.fromJson(Map<String, dynamic>? json)
      : super.fromJson(json) {
    if (json == null) {
      return;
    }

    isSystemSync = json['isSystemSync'];
  }
}
