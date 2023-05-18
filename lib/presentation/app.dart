import 'package:flutter/material.dart';
import 'package:flutter_kag/app/config/env.dart';
import 'package:flutter_kag/app/config/pages.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "OpenSans"),
        initialRoute: '/splashPage',
        navigatorKey:
            Env.status == 'Development' ? Env.alice.getNavigatorKey() : null,
        getPages: AppPage.pages,
      ),
    );
  }
}
