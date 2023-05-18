import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_kag/app/utils/storage.dart';
import 'package:flutter_kag/data/models/album_model.dart';
import 'package:flutter_kag/data/models/user_model.dart';
import 'package:flutter_kag/data/repositories/album_repository.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  UserModel get dataLogin => Storage.getLoginData;
  final AlbumRepository _albumRepository = AlbumRepository();
  late TabController tabController;
  List<AlbumModel> listAlbum = [];
  RxBool loading = false.obs;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  @override
  void onInit() {
    tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 500),
    );
    getListAlbum();
    super.onInit();
  }

  getListAlbum() async {
    loading.value = true;
    final response = await _albumRepository.getListAlbum(idUser: dataLogin.id!);
    if (response != null) {
      listAlbum = response;
    } else {
      listAlbum = [];
    }
    loading.value = false;
  }
}
