import 'package:get_it/get_it.dart';
import 'package:word_toob/app_providers/app_setting_provider.dart';
import 'package:word_toob/app_providers/main_dashboard_controller.dart';

import 'package:word_toob/common/app_constants/general.dart';

final GetIt sl = GetIt.instance;

Future<void> setup() async {



  printLog("[setup] **** App Settings Applied ****");

  ///providers
  sl.registerLazySingleton<AppSettingsProvider>(() => AppSettingsProvider());
  sl.registerLazySingleton<MainDashboardController>(() => MainDashboardController());

  //         iAuthenticationLocalDataSource: sl()));
  // sl.registerLazySingleton<AuthenticationProvider>(
  //         () => AuthenticationProvider(iAuthenticationRepository: sl()));
  // sl.registerLazySingleton<ContentProvider>(
  //         () => ContentProvider(iAppRepository: sl()));

  // dio.interceptors.addAll([
  //   if(kDebugMode)
  //     prettyLogger(),
  //   AuthInterceptor(dio,sl(), sl()),
  // ]);
}
