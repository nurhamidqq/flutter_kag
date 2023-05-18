import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kag/app/config/colors.dart';
import 'package:flutter_kag/app/widgets/button_custom.dart';
import 'package:flutter_kag/app/widgets/form_custom.dart';
import 'package:flutter_kag/presentation/login/controller.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: AppColors.secondary,
            body: Stack(
              children: [
                const BgWidget(),
                FormLogin(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({super.key, required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 25),
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  FormCustom(
                    controller: controller.emailCtr,
                    keyboardType: TextInputType.emailAddress,
                    context: context,
                    label: 'Enter your email address',
                    iconRight: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(' '),
                    ],
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !GetUtils.isEmail(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => FormCustom(
                      readonly: controller.loading.value,
                      controller: controller.passwordCtr,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: controller.passwordVisible.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      context: context,
                      label: 'Enter your password',
                      maxLength: 30,
                      iconRight: true,
                      obscureText:
                          controller.passwordVisible.value ? false : true,
                      onTapRightIcon: () => controller.passwordVisible.value =
                          !controller.passwordVisible.value,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Please enter valid password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => SizedBox(
                      height: 45,
                      width: Get.width - 32,
                      child: ButtonCustom(
                        isLoading: controller.loading.value,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          controller.login();
                        },
                        label: 'Login',
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.lock_person_outlined,
                    color: AppColors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BgWidget extends StatelessWidget {
  const BgWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Get.height / 2.5),
      child: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}
