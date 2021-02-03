import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

final GetIt locator = GetIt.instance;
void setupLocator() async {
  await DotEnv.load(fileName: ".env");
  Dio _dio = Dio();
  _dio.options = BaseOptions(
    baseUrl: env["API_URL"],
  );
  locator.registerLazySingleton<Dio>(() => _dio);
}
