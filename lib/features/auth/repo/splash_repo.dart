import 'package:get/get.dart';
import 'dart:async';
import 'package:get_storage/get_storage.dart';

class SplashRepository{
 GetStorage storage = GetStorage();

  void isLogin(){
    bool isLoggedIn = storage.read('isLoggedIn') ?? false;
    int isMerchant = storage.read('is_merchant');
    String routeName = isLoggedIn
        ? isMerchant==1
          ?'/home-merchant'
          :'/home'
        : '/login';
    Timer( Duration(seconds: 2),()=>
        Get.offAllNamed(routeName));
  }
}