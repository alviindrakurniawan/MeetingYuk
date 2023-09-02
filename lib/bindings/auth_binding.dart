
import 'package:get/get.dart';
import 'package:meetingyuk/features/auth/repo/auth_repo.dart';
import 'package:meetingyuk/features/auth/view_model/auth_viewmodel.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthViewModel>(() => AuthViewModel());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
  }
}