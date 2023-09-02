import 'package:get/get.dart';
import 'package:meetingyuk/features/home/view_model/reservation_viewmodel.dart';



class ReservationBinding implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => ReservationViewModel(),fenix : true);
    Get.put<ReservationViewModel>(ReservationViewModel());
  }
}