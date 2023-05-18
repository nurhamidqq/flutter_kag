import 'package:flutter/material.dart';
import 'package:flutter_kag/app/config/colors.dart';
import 'package:flutter_kag/app/widgets/loading.dart';
import 'package:flutter_kag/presentation/splash/controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: LoadingIndicator(),
        );
      },
    );
  }
}
