import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injector.config.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
final getIt = GetIt.instance;

@InjectableInit(asExtension: false)
void configureDependencies() => init(getIt);
