import 'package:get/get.dart';
import 'package:meetingyuk/features/home/view_model/reservation_viewmodel.dart';



class DetailPlaceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ReservationViewModel>(ReservationViewModel());
  }
}