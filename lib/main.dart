import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:MeetingYuk/bindings/app_binding.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'app_routes.dart';


void main() async {
  await GetStorage.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Figtree',
          scaffoldBackgroundColor: backgroundColor,
      ),
      initialBinding: AppBinding(),
      initialRoute: '/',
      getPages: AppRoutes.appRoutes(),
    );
  }
}
