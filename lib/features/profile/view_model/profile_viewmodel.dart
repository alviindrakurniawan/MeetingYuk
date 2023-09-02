import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meetingyuk/features/profile/model/userData.dart';
import 'package:meetingyuk/features/profile/repo/profile_repo.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends GetxController {
  final ProfileRepository _api = ProfileRepository();
  final storage = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    await getDetailProfile();
  }


  // fetch from api and insert it to text editing controller
  final nameController = TextEditingController();
  final telpController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final namaFocusNode = FocusNode();
  final telpFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool passwordObscure = true;
  var loading = false.obs;
  var loadingImage = false.obs;

  var imageUrl= 'default'.obs;
  var account = ''.obs;

  // void checkAccount (){
  //   getDetailProfile();
  // }


  void togglePasswordVisibility() {
    passwordObscure = !passwordObscure;
    update();
  }


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
    } else if (!RegExp(r'^((\+62)|0)\d{6,11}$').hasMatch(value)) {
      return "Enter The Phone Number According to Number Format";
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
      return "Minimum 8 Characters, 1 Capital Letter, 1 Lowercase Letter, 1 Number";
    } else {
      return null;
    }
  }


  Future getDetailProfile() async {
    loading.value = true;
    _api.getDetailProfile().then((value) {
      if (value["code"] == 200) {
        loading.value = false;

        nameController.text = value['data']['name'];
        emailController.text = value['data']['email'];
        telpController.text = value['data']['phone'];

        if (value['data']['is_merchant']==0){
          account.value = 'MeetingYuk Account';
        }else{
          account.value = 'MerchantYuk Account';
        }


        if(value['data']['profile_image_url']!= ''){
          print('tidak kosong');
          imageUrl.value = value['data']['profile_image_url'];
        }
      }else {
        Notif.snackBar('Error', _capitalizeword(value['message']));
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      if(error.toString().contains('Token Expired')){
        Get.offAllNamed('/login');
      }
      Notif.snackBar('Error', _capitalizeword(error.toString()));

    });
  }

  Future openImagePicker() async {
    loadingImage.value = true;

    final picker = ImagePicker();
    final XFile? pickedImage =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final form = FormData({
        'image': MultipartFile(File(pickedImage.path),filename: pickedImage.path.split('/').last)
      });
      print(pickedImage.path.split('/').last);

      _api.updateProfileImage(form).then((value) {
        print('upload image: $value');
        if (value["code"] == 200) {
          loadingImage.value = false;

          imageUrl.value = value['data']['profile_image_url'];

          Notif.snackBar('Image Profile Update', 'Success');
        } else {
          Notif.snackBar('Error', _capitalizeword(value['message']));
          loadingImage.value = false;
        }
      }).onError((error, stackTrace) {
        loadingImage.value = false;
        Notif.snackBar('Error', _capitalizeword(error.toString()));
      });
    }
  }

  Future putPhotoProfile() async {
    loading.value = true;
  }

  Future putProfile() async {
    loading.value = true;

    Map<String, dynamic> data;

    data = {
      'name': nameController.text,
      'email': emailController.text.toLowerCase(),
      'phone': telpController.text,
      'password': passwordController.text
    };

    _api.updateProfile(data).then((value) {
      if (value["code"] == 200) {
        loading.value = false;
        Get.back();
        Notif.snackBar('Profile Update', 'Success');
      } else {
        Notif.snackBar('Error', _capitalizeword(value['message']));
        loading.value = false;
        Get.back();
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Get.back();
      Notif.snackBar('Error', _capitalizeword(error.toString()));
    });
  }

  Future updrageMerchant() async {
    loading.value = true;
    _api.upgradeMerchant().then((value) {
      if (value["code"] == 200) {
        storage.write('is_merchant', value['data']['is_merchant']);
        loading.value = false;
        Get.back();
        Notif.snackBar('Upgrade Merchant', 'Success');
      } else {
        Get.back();
        Notif.snackBar(
            'Upgrade Merchant Failed', _capitalizeword(value['message']));
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Get.back();
      Notif.snackBar('Error', _capitalizeword(error.toString()));
    });
  }

  Future logout() async {
    loading.value = true;
    _api.logout().then((value) {
      if (value["code"] == 200) {
        loading.value = false;
        storage.remove('userId');
        storage.remove('is_merchant');
        storage.remove('isLoggedIn');
        storage.remove('Cookie');

        Get.offAllNamed('/login');
        Notif.snackBar('Log Out', 'Success');
      } else {
        Notif.snackBar('Logout Failed', _capitalizeword(value['message']));
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Notif.snackBar('Error', _capitalizeword(error.toString()));
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
