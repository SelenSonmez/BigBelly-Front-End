import 'package:bigbelly/screens/mainPage/data/post_api_client.dart';
import 'package:bigbelly/screens/mainPage/data/post_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => PostRepository());
  locator.registerLazySingleton(() => PostApiClient());
}
