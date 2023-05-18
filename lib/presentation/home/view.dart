import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kag/app/config/colors.dart';
import 'package:flutter_kag/app/utils/storage.dart';
import 'package:flutter_kag/app/widgets/loading.dart';
import 'package:flutter_kag/presentation/home/controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Scaffold(
        backgroundColor: AppColors.secondary,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 180,
              backgroundColor: AppColors.primary,
              leading: GestureDetector(
                onTap: () => Get.toNamed('/locationPage'),
                child: const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Icon(Icons.location_on_outlined),
                ),
              ),
              floating: false,
              pinned: true,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12, top: 10),
                  child: GestureDetector(
                      onTap: () => Storage.setLogout(),
                      child: const Icon(Icons.power_settings_new)),
                )
              ],
              bottom: TabBar(
                indicatorColor: AppColors.white,
                controller: controller.tabController,
                unselectedLabelStyle: TextStyle(
                  color: AppColors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                labelStyle: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [Tab(text: 'Album'), Tab(text: 'Info')],
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: const EdgeInsetsDirectional.only(bottom: 60),
                title: Text(controller.dataLogin.name ?? ''),

                // background: Container(
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage('assets/bg.png'),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                background: Container(color: AppColors.primary),
              ),
            ),
          ],
          body: TabBarView(
            controller: controller.tabController,
            children: [
              TabAlbum(controller: controller),
              TabInfo(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class TabAlbum extends StatelessWidget {
  const TabAlbum({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? LoadingIndicator()
          : controller.listAlbum.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Album Not Found',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    IconButton(
                      onPressed: () => controller.getListAlbum(),
                      icon: Icon(
                        Icons.refresh,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                )
              : RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () async => controller.loading.value
                      ? false
                      : controller.getListAlbum(),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: controller.listAlbum.length,
                    itemBuilder: (context, i) => Material(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        splashColor: AppColors.primary,
                        onTap: () => Get.toNamed('/photoPage',
                            arguments: {'album': controller.listAlbum[i]}),
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Album ${controller.listAlbum[i].id}',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                controller.listAlbum[i].title ?? '',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}

class TabInfo extends StatelessWidget {
  const TabInfo({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('ID'),
                SizedBox(height: 12),
                Text('Name'),
                SizedBox(height: 12),
                Text('Username'),
                SizedBox(height: 12),
                Text('Email'),
                SizedBox(height: 12),
                Text('Address'),
                SizedBox(height: 12),
                Text('Phone'),
                SizedBox(height: 12),
                Text('Website'),
                SizedBox(height: 12),
                Text('Company'),
              ],
            ),
          ),
          const SizedBox(width: 20),
          DefaultTextStyle(
            style: const TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(': ${controller.dataLogin.id}'),
                const SizedBox(height: 12),
                Text(': ${controller.dataLogin.name}'),
                const SizedBox(height: 12),
                Text(': ${controller.dataLogin.username}'),
                const SizedBox(height: 12),
                Text(': ${controller.dataLogin.email}'),
                const SizedBox(height: 12),
                Text(': ${controller.dataLogin.address?.street}'),
                const SizedBox(height: 12),
                Text(': ${controller.dataLogin.phone}'),
                const SizedBox(height: 12),
                Text(': ${controller.dataLogin.website}'),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(': ${controller.dataLogin.company?.name}'),
                    Text('  ${controller.dataLogin.company?.catchPhrase}'),
                    Text('  ${controller.dataLogin.company?.bs}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
