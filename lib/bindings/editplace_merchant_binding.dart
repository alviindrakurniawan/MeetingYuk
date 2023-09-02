import 'package:get/get.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/view_model/edit_place_viewmodel.dart';



class EditPlaceMerchantBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EditPlaceViewModel>(EditPlaceViewModel());
  }
}