// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:venture_guide/app/map/data/apis/marker_ipi_impl.dart' as _i6;
import 'package:venture_guide/app/map/data/data_base.dart' as _i4;
import 'package:venture_guide/app/map/data/repositories/marker_repository_impl.dart'
    as _i8;
import 'package:venture_guide/app/map/data/repositories/system_settings_repository_impl.dart'
    as _i10;
import 'package:venture_guide/app/map/domain/api/marker_api.dart' as _i5;
import 'package:venture_guide/app/map/domain/repositories/marker_repository.dart'
    as _i7;
import 'package:venture_guide/app/map/domain/repositories/system_settings_repository.dart'
    as _i9;
import 'package:venture_guide/app/map/domain/services/category_service.dart'
    as _i3;
import 'package:venture_guide/app/map/domain/services/location_service.dart'
    as _i13;
import 'package:venture_guide/app/map/domain/services/marker_service.dart'
    as _i14;
import 'package:venture_guide/app/map/domain/services/sync_service.dart'
    as _i15;
import 'package:venture_guide/app/map/domain/services/system_settings_service.dart'
    as _i11;
import 'package:venture_guide/app/map/domain/services/tile_service.dart'
    as _i12;
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_controller.dart'
    as _i18;
import 'package:venture_guide/app/shared/widgets/map_provider_widget/map_provider_controller.dart'
    as _i17;
import 'package:venture_guide/app/shared/widgets/map_provider_widget/marker_map_service.dart'
    as _i16;

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
  gh.singleton<_i3.CategoryService>(_i3.CategoryServiceImpl());
  gh.singleton<_i4.DatabaseProvider>(_i4.DatabaseProvider());
  gh.factory<_i5.MarkerApi>(() => _i6.MarkerApiImpl());
  gh.factory<_i7.MarkerRepository>(
      () => _i8.MarkerRepositoryImpl(gh<_i4.DatabaseProvider>()));
  gh.singleton<_i9.SystemSettingsRepository>(
      _i10.SystemSettingsRepositoryImpl(gh<_i4.DatabaseProvider>()));
  gh.singleton<_i11.SystemSettingsService>(
      _i11.SystemSettingsServiceImpl(gh<_i9.SystemSettingsRepository>()));
  gh.factory<_i12.TitleService>(() => _i12.TitleService());
  gh.factory<_i13.LocationService>(
      () => _i13.GeolocatorLocationService(gh<_i11.SystemSettingsService>()));
  gh.singleton<_i14.MarkerService>(_i14.MarkerServiceImpl(
    gh<_i7.MarkerRepository>(),
    gh<_i5.MarkerApi>(),
    gh<_i13.LocationService>(),
  ));
  gh.singleton<_i15.SyncService>(_i15.SyncServiceImpl(
    gh<_i11.SystemSettingsService>(),
    gh<_i14.MarkerService>(),
  ));
  gh.singleton<_i16.MarkerMapService>(_i16.MarkerMapService(
    gh<_i12.TitleService>(),
    gh<_i14.MarkerService>(),
  ));
  gh.factory<_i17.MapProviderController>(
      () => _i17.MapProviderController(gh<_i16.MarkerMapService>()));
  gh.factory<_i18.HomePageController>(() => _i18.HomePageController(
        gh<_i17.MapProviderController>(),
        gh<_i13.LocationService>(),
      ));
  return getIt;
}
