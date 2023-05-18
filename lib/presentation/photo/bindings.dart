import 'package:get/get.dart';

import 'controller.dart';

class PhotoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoController>(() => PhotoController());
  }
}
