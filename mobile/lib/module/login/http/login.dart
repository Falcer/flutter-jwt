import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:simple/utils/locator.dart';

Future<dynamic> login(String username, String password) async {
  try {
    Response response = await locator.get<Dio>().post("/login", data: {
      "username": username,
      "password": password,
    });
    if (response.data["data"] != null) {
      Hive.box("auth").put(
        "refresh_token",
        response.data["data"]["refresh_token"],
      );
      Hive.box("auth").put(
        "access_token",
        response.data["data"]["access_token"],
      );
    }
    return response.data;
  } catch (e) {
    throw e;
  }
}
