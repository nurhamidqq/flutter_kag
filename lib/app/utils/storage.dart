import 'package:flutter_kag/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Storage {
  static UserModel get getLoginData =>
      UserModel.fromJson(GetStorage().read('user'));
  static Future<bool> get isLogin async => false.val('isLogin').val;
  static Future<void> setLoginData(UserModel? user) async {
    await GetStorage().write(
      'user',
      user?.toJson(),
    );
  }

  static Future<void> setlogin() async {
    await GetStorage().write('isLogin', true);
  }

  static Future<void> setLogout() async {
    GetStorage()
      ..remove('user')
      ..remove('isLogin');
    Get.offAndToNamed('/loginPage');
  }
}
