// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:venture_guide/app/map/data/apis/marker_ipi_impl.dart' as _i667;
import 'package:venture_guide/app/map/data/data_base.dart' as _i297;
import 'package:venture_guide/app/map/data/repositories/marker_repository_impl.dart'
    as _i704;
import 'package:venture_guide/app/map/data/repositories/system_settings_repository_impl.dart'
    as _i583;
import 'package:venture_guide/app/map/domain/api/marker_api.dart' as _i998;
import 'package:venture_guide/app/map/domain/repositories/marker_repository.dart'
    as _i509;
import 'package:venture_guide/app/map/domain/repositories/system_settings_repository.dart'
    as _i1051;
import 'package:venture_guide/app/map/domain/services/category_service.dart'
    as _i470;
import 'package:venture_guide/app/map/domain/services/location_service.dart'
    as _i827;
import 'package:venture_guide/app/map/domain/services/marker_service.dart'
    as _i68;
import 'package:venture_guide/app/map/domain/services/sync_service.dart'
    as _i120;
import 'package:venture_guide/app/map/domain/services/system_settings_service.dart'
    as _i497;
import 'package:venture_guide/app/map/domain/services/tile_service.dart'
    as _i421;
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_controller.dart'
    as _i326;
import 'package:venture_guide/app/shared/widgets/map_provider_widget/map_provider_controller.dart'
    as _i581;
import 'package:venture_guide/app/shared/widgets/map_provider_widget/marker_map_service.dart'
    as _i254;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i421.TitleService>(() => _i421.TitleService());
  gh.singleton<_i297.DatabaseProvider>(() => _i297.DatabaseProvider());
  gh.singleton<_i1051.SystemSettingsRepository>(
      () => _i583.SystemSettingsRepositoryImpl(gh<_i297.DatabaseProvider>()));
  gh.factory<_i998.MarkerApi>(() => _i667.MarkerApiImpl());
  gh.factory<_i509.MarkerRepository>(
      () => _i704.MarkerRepositoryImpl(gh<_i297.DatabaseProvider>()));
  gh.singleton<_i497.SystemSettingsService>(() =>
      _i497.SystemSettingsServiceImpl(gh<_i1051.SystemSettingsRepository>()));
  gh.factory<_i827.LocationService>(
      () => _i827.GeolocatorLocationService(gh<_i497.SystemSettingsService>()));
  gh.singleton<_i470.CategoryService>(() => _i470.CategoryServiceImpl());
  gh.singleton<_i68.MarkerService>(() => _i68.MarkerServiceImpl(
        gh<_i509.MarkerRepository>(),
        gh<_i998.MarkerApi>(),
        gh<_i827.LocationService>(),
      ));
  gh.singleton<_i120.SyncService>(() => _i120.SyncServiceImpl(
        gh<_i497.SystemSettingsService>(),
        gh<_i68.MarkerService>(),
      ));
  gh.singleton<_i254.MarkerMapService>(() => _i254.MarkerMapService(
        gh<_i421.TitleService>(),
        gh<_i68.MarkerService>(),
      ));
  gh.factory<_i581.MapProviderController>(
      () => _i581.MapProviderController(gh<_i254.MarkerMapService>()));
  gh.factory<_i326.HomePageController>(() => _i326.HomePageController(
        gh<_i581.MapProviderController>(),
        gh<_i827.LocationService>(),
      ));
  return getIt;
}
