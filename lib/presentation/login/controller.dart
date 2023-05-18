import 'package:flutter/widgets.dart';
import 'package:flutter_kag/app/utils/storage.dart';
import 'package:flutter_kag/app/utils/toast.dart';
import 'package:flutter_kag/data/repositories/user_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  RxBool loading = false.obs;
  RxBool passwordVisible = false.obs;

  @override
  void dispose() {
    emailCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }

  login() async {
    if (formKey.currentState!.validate()) {
      loading.value = true;
      final response = await _userRepository.getListUser();
      if (response != null) {
        final user = response.where((element) =>
            element.email?.toLowerCase() == emailCtr.text.toLowerCase() &&
            element.address?.city == passwordCtr.text);

        if (user.isNotEmpty) {
          await Storage.setLoginData(user.first);
          await Storage.setlogin();
          ToastUtil.showSnackBar('Info', 'Login Success', ToastStatus.success);
          Get.offAndToNamed('/homePage');
        } else {
          ToastUtil.showSnackBarError(
              'Login Failed', 'Please check email or password');
        }
      }
      loading.value = false;
    }
  }
}
