import 'package:get/get.dart';
import 'package:simple/data/entity/user.dart';
import 'package:simple/http/users.dart';

class UserController extends GetxController {
  var stateUsers = List<User>().obs;

  @override
  void onInit() {
    loadUsers();
    super.onInit();
  }

  void loadUsers() async {
    try {
      var res = await getAllUsers();
      stateUsers = RxList.from(res);
      update();
    } catch (e) {
      throw e;
    }
  }
}
