// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:venture_guide/app/map/data/data_base.dart' as _i3;
import 'package:venture_guide/app/map/domain/services/location_service.dart'
    as _i5;
import 'package:venture_guide/app/map/domain/services/system_service.dart'
    as _i4;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.DatabaseProvider>(_i3.DatabaseProvider());
  gh.singleton<_i4.SystemService>(
      _i4.SystemServiceImpl(gh<_i3.DatabaseProvider>()));
  gh.factory<_i5.LocationService>(
      () => _i5.GeolocatorLocationService(gh<_i4.SystemService>()));
  return getIt;
}
