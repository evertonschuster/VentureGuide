import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:venture_guide/app/injector.dart';
import 'package:venture_guide/app/map/domain/services/sync_service.dart';
import 'package:venture_guide/app/map/presentation/pages/home_page/home_page_widget.dart';
import 'package:venture_guide/main.reflectable.dart';
// import 'package:wakelock/wakelock.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    name: 'venture-guide',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Wakelock.enable();

  initializeReflectable();
  configureDependencies();

  await FMTCObjectBoxBackend().initialise();
  getIt<SyncService>().initApp().then((value) => null);
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Venture Guide - Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePageWidget(),
      navigatorKey: navigatorKey,
    );
  }
}
