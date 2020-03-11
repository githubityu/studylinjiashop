import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:studylinjiashop/config/storage_manager.dart';
import 'package:studylinjiashop/page/splash_page.dart';
import 'package:studylinjiashop/routes/fluro_navigator.dart';

import 'routes/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
}

class MyApp extends StatelessWidget {
  final Widget home;

  MyApp({this.home}) {
    NavigatorUtils.initRouter();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //        debugShowCheckedModeBanner: false,
      home: home ?? SplashPage(),
      navigatorKey: Application.navKey,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
