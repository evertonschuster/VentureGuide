import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:venture_guide/app/map/domain/services/location_service.dart';
import 'package:venture_guide/app/shared/widgets/alert/alert.dart';
import 'package:venture_guide/app/shared/widgets/map_provider_widget/map_provider_controller.dart';

@Injectable()
class HomePageController extends ChangeNotifier {
  final MapProviderController mapProviderController;
  final LocationService locationService;

  HomePageController(this.mapProviderController, this.locationService) {
    onLoadData();
  }

  Future<void> onLoadData() async {
    await onLoadCurrentLocation();
  }

  Future<void> onLoadCurrentLocation() async {
    var isLoad = false;

    locationService.getLastLocation().then((value) => {
          if (value.isSuccess && !isLoad)
            {
              mapProviderController.changeLocation(value.position!),
            }
        });

    var location = await locationService.getCurrentLocation();
    isLoad = true;

    if (location.isSuccess) {
      return mapProviderController.changeLocation(location.position!);
    }

    AlertService.showError(
      location.errorMessage ?? "Erro ao carregar localização atual!",
    );
  }
}
