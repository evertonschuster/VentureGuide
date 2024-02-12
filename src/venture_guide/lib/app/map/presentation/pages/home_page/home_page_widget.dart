import 'package:flutter/material.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_controller.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/widgets/map_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});
  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  HomePageController controller = HomePageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(controller),
    );
  }
}
