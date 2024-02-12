import 'package:flutter/material.dart';
import 'package:venture_guide/app/injector.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_widget.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const HomePageWidget(),
      navigatorKey: navigatorKey,
    );
  }
}
