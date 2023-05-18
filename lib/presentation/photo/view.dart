import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kag/app/config/colors.dart';
import 'package:flutter_kag/app/widgets/loading.dart';
import 'package:flutter_kag/presentation/photo/controller.dart';
import 'package:flutter_kag/presentation/photo/detail_page.dart';
import 'package:get/get.dart';

class PhotoPage extends GetView<PhotoController> {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back_ios_new_rounded,
                          color: AppColors.white),
                    ),
                    Text(
                      'Album ${controller.album?.id}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () => false,
                      icon: const Icon(Icons.info, color: Colors.transparent),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Obx(
                    () => controller.loading.value
                        ? LoadingIndicator(color: AppColors.primary)
                        : controller.listPhoto.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Photo Not Found',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  IconButton(
                                    onPressed: () => controller.getListPhoto(),
                                    icon: Icon(
                                      Icons.refresh,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              )
                            : RefreshIndicator(
                                color: AppColors.primary,
                                onRefresh: () => controller.loading.value
                                    ? false
                                    : controller.getListPhoto(),
                                child: GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Get.to(
                                        () => DetailPage(
                                          imageUrl:
                                              controller.listPhoto[index].url ??
                                                  '',
                                          title: controller
                                                  .listPhoto[index].title ??
                                              '',
                                          tag: 'image$index',
                                        ),
                                      ),
                                      child: Hero(
                                        tag: 'image$index',
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              controller.listPhoto[index].url ??
                                                  '',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  LoadingIndicator(
                                                      color: AppColors.primary),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: controller.listPhoto.length,
                                ),
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
