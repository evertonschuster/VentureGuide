import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:venture_guide/app/shared/widgets/map_provider_widget/misc/tile_providers.dart';

import 'map_provider_controller.dart';

class MapProviderWidget extends StatefulWidget {
  const MapProviderWidget({
    super.key,
    required this.controller,
  });

  final MapProviderController controller;

  @override
  State<MapProviderWidget> createState() => _MapProviderWidgetState();
}

class _MapProviderWidgetState extends State<MapProviderWidget> {
  @override
  Widget build(BuildContext context) {
    
    return FlutterMap(
      mapController: widget.controller.mapController,
      options: const MapOptions(
        initialZoom: 11,
      ),
      children: [
        openStreetMapTileLayer,
      ],
    );
  }
}
