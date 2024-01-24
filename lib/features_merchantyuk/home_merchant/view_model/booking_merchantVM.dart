import 'package:get/get.dart';
import 'package:MeetingYuk/features_merchantyuk/home_merchant/repo/booking_repo.dart';
import 'package:MeetingYuk/common/ulits/notif.dart';
import 'package:MeetingYuk/features/history/model/reservation.dart';
import 'dart:async';
import 'package:collection/collection.dart';

class BookingViewModel extends GetxController {
  final BookingRepo _api = BookingRepo();

  @override
  void onInit() async {
    super.onInit();
    await getReservation();
  }

  var loading = false.obs;
  var loadingButton = false.obs;
  var customerName = ''.obs;

  var reservationListRaw = <Reservation>[].obs;
  var selectedPlaces = <String>{}.obs;
  var groupedReservations = <String, List<Reservation>>{}.obs;

  void togglePlaceSelection(String placeName) {
    if (selectedPlaces.contains(placeName)) {
      selectedPlaces.remove(placeName);
    } else {
      selectedPlaces.add(placeName);
    }
  }

  Map<String, List<Reservation>> get groupByFilteredReservations {
    return groupBy<Reservation, String>(
      filteredReservations,  // Notice that we use filteredReservations here
          (obj) {
        DateTime date = DateTime.parse(obj.startAt);
        return "${date.day}-${date.month}-${date.year}";
      },
    );
  }

  List<Reservation> get filteredReservations {
    if(selectedPlaces.isEmpty){
      return reservationListRaw;
    }else{
      return reservationListRaw
          .where((reservation) => selectedPlaces.contains(reservation.placeName))
          .toList();
    }
  }


  Future<void> getReservation() async {
    loading.value = true;
    await _api.getReservation().then((value) {
      if (value["code"] == 200) {
      reservationListRaw.assignAll((value['data'] as List)
          .map((item) => Reservation.fromJson(item))
          .toList()
      );
      reservationListRaw.sort((a,b) => a.startAt.compareTo(b.startAt));

      groupedReservations.value = groupBy<Reservation, String>(
        reservationListRaw,
            (obj) {
          DateTime date = DateTime.parse(obj.startAt);
          return "${date.day}-${date.month}-${date.year}";
        },
      );

      loading.value = false;


    } else {
      Notif.snackBar('Get Reservation Failed', 'Please try again later');
      loading.value = false;
    }
  }).onError((error, stackTrace) {
    loading.value = false;
    print('ERROR GetReservation :$error');
    Notif.snackBar('Error', error.toString());
    });
  }

  Future<void> accReservation({required String reservationId}) async {
    loadingButton.value = true;
    await _api.accReservation(reservationId: reservationId).then((value) {
      if (value["code"] == 200) {
        Notif.snackBar('Accept Reservation', 'Success');
        loadingButton.value=false;
        Get.back();
        getReservation();
      } else {
        Notif.snackBar('Accept Reservation Failed', 'Please try again later');
        loadingButton.value=false;
      }
    }).onError((error, stackTrace) {
      loadingButton.value=false;
      print('ERROR accReservation :$error');
      Notif.snackBar('Error', error.toString());
    });
  }

  Future<void> rejectReservation({required String reservationId}) async {
    loadingButton.value = true;
    await _api.rejectReservation(reservationId: reservationId).then((value) {
      if (value["code"] == 200) {
        Notif.snackBar('Reject Reservation', 'Success');
        loadingButton.value=false;
        Get.back();
        getReservation();
      } else {
        Notif.snackBar('Reject Reservation Failed', 'Please try again later');
        loadingButton.value=false;
      }
    }).onError((error, stackTrace) {
      loadingButton.value=false;
      print('ERROR rejectReservation :$error');
      Notif.snackBar('Error', error.toString());
    });
  }

  Future<void> updatePayment({required String reservationId}) async {
    loadingButton.value = true;
    await _api.updatePayment(reservationId: reservationId).then((value) {
      if (value["code"] == 200) {
        Notif.snackBar('Update Payment', 'Success');
        loadingButton.value=false;
        Get.back();
        getReservation();
      } else {
        Notif.snackBar('Update Payment Failed', 'Please try again later');
        loadingButton.value=false;
      }
    }).onError((error, stackTrace) {
      loadingButton.value=false;
      print('ERROR updatePayment :$error');
      Notif.snackBar('Error', error.toString());
    });
  }

  Future<void> findUserId({required String userId}) async {
    await _api.checkUser(userId: userId).then((value) {
      if (value["code"] == 200) {
        customerName.value = value['data']['name'];
      } else {
        print('error');

      }
    }).onError((error, stackTrace) {
      print('ERROR getuserId :$error');
      Notif.snackBar('Error', error.toString());
    });
  }



  String getTime(String dateTime) {
    final dt = DateTime.parse(dateTime);
    final time =
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    return time;
  }

  String getDate(String dateTime) {
    final dt = DateTime.parse(dateTime);
    final time =
        "${dt.day.toString()}/${dt.month.toString()}/${dt.year.toString()}";
    return time;
  }



}
