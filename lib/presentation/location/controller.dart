import 'dart:async';

import 'package:flutter_kag/app/utils/storage.dart';
import 'package:flutter_kag/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LocationController extends GetxController {
  LocationController();
  UserModel get dataLogin => Storage.getLoginData;
  Completer<GoogleMapController> mapController = Completer();
  final PanelController panelController = PanelController();
  LatLng? latLng;
  LatLng latLngDefault = const LatLng(-6.1827497, 106.812265);
  CameraPosition? cameraPosition;

  @override
  void onInit() {
    latLng = LatLng(double.parse(dataLogin.address?.geo?.lat ?? '-6.1827497'),
        double.parse(dataLogin.address?.geo?.lng ?? '106.812265'));
    cameraPosition = CameraPosition(target: latLng ?? latLngDefault, zoom: 1);
    super.onInit();
  }

  setFocus() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        cameraPosition ??
            CameraPosition(target: latLng ?? latLngDefault, zoom: 1),
      ),
    );
  }
}
