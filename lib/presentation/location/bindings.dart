import 'package:get/get.dart';

import 'controller.dart';

class LocationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(() => LocationController());
  }
}
