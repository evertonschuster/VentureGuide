import 'package:flutter/material.dart';
import 'package:venture_guide/app/injector.dart';
import 'package:venture_guide/app/map/domain/services/category_service.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_controller.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/widgets/action_buttons_widget.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/widgets/map_widget.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/widgets/search_bar_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});
  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  HomePageController controller = getIt<HomePageController>();
  CategoryService categoryService = getIt<CategoryService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            controller,
            categoryService,
          ),
          const Column(
            children: [SearchBarWidget(), ActionButtonsWidget()],
          ),
        ],
      ),
    );
  }
}
