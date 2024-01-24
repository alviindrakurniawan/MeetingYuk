import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:MeetingYuk/features/auth/model/user_model.dart';
import 'package:MeetingYuk/features/profile/repo/profile_repo.dart';
import 'package:MeetingYuk/common/ulits/notif.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends GetxController {
  final ProfileRepository _api = ProfileRepository();
  final storage = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    currentUser.value.publicKey=storage.read('public_key');
    currentUser.value.userId=storage.read('userId');
    await getDetailProfile();
  }



  // fetch from api and insert it to text editing controller
  final nameController = TextEditingController();
  final IdController = TextEditingController();
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

  var imageUrl = 'default'.obs;
  var nameAccount=''.obs;
  var account = ''.obs;


  Rx<UserModel>currentUser = UserModel(
      name: '',
      userId: '',
      profilePic: '',
      isMerchant: 0,
      phoneNumber: '',
      publicKey: '').obs;

  List<XFile>? images = [];
  List<String> listImagePath = [];
  var selectedFileCount =0.obs;



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
        // IdController.text = currentUser.value.userId;

        currentUser.value.name= value['data']['name'];
        currentUser.value.phoneNumber= value['data']['phone'];
        print(value['data']['phone']);
        print('/////');
        print(currentUser.value.name);
        print('/////');
        currentUser.value.profilePic=value['data']['profile_image_url'];


        if (value['data']['is_merchant'] == 0) {
          account.value = 'MeetingYuk Account';
        } else {
          account.value = 'MerchantYuk Account';
        }


        if (value['data']['profile_image_url'] != '') {
          print('tidak kosong');
          imageUrl.value = value['data']['profile_image_url'];
        }
      } else {
        Notif.snackBar('Error', _capitalizeword(value['message']));
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      if (error.toString().contains('Token Expired')) {
        Get.offAllNamed('/login');
      }
      Notif.snackBar('Error', _capitalizeword(error.toString()));
    });
  }

  void selectMultipleImage()async{
    final picker = ImagePicker();
    images = await picker.pickMultiImage();
    if(images != null){
      for(XFile file in images!){
        listImagePath.add(file.path);
      }
      print('eee');
      print(listImagePath[0]);
      uploadImage();

    }else{
      Notif.snackBar('Fail', 'No Images selected');
    }
    selectedFileCount.value=listImagePath.length;
  }

  Future uploadImage()async{
    try{
      final form = FormData({});
      for(String path in listImagePath){
        form.fields.add(MapEntry("image",MultipartFile(File(path), filename: "${DateTime.now().millisecondsSinceEpoch}.${path.split('.').last}").toString()));
      }
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

    }catch(exception){
      return Future.error(exception.toString());
    }
  }

  Future openImagePicker_test() async {
    loadingImage.value = true;

    final picker = ImagePicker();
    print('1');
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    print('2');
    if (pickedImage != null) {
      print('3');
      final form = FormData({
        'image': MultipartFile(File(pickedImage.path), filename: pickedImage.name),
      });
      print(form)
;      print('4');

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

  // File Changes
  Future openImagePicker() async {
    loadingImage.value = true;

    final picker = ImagePicker();
    print('1');
    final XFile? pickedImage =
    await picker.pickImage(source: ImageSource.gallery);
    print('2');

    if (pickedImage != null) {
      print('3');
      final FormData form = FormData({
        'image': MultipartFile(
            File(pickedImage.path), filename: pickedImage.name)
      });
      print(form.files);
      print(form);
      print(pickedImage.path);
      print(pickedImage.name);

      // Print files
      print('\nFiles:');
      form.files.forEach((file) {
        print('Field name: ${file.key}');
        print('File name: ${file.value.filename}');
      });

     await _api.updateProfileImage(form).then((value) {
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
        Get.offAllNamed('/login');
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
