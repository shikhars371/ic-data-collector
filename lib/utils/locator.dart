import 'package:get_it/get_it.dart';
import './navigation_service.dart';
import './language_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => LanguageService());
}
