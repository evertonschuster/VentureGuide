import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:reflectable/reflectable.dart';
import 'package:venture_guide/app/map/data/data_base.dart';
import 'package:venture_guide/app/map/domain/models/system_setting.dart';
import 'package:venture_guide/app/map/domain/repositories/system_settings_repository.dart';
import 'package:venture_guide/app/reflector.dart';

abstract class TSystemSetting {
  Map<String, dynamic> toJson();
  TSystemSetting.fromJson(Map<String, dynamic>? json);
}

abstract class SystemSettingsService {
  Future<Position?> getLastKnowLocation();
  Future saveLastKnowLocation(Position location);

  Future<T> getConfiguration<T extends TSystemSetting>();
  Future setConfiguration<T extends TSystemSetting>(T configuration);
}

@Singleton(as: SystemSettingsService)
class SystemSettingsServiceImpl implements SystemSettingsService {
  late SystemSettingsRepository systemSettingsRepository;
  SystemSettingsServiceImpl(this.systemSettingsRepository);

  @override
  Future<Position?> getLastKnowLocation() async {
    const key = 'lastKnowLocation';
    final systemSetting = await systemSettingsRepository.get(key);

    if (systemSetting != null) {
      final conf = json.decode(systemSetting.value);
      return Position.fromMap(conf);
    }

    return null;
  }

  @override
  Future saveLastKnowLocation(Position location) async {
    const key = 'lastKnowLocation';
    var value = json.encode(location);
    final systemSettings = SystemSetting(key: key, value: value);

    await systemSettingsRepository.save(systemSettings);
  }

  @override
  Future<T> getConfiguration<T extends TSystemSetting>() async {
    final key = T.toString();
    final systemSetting = await systemSettingsRepository.get(key);

    if (systemSetting != null) {
      final conf = json.decode(systemSetting.value);
      return _createInstace<T>(conf);
    }

    return _createInstace<T>(null);
  }

  @override
  Future setConfiguration<T extends TSystemSetting>(T configuration) async {
    final key = T.toString();
    final mapJson = configuration.toJson();
    final valueString = json.encode(mapJson);
    final systemSettings = SystemSetting(key: key, value: valueString);

    await systemSettingsRepository.save(systemSettings);
  }

  T _createInstace<T extends TSystemSetting>(Map<String, dynamic>? json) {
    if (reflector.reflectType(T) is! ClassMirror) {
      throw Exception("Type not supported");
    }

    final classMirror = reflector.reflectType(T) as ClassMirror;
    try {
      return classMirror.newInstance("fromJson", [json]) as T;
    } catch (e) {
      if (e is ReflectableNoSuchMethodError) {
        throw Exception("Type dont have a fromJson(json) constructor");
      }

      rethrow;
    }
  }
}
