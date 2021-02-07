import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:simple/data/entity/user.dart';
import 'package:simple/utils/locator.dart';

Future<List<User>> getAllUsers() async {
  try {
    Response response = await locator.get<Dio>().get(
          "/users",
          options: Options(
            headers: {
              "Authorization": "Bearer ${Hive.box('auth').get('access_token')}",
            },
          ),
        );
    Iterable data = response.data["data"];
    return List<User>.from(data.map((e) => User.fromJSON(e)));
  } catch (e) {
    throw e;
  }
}
