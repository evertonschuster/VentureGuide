import 'package:flutter/material.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_controller.dart';
import 'package:venture_guide/app/shared/widgets/map_provider_widget/map_provider_widget.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(this.controller, {super.key});

  final HomePageController controller;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return MapProviderWidget(
      controller: widget.controller.mapProviderController,
    );
  }
}
