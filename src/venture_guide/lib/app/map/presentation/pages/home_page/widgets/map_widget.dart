import 'package:flutter/material.dart';
import 'package:venture_guide/app/map/domain/services/category_service.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_controller.dart';
import 'package:venture_guide/app/shared/widgets/map_provider_widget/map_provider_widget.dart';

class MapWidget extends StatefulWidget {
  const MapWidget(this.controller, this.categoryService, {super.key});

  final HomePageController controller;
  final CategoryService categoryService;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return MapProviderWidget(
      controller: widget.controller.mapProviderController,
      categoryService: widget.categoryService,
    );
  }
}
