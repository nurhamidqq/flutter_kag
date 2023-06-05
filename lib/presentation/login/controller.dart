import 'dart:math';

import 'package:device_information/device_information.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_kag/app/utils/storage.dart';
import 'package:flutter_kag/app/utils/toast.dart';
import 'package:flutter_kag/data/models/address_model.dart';
import 'package:flutter_kag/data/models/company_model.dart';
import 'package:flutter_kag/data/models/geo_model.dart';
import 'package:flutter_kag/data/models/user_model.dart';
import 'package:flutter_kag/data/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  final formKey = GlobalKey<FormState>();
  final LocalAuthentication localAuth = LocalAuthentication();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  RxBool loading = false.obs;
  RxBool passwordVisible = false.obs;
  RxBool buttonFingerprintVisible = false.obs;
  String? imei;
  bool isSupport = false;
  bool haveBiometric = false;

  @override
  void onInit() {
    checkLocalAuth();
    super.onInit();
  }

  @override
  void dispose() {
    emailCtr.dispose();
    passwordCtr.dispose();
    super.dispose();
  }

  checkLocalAuth() async {
    isSupport = await localAuth.isDeviceSupported();
    haveBiometric = await localAuth.canCheckBiometrics;

    if (isSupport && haveBiometric) {
      final List<BiometricType> availableBiometrics =
          await localAuth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.strong)) {
        buttonFingerprintVisible.value = true;
      }
    }
  }

  Future<bool> getPhonePermission() async {
    final PermissionStatus permission = await Permission.phone.status;
    if (permission.isGranted) {
      return true;
    } else {
      final permissionStatus = await Permission.phone.request();
      if (permissionStatus.isGranted) {
        return true;
      }
      return false;
    }
  }

  Future<String?> checkImei() async {
    try {
      bool havePermission = await getPhonePermission();
      if (havePermission) {
        return 'IMEI : ${await DeviceInformation.deviceIMEINumber}';
      } else {
        toast('Phone permission denied');
        return '';
      }
    } on PlatformException {
      return '';
    }
  }

  fingerprintAuth() async {
    if (isSupport && haveBiometric) {
      final bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Please authenticate to login',
          options: const AuthenticationOptions(
              biometricOnly: true, useErrorDialogs: false));
      if (didAuthenticate) {
        loading.value = true;
        final company = Company(
            name: 'PT. Nur Hamid', bs: 'Jl. Kemayoran', catchPhrase: 'Jakarta');
        final address = Address(
          street: 'Jl. Panjang',
          suite: 'Grogol',
          city: 'Jakarta',
          zipcode: '11470',
          geo: Geo(lat: '-6.172243', lng: '106.785995'),
        );

        final user = UserModel(
            id: 1 + Random().nextInt(9),
            name: 'Nur Hamid',
            username: 'nurhamid',
            email: 'nurhamid05@gmail.com',
            phone: "+6281368233580",
            website: "nurhamid.site",
            address: address,
            company: company);

        await Storage.setLoginData(user);
        await Storage.setlogin();
        ToastUtil.showSnackBar('Info', 'Login Success', ToastStatus.success);
        Get.offAndToNamed('/homePage');
        loading.value = false;
      }
    }
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
