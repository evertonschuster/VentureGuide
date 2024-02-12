import 'package:flutter/material.dart';
import 'package:venture_guide/app/injector.dart';
import 'package:venture_guide/app/map/domain/services/location_service.dart';
import 'package:venture_guide/app/shared/widgets/map_provider_widget/map_provider_widget.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locationService = getIt<LocationService>();


    locationService.getCurrentLocation()
    .catchError(() {
      print("Testeeeeeee 4");
    })
    
    
    .then((value) {
      print("Testeeeeeee 2" + value.position!.altitude.toString() + "  " + value.position!.longitude.toString());
    });

    return const MapProviderWidget();
  }
}
