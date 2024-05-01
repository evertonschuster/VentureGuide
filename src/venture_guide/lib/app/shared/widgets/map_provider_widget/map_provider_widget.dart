import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:venture_guide/app/map/domain/services/category_service.dart';
import 'package:venture_guide/app/shared/widgets/map_provider_widget/widgets/tile_providers.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'map_provider_controller.dart';

class MapProviderWidget extends StatefulWidget {
  const MapProviderWidget({
    super.key,
    required this.controller,
    required this.categoryService,
  });

  final MapProviderController controller;
  final CategoryService categoryService;

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
            return MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                size: const Size(40, 40),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                maxZoom: 8,
                disableClusteringAtZoom: 10,
                markers: widget.controller.markers.map((e) {
                  return Marker(
                    point: LatLng(e.latitude, e.longitude),
                    child: Image.asset(widget.categoryService.getIcon(e.categoryId)),
                    rotate: true,
                  );
                }).toList(),
                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
