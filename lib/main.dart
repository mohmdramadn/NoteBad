import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_bad/providers.dart';
import 'package:note_bad/routes/router.dart';
import 'package:note_bad/routes/router_names.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        onGenerateRoute: onGenerateRoute,
        initialRoute: homeRoute,
        defaultTransition: Transition.cupertino,
        opaqueRoute: Get.isOpaqueRouteDefault,
      ),
    );
  }
}
