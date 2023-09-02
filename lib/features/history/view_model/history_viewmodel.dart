import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meetingyuk/features/home/model/detail_place.dart';
import 'package:meetingyuk/features/history/model/reservation.dart';
import 'package:meetingyuk/features/history/repo/history_repo.dart';
import 'package:meetingyuk/features/home/model/detail_reservation.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:collection/collection.dart';

class HistoryViewModel extends GetxController {
  final HistoryRepository _api = HistoryRepository();
  final storage = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    await getallReservation();
  }

  var loading = false.obs;
  var reservationList = <Reservation>[].obs;
  var groupedReservations = <String, List<Reservation>>{}.obs;

  Future getallReservation() async {
    loading.value = true;
    _api.getAllReservation().then((value) {
      if (value["code"] == 200) {
        reservationList.assignAll((value['data'] as List)
            .map((item) => Reservation.fromJson(item))
            .toList());
        groupedReservations.value = groupBy<Reservation, String>(
          reservationList,
          (obj) {
            DateTime date = DateTime.parse(obj.startAt);
            return "${date.day}-${date.month}-${date.year}";
          },
        );

        loading.value = false;
      } else {
        Notif.snackBar('Get History Failed', value['message'].toString());
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      if (error.toString() == 'token expired') {
        storage.write('isLoggedIn', false);
        Get.offAndToNamed('/login');
      }if(error.toString() == 'reservations not found') {}
      else {
        Notif.snackBar('Error', error.toString());
      }
      print(error);
    });
  }

  Future<DetailPlace?> getDetailPlace(String placeId) async {
    loading.value = true;
    try {
      final value = await _api.getDetailPlace(placeId: placeId);
      if (value["code"] == 200) {
        final detailPlace = DetailPlace.fromJson(value["data"]);
        //set opening hour
        //set

        loading.value = false;
        return detailPlace;
      } else {
        Notif.snackBar('Get DetailPlace Failed',
            value['message'].toString().toUpperCase());
        loading.value = false;
        return null;
      }
    } catch (error) {
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString().toUpperCase());
      return null;
    }
  }

  Future<DetailReservation?> getDetailReservation(String reservationId) async {
    loading.value = true;
    try {
      final value =
          await _api.getDetailReservation(reservationId: reservationId);
      if (value["code"] == 200) {
        final detailPlace = DetailReservation.fromJson(value["data"]);
        loading.value = false;
        return detailPlace;
      } else {
        Notif.snackBar('Get DetailReservation Failed',
            value['message'].toString().toUpperCase());
        loading.value = false;
        return null;
      }
    } catch (error) {
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString().toUpperCase());
      return null;
    }
  }

  String getTime(String dateTime) {
    final dt = DateTime.parse(dateTime);
    final time =
        "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    return time;
  }

  String checkIsPaid(bool isPaid) {
    if (isPaid) {
      return 'Sudah Bayar';
    }
    return 'Belum Bayar';
  }

  String checkStatus(int status) {
    if (status == 0) {
      return 'Waiting\nConfirmation';
    }
    if (status == 1) {
      return 'Confirmed';
    }
    if (status == 2) {
      return 'Declined';
    }
    if (status == 3) {
      return 'Canceled';
    }
    return 'Unknown';
  }
}
