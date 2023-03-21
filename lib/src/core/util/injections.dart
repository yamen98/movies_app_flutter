import 'package:movies_app/main.dart';
import 'package:movies_app/src/core/network/dio_network.dart';
import 'package:movies_app/src/core/util/log/app_logger.dart';
import 'package:movies_app/src/core/util/log/log_controller.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_app/src/features/movies/movies_injections.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_feature/app_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  sl.registerLazySingleton<LogController>(() => LogController());

  await initSharedPrefsInjections();
  await initAppInjections();
  await initCoreInjections();
  await initMoviesInjections();
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

Future<void> onUnexpectedError(ErrorInterceptorHandler handler, error) async {
  handler.reject(error);
  navigatorKey.currentState?.pushReplacementNamed("/login");
}

Future<void> initCoreInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}
