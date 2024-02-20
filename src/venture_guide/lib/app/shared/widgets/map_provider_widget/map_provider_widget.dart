import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:venture_guide/app/shared/widgets/map_provider_widget/widgets/tile_providers.dart';

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
      options:
          MapOptions(initialZoom: 11, onMapReady: widget.controller.onMapReady),
      children: [
        openStreetMapTileLayer,
        // MarkerLayer(markers: allMarkers.take(numOfMarkers).toList()),
        ListenableBuilder(
          listenable: widget.controller,
          builder: (context, child) {
            return MarkerLayer(
                markers: widget.controller.markers.map((e) {
              return Marker(
                width: 8.0,
                height: 8.0,
                point: LatLng(e.latitude, e.longitude),
                child: ColoredBox(color: Colors.blue[900]!),
              );
            }).toList());
          },
        ),
      ],
    );
  }
}
