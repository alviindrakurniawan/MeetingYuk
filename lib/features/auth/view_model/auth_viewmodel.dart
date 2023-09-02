import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meetingyuk/features/auth/repo/auth_repo.dart';
import 'package:meetingyuk/ulits/notif.dart';

class AuthViewModel extends GetxController {
  final AuthRepository _api = AuthRepository();
  final storage = GetStorage();

  final namaController = TextEditingController();
  final telpController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final namaFocusNode = FocusNode();
  final telpFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  var passwordObscure = true.obs;
  var loading = false.obs;

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Nama Wajib Diisi";
    } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
      return "Fill the name with a combination of lowercase and uppercase letters";
    } else {
      return null;
    }
  }

  String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return "Nomer Wajib Diisi";
    } else if (!RegExp(
        r'^((\+62)|0)\d{6,11}$')
        .hasMatch(value)) {
      return "Minimum 8 Number & Maximum 13 Number";
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email Wajib Diisi";
    } else if (!RegExp(
            r"^[a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Enter The E-mail According to The Format";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Passwords Wajib Diisi";
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d).{8,}$')
        .hasMatch(value)) {
      return "Minimum 8 Characters, 1 Capital, 1 Lowercase , 1 Number";
    } else {
      return null;
    }
  }

  void togglePasswordVisibility() {
    passwordObscure.value = !passwordObscure.value;
  }

  // Future register() async {
  //   var response;
  //   try {
  //     loading.value = true;
  //
  //     Map<String, dynamic> data = {
  //       'name': namaController.text,
  //       'email': emailController.text,
  //       'phone': telpController.text,
  //       'password': passwordController.text
  //     };
  //
  //     response = await _api.register(data);
  //     print(response.body);
  //     if(response.status.hasError){
  //       loading.value = false;
  //       var message = 'An error occurred';
  //       if(response is Map && response.containsKey('message')) {
  //         message = response['message'];
  //       }
  //         Notif.snackBar('Error', message);
  //     } else {
  //       loading.value = false;
  //       Get.offNamed('/login');
  //       Notif.snackBar('Register', 'Register successfully');
  //     }
  //   } catch (e) {
  //     loading.value = false;
  //
  //     Notif.snackBar('Error', e.toString());
  //
  //
  //   }
  // }
  Future register() async {
    loading.value = true;

    Map<String, dynamic> data = {
      'name': namaController.text,
      'email': emailController.text.toLowerCase(),
      'phone': telpController.text,
      'password': passwordController.text
    };

    _api.register(data).then((value) {
      print('regis:$value');
      print(value["code"]);
      if (value["code"] == 200) {
        loading.value = false;
        Get.offNamed('/login');
        Notif.snackBar('Register', 'Register successfully');
      } else {
        Notif.snackBar('Error', _capitalizeword(value['message']));
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Notif.snackBar('Error', _capitalizeword(error.toString()));
    });
  }

  Future login() async {
    loading.value = true;

    Map<String, dynamic> data = {
      'email_phone': emailController.text,
      'password': passwordController.text
    };
    print(data);
    _api.login(data).then((value) {
      print(value);
      if (value['code'] == 200) {
        loading.value = false;
        storage.write('userId', value['data']['id']);
        storage.write('is_merchant', value['data']['is_merchant']);
        // if (value['data']['profile_image_url']!=''){
        //   storage.write('profile_image_url',value['data']['profile_image_url']);}
        storage.write('isLoggedIn', true);
        Notif.snackBar('Login', 'Login successfully');
        loading.value = false;
        if(storage.read('is_merchant')==0){
          storage.write('public_key','');
          Get.offAllNamed('/home');
        }else{
          storage.write('public_key','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh9li1m0VWUjN2wZiCX46k9U3aAgfJ6WKkW0Y6MP30n2ajScZUFqj2eB3w7qHyLJAXVAxXe0E2sxtO20mRphOtv91fRjWj2nLXGKi//jZb/JewZvvgXRIi5JAZQlL5ChrBpNf8RRFscj2HzBNyNlZd0GrOwYoyf8+fSGO8Sj4tDrcq0FctCEqww7eUEP8+4VKOYSnwmMtnowxmeEv6hNUz0hHx2qiT425YtOIwRB0H5B773oTsZH9o04343ZlU+8H/3TEU1QA/OZU+S45jc6tmy9cmS+wulsyB1ps3XMAorvVkDcEBZTvJGr2iO/R4pfT8DW0PtzqwcWxiqkn40ZnZQIDAQAB');
          Get.offAllNamed('/home-merchant');
        }
      } else {
        print(value);
        Notif.snackBar('Error', _capitalizeword(value['message']));
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      print('error disini');
      Notif.snackBar('Error', _capitalizeword(error.toString()));
      loading.value = false;
    });
  }

  String _capitalizeword(String sentence) {
    List<String> words = sentence.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(' ');
  }
}
