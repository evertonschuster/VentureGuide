import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:venture_guide/app/shared/widgets/map_provider_widget/misc/tile_providers.dart';

class MapProviderWidget extends StatelessWidget {
  const MapProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(51.5, -0.09),
        initialZoom: 11,
      ),
      children: [
        openStreetMapTileLayer,
      ],
    );
  }
}
