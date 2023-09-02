import 'package:get/get.dart';
import 'package:meetingyuk/features_merchantyuk/home_merchant/repo/booking_repo.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:meetingyuk/features/history/model/reservation.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class BookingViewModel extends GetxController {
  final BookingRepo _api = BookingRepo();

  @override
  void onInit() async {
    super.onInit();
    await getReservation();
  }

  var loading = false.obs;

  var reservationListRaw = <Reservation>[].obs;
  var selectedPlaces = <String>{}.obs;

  void togglePlaceSelection(String placeName) {
    if (selectedPlaces.contains(placeName)) {
      selectedPlaces.remove(placeName);
    } else {
      selectedPlaces.add(placeName);
    }
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


  TextEditingController searchbar = TextEditingController();

  Future<void> getReservation() async {
    loading.value = true;
    await _api.getReservation().then((value) {
      if (value["code"] == 200) {

      //belum sort
      reservationListRaw.assignAll((value['data'] as List)
          .map((item) => Reservation.fromJson(item))
          .toList()
      );

      reservationListRaw.sort((a,b) => b.updatedAt.compareTo(a.updatedAt));
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

// Future<void> getBestRated() async {
//   loadingBestRated.value = true;
//   await _api
//       .getAllPlace().then((value) {
//     if (value["code"] == 200) {
//       print('best rated: ${value['data']}');
//       //belum sort
//       bestRatedList.assignAll((value['data'] as List)
//           .map((item) => Place.fromJson(item))
//           .toList()
//       );
//
//       bestRatedList.sort((a, b) => b.ratings.compareTo(a.ratings));
//       loadingBestRated.value = false;
//     } else {
//       Notif.snackBar('Get BestRated Failed', 'Please try again later');
//
//       loadingBestRated.value = false;
//     }
//   }).onError((error, stackTrace) {
//     loadingBestRated.value = false;
//     print('ERROR BESTRATED :$error');
//     Notif.snackBar('Error', error.toString());
//   });
// }
}
