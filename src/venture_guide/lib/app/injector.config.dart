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
import 'package:venture_guide/app/map/data/repositories/marker_repository_impl.dart'
    as _i5;
import 'package:venture_guide/app/map/data/repositories/system_settings_repository_impl.dart'
    as _i7;
import 'package:venture_guide/app/map/domain/repositories/marker_repository.dart'
    as _i4;
import 'package:venture_guide/app/map/domain/repositories/system_settings_repository.dart'
    as _i6;
import 'package:venture_guide/app/map/domain/services/location_service.dart'
    as _i10;
import 'package:venture_guide/app/map/domain/services/marker_service.dart'
    as _i11;
import 'package:venture_guide/app/map/domain/services/sync_service.dart'
    as _i12;
import 'package:venture_guide/app/map/domain/services/system_settings_service.dart'
    as _i8;
import 'package:venture_guide/app/map/domain/services/tile_service.dart' as _i9;
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_controller.dart'
    as _i15;
import 'package:venture_guide/app/shared/widgets/map_provider_widget/map_provider_controller.dart'
    as _i14;
import 'package:venture_guide/app/shared/widgets/map_provider_widget/marker_map_service.dart'
    as _i13;

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
  gh.factory<_i4.MarkerRepository>(
      () => _i5.MarkerRepositoryImpl(gh<_i3.DatabaseProvider>()));
  gh.singleton<_i6.SystemSettingsRepository>(
      _i7.SystemSettingsRepositoryImpl(gh<_i3.DatabaseProvider>()));
  gh.singleton<_i8.SystemSettingsService>(
      _i8.SystemSettingsServiceImpl(gh<_i6.SystemSettingsRepository>()));
  gh.factory<_i9.TitleService>(() => _i9.TitleService());
  gh.factory<_i10.LocationService>(
      () => _i10.GeolocatorLocationService(gh<_i8.SystemSettingsService>()));
  gh.factory<_i11.MarkerService>(() => _i11.MarkerServiceImpl(
        gh<_i4.MarkerRepository>(),
        gh<_i9.TitleService>(),
      ));
  gh.factory<_i12.SyncService>(
      () => _i12.SyncServiceImpl(gh<_i8.SystemSettingsService>()));
  gh.singleton<_i13.MarkerMapService>(_i13.MarkerMapService(
    gh<_i9.TitleService>(),
    gh<_i11.MarkerService>(),
  ));
  gh.factory<_i14.MapProviderController>(
      () => _i14.MapProviderController(gh<_i13.MarkerMapService>()));
  gh.factory<_i15.HomePageController>(() => _i15.HomePageController(
        gh<_i14.MapProviderController>(),
        gh<_i10.LocationService>(),
      ));
  return getIt;
}
