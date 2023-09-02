
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:meetingyuk/ulits/color.dart';
class Notif {


  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode  nextFocus ){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //
  // static toastMessage(String message){
  //   Fluttertoast.showToast(
  //     msg: message ,
  //     backgroundColor: blackColor ,
  //     textColor: whiteColor,
  //     gravity: ToastGravity.BOTTOM,
  //     toastLength: Toast.LENGTH_LONG,
  //
  //
  //   );
  // }
  //
  //
  // static toastMessageCenter(String message){
  //   Fluttertoast.showToast(
  //     msg: message ,
  //     backgroundColor: blackColor ,
  //     gravity: ToastGravity.BOTTOM,
  //     toastLength: Toast.LENGTH_LONG,
  //     textColor: whiteColor,
  //   );
  // }

  static snackBar(String title, String message){
    Get.snackbar(
      title,
      message ,
    );
  }

  static buttomSnackBar(String title, String message){
    Get.showSnackbar(
      GetSnackBar(
        title:title,
        message:message,
        duration: const Duration(seconds: 3),
      )
    );
  }




}