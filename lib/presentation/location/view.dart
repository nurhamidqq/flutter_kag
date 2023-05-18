import 'package:flutter/material.dart';
import 'package:flutter_kag/app/config/colors.dart';
import 'package:flutter_kag/presentation/location/controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LocationPage extends GetView<LocationController> {
  const LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.white,
              ),
            ),
            backgroundColor: AppColors.primary,
            title: Text("Location ${controller.dataLogin.name}"),
          ),
          body: Stack(
            children: [
              SlidingUpPanel(
                controller: controller.panelController,
                minHeight: Get.height / 4,
                maxHeight: Get.height / 1.9,
                parallaxEnabled: true,
                parallaxOffset: .5,
                body: GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  markers: {
                    Marker(
                      markerId: const MarkerId("userLocation"),
                      position: controller.latLng ?? controller.latLngDefault,
                      infoWindow: InfoWindow(
                          title: '${controller.dataLogin.name} Location'),
                    ),
                  },
                  initialCameraPosition: controller.cameraPosition ??
                      CameraPosition(target: controller.latLngDefault, zoom: 4),
                  onMapCreated: (GoogleMapController con) {
                    if (!controller.mapController.isCompleted) {
                      controller.mapController.complete(con);
                    }
                  },
                ),
                panelBuilder: (sc) {
                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 8,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.softGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          controller: sc,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            Text(
                              'Detail Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'User ID :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral,
                              ),
                            ),
                            Text(
                              controller.dataLogin.id.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.neutral,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Name :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral,
                              ),
                            ),
                            Text(
                              controller.dataLogin.name ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.neutral,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Username :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral,
                              ),
                            ),
                            Text(
                              controller.dataLogin.username ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.neutral,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Email :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral,
                              ),
                            ),
                            Text(
                              controller.dataLogin.email ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.neutral,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.neutral,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Street :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral,
                              ),
                            ),
                            Text(
                              controller.dataLogin.address?.street ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.neutral,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Suite :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral,
                              ),
                            ),
                            Text(
                              controller.dataLogin.address?.suite ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.neutral,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'City :',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral,
                              ),
                            ),
                            Text(
                              controller.dataLogin.address?.city ?? '',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.neutral,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Material(
                  color: AppColors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(50),
                  child: InkWell(
                    onTap: () => controller.setFocus(),
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: Image.asset('assets/focus.png'),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
