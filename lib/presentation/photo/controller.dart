import 'package:flutter_kag/data/models/album_model.dart';
import 'package:flutter_kag/data/models/photo_model.dart';
import 'package:flutter_kag/data/repositories/photo_repository.dart';
import 'package:get/get.dart';

class PhotoController extends GetxController {
  final PhotoRepository _photoRepository = PhotoRepository();
  var args = Get.arguments;
  AlbumModel? album;
  RxBool loading = false.obs;
  List<PhotoModel> listPhoto = [];
  @override
  void onInit() {
    if (args != null) {
      album = args['album'];
      getListPhoto();
    }
    super.onInit();
  }

  getListPhoto() async {
    loading.value = true;
    final response =
        await _photoRepository.getListPhoto(albumId: album?.id ?? 0);
    if (response != null) {
      listPhoto = response;
    } else {
      listPhoto = [];
    }
    loading.value = false;
  }
}
