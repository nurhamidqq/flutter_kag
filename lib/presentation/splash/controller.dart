import 'package:flutter_kag/app/utils/storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    if (await Storage.isLogin) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => Get.offAndToNamed('/homePage'),
      );
    } else {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => Get.offAndToNamed('/loginPage'),
      );
    }
    super.onInit();
  }
}
