import 'package:flutter_kag/presentation/home/bindings.dart';
import 'package:flutter_kag/presentation/home/view.dart';
import 'package:flutter_kag/presentation/location/bindings.dart';
import 'package:flutter_kag/presentation/location/view.dart';
import 'package:flutter_kag/presentation/login/bindings.dart';
import 'package:flutter_kag/presentation/login/view.dart';
import 'package:flutter_kag/presentation/photo/bindings.dart';
import 'package:flutter_kag/presentation/photo/view.dart';
import 'package:flutter_kag/presentation/splash/bindings.dart';
import 'package:flutter_kag/presentation/splash/view.dart';
import 'package:get/get.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: '/splashPage',
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/loginPage',
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/homePage',
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/photoPage',
      page: () => const PhotoPage(),
      binding: PhotoBinding(),
    ),
    GetPage(
      name: '/locationPage',
      page: () => const LocationPage(),
      binding: LocationBinding(),
    ),
  ];
}
