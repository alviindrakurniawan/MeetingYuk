import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:MeetingYuk/features/auth/model/user_model.dart';
import 'package:MeetingYuk/features/auth/repo/auth_repo.dart';
import 'package:MeetingYuk/common/ulits/notif.dart';

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


  Rx<UserModel> currentUser = UserModel(
    name: '',
    userId: '',
    profilePic: '',
    isMerchant: 0,
    phoneNumber: '',
    publicKey: '',
  ).obs;



  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Please Fill This Section";
    } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
      return "Fill the name with a combination of lowercase and uppercase letters";
    } else {
      return null;
    }
  }

  String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return "Please Fill This Section";
    } else if (!RegExp(
        r'^((\+62)|0)\d{6,12}$')
        .hasMatch(value)) {
      return "Minimum 8 Number & Maximum 13 Number";
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please Fill This Section";
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
      return "Please Fill This Section";
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
      print('test 1');
      if (value['code'] == 200) {
        loading.value = false;
        storage.write('userId', value['data']['id']);
        storage.write('is_merchant', value['data']['is_merchant']);
        storage.write('isLoggedIn', true);
        Notif.snackBar('Login', 'Login successfully');
        loading.value = false;
        if(storage.read('is_merchant')==0){
          storage.write('public_key','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0cptgZtA2CYnV9ItaMlJ0JtdrxXO6scy4rUCTywUFusu9pVBSxdGsNTjPd7CFHQ+tC2856efU7Dx2zU6tiHvSmjIJR0jPIYBgM/Wrznk8+KM4/SK4WY3ABr8Fro/4k6CpIo0MGz3FBMoC/Xy8QNNq7BPQXl4yk+dHI8whGAV23rYsyOrlt+FWKv3DsitTILg53e7/W8215RbJUiApWPSyGakeub6QvA623vx5OrHBoJMoVcoIMLPnRcxY8sHr8T5rj8rHf1ATkXW3gilYQO1pFrUvpXO1oCTMmbkwfxzNvvmMf2+udnCnfg7nN3VoiSKH4CyPafHK9h7/c9303GfrQIDAQAB');
          storage.write('private_key','MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDRym2Bm0DYJidX0i1oyUnQm12vFc7qxzLitQJPLBQW6y72lUFLF0aw1OM93sIUdD60Lbznp59TsPHbNTq2Ie9KaMglHSM8hgGAz9avOeTz4ozj9IrhZjcAGvwWuj/iToKkijQwbPcUEygL9fLxA02rsE9BeXjKT50cjzCEYBXbetizI6uW34VYq/cOyK1MguDnd7v9bzbXlFslSIClY9LIZqR65vpC8Drbe/Hk6scGgkyhVyggws+dFzFjywevxPmuPysd/UBORdbeCKVhA7WkWtS+lc7WgJMyZuTB/HM2++Yx/b652cKd+Duc3dWiJIofgLI9p8cr2Hv9z3fTcZ+tAgMBAAECggEAOv1spVD+fsjbrzoOQrS26M2HHkBHmoTArjavm4uNapRe9D8ryO2WlwqFi1QjxpSZPRjPUWQ0zNeoajchdy07l/S2spjq243ixlGq0EK7OkitzTtqAc84D/OGhu2AISZqXdHust8w6pgoXpSd519Ca9B7uLFrYZfZWbp5rf9Gphv19Lyg5pwJLYUY0vTFwD2sROYjX/bdwFCu2JzFbeAxAJDIT7nwwOFq4/++SEKqvOeK2HuDkCpbuW0u62hyth5AxGz14hwVJNGyfe47dIDv5x2xzJr1kSZzL/PqPvkTEv3EZcLHEio5ceSFAr1ZICjuyU/UxYTSM3REWsvBK78AkQKBgQD/vZXYAY0kwIyyaueMF7f6MjAKbnM6enJOV6dfyyFkc5vdCMYXMKVwtZRSCkUCO3XBhGZhXkW3Ha7y/eC03ZWs1buSi3Y42fn7QHPaV/LFUcdLGfvtn0NxFjdNhabH83H3AswW5TiwmJF2DJ5yZJsKO9wIZiKzjlq+WWsRRafzXwKBgQDSAOjS0OCT6sZwQo7vdYlvethVEJeplFVZvxN1R1DzIJbd41gPGO4bJV46xsv1JJeh83RN55TE3xT/p3A2R3l/mOuyl0dqIT0kW9WtRMvAXfILo6VaIR9mXovNbfdJaIj/hx0HSFvIcqz4B3aDOfPCbZTMOC9zaPIL5PXSTnA0cwKBgQCBWOc/8FDuBMFkwDNKpPh1gArSS9jV+/Zyb10FU10ZTGvJ2NUwB3e10PEqqW0L2v0NGqUZnC/QlR/WYNfVQrmgSB3t2cG6sW0BSjEOfysX5+vPrV3BaqsWuHDSMcYQHa5Hi8+jyN3qW9A+j9VX8FCGVY5NZTMp89crrVg8zSlMKwKBgAnUuRGFbb3+86M1unNDUVfCrHXu/OqXYxd8dnC7EfMPx4BDsE+knyDuMucVf17Og7q1JvCusqw0tUryj7I6zllG02Hc6x7wx2f4VJxz6AXtX/Njic4aVtn3+xt21mi9WAx+SsGYhZNwquBBmS6ze9HSR3D4AGCqvQoJgeiCe4Y5AoGAOVwU9c7sfooDfA5r7XmjAeBkVf9zJIg/WAJpuBs20qYcdZaNVSls6VojTJz/kQIGU8T+SaL9eIshWCsqzYGM0SGWLBnrQNmhDCEVijWVQtTFoOIw0dxA4m/4KhBGt5ZOwG7WA+TqYz6TbNtfSI2NELi7CuUCfWXR52P+3GpbhEg=');
          Get.offAllNamed('/home');
        }else{
          storage.write('public_key','MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh9li1m0VWUjN2wZiCX46k9U3aAgfJ6WKkW0Y6MP30n2ajScZUFqj2eB3w7qHyLJAXVAxXe0E2sxtO20mRphOtv91fRjWj2nLXGKi//jZb/JewZvvgXRIi5JAZQlL5ChrBpNf8RRFscj2HzBNyNlZd0GrOwYoyf8+fSGO8Sj4tDrcq0FctCEqww7eUEP8+4VKOYSnwmMtnowxmeEv6hNUz0hHx2qiT425YtOIwRB0H5B773oTsZH9o04343ZlU+8H/3TEU1QA/OZU+S45jc6tmy9cmS+wulsyB1ps3XMAorvVkDcEBZTvJGr2iO/R4pfT8DW0PtzqwcWxiqkn40ZnZQIDAQAB');
          storage.write('private_key','MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCH2WLWbRVZSM3bBmIJfjqT1TdoCB8npYqRbRjow/fSfZqNJxlQWqPZ4HfDuofIskBdUDFd7QTazG07bSZGmE62/3V9GNaPactcYqL/+Nlv8l7Bm++BdEiLkkBlCUvkKGsGk1/xFEWxyPYfME3I2Vl3Qas7BijJ/z59IY7xKPi0OtyrQVy0ISrDDt5QQ/z7hUo5hKfCYy2ejDGZ4S/qE1TPSEfHaqJPjbli04jBEHQfkHvvehOxkf2jTjfjdmVT7wf/dMRTVAD85lT5LjmNzq2bL1yZL7C6WzIHWmzdcwCiu9WQNwQFlO8kavaI79Hil9PwNbQ+3OrBxbGKqSfjRmdlAgMBAAECggEAEQUwd/MU0KnpeL6U++F/z1PQbE1QMfRwpwXHMCqVWx73hSXX6xRgIQUZnEE7j+6dV9ObS8xNZmhkaySivgeJHS5mdvTstO0pWHrXN0DjZT41lwZFfK+oAyygusfuZTiXKCzAwYCrtrmZ9JBlvntU1Tc6D9wWsjAzkRPqR9a9Sj9CblxIgy/zmfRicKh/F7jOG26Gyl+Dov1ggeKwgg6DAaGQOECLhQz7YIoW10LXfk66ssZ2FxMtP7Qy2oROXlA9+7WGciR8sLF9uxWTWiBtytRkfKhsqOgH/6/mpc1h3ytqHz3jlgD5PnKYSbE4pc1DpGp6DnRubRu+eSZsrOqo4QKBgQDZM9Ndxag8L1JuZSXPncJS5MKshOg+6vGHtRFiAFHdLfyIwB9Z9QllKbY4Hnr+6v+sn0mnstgX6hWU6GkAVsC1gA6bt97nbcYTeCbrk2idGXZGNgo/45ga+tZWkAZLEnezmDhl5/cPQlEkZYq1ZNK/XLzTt/NvdvLDpS9cT+7leQKBgQCgHXWzX5IRV9gcVGgrbSqjJNlblRR7dABRjykVwSFuJciGIoz7K5QvYtDTAl8fbky/rW/HdCINSq6wbVhBdVIa4NBAYADv3m+27rO8G2Q6Pt9NKjfzTqZg2vJSLEAqnll69efFD1neR67LzNxq7wKMhs9xWXiPSqGue/lBSrfyTQKBgQDAd/ZC0BYGTwDCporc8TTzc5c2fQe4SUUCNmdS6mmgj1GKdITTmBldNZstG4VuQxuRAg2otwhaGKpLK69wB2/45aMMReEWPuYY9o22jwdSvu9ZxCVM/AcbUU+BoVqSR6ke0jKXyvfY47E3iWti1hcST8Fb81OaYFM7HzNan9JYMQKBgQCECKcVmpreGF1Kx0P7g5MkY2+l+OKiBv94QiC0IsXJifi4u+cb/Ey/YrInPw5n4dICQigqBpdJ9KrnK9Qabn+dUIQKgeBj7T6cUG0AkmntKgmEHWt0BQhoWER5BKqJOnk5T2yncMg/50a6Ip4kxCGK9mQ76XbkWrvHIc5iTBYyBQKBgQCXmVHmG/Q3diI3rwXWx+8xGG2kU2/PFfM9rPBZ2EeOA95JGdvAQb6GEprMjbx8OgwtUqNFlebGiywnc71lFtNGjPnO5AvDNRFusxUonwpM2zXeLsRYf9ke6CJzzykvxf6bHnna/wzaSXxn6m2wwrfbPao2urFDF+/eFj1G1+PjGw==');
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
