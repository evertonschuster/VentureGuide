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
import 'package:venture_guide/app/map/domain/repositories/marker_repository.dart'
    as _i4;
import 'package:venture_guide/app/map/domain/services/location_service.dart'
    as _i8;
import 'package:venture_guide/app/map/domain/services/marker_service.dart'
    as _i9;
import 'package:venture_guide/app/map/domain/services/system_service.dart'
    as _i6;
import 'package:venture_guide/app/map/domain/services/tile_service.dart' as _i7;
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_controller.dart'
    as _i12;
import 'package:venture_guide/app/shared/widgets/map_provider_widget/map_provider_controller.dart'
    as _i11;
import 'package:venture_guide/app/shared/widgets/map_provider_widget/marker_map_service.dart'
    as _i10;

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
  gh.singleton<_i6.SystemService>(
      _i6.SystemServiceImpl(gh<_i3.DatabaseProvider>()));
  gh.factory<_i7.TitleService>(() => _i7.TitleService());
  gh.factory<_i8.LocationService>(
      () => _i8.GeolocatorLocationService(gh<_i6.SystemService>()));
  gh.factory<_i9.MarkerService>(() => _i9.MarkerServiceImpl(
        gh<_i4.MarkerRepository>(),
        gh<_i7.TitleService>(),
      ));
  gh.singleton<_i10.MarkerMapService>(_i10.MarkerMapService(
    gh<_i7.TitleService>(),
    gh<_i9.MarkerService>(),
  ));
  gh.factory<_i11.MapProviderController>(
      () => _i11.MapProviderController(gh<_i10.MarkerMapService>()));
  gh.factory<_i12.HomePageController>(() => _i12.HomePageController(
        gh<_i11.MapProviderController>(),
        gh<_i8.LocationService>(),
      ));
  return getIt;
}
