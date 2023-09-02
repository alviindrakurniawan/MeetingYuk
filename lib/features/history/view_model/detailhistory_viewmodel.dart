import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/history/repo/history_repo.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:collection/collection.dart';

class DetailHistoryViewModel extends GetxController {
  final HistoryRepository _api = HistoryRepository();
  var loading = false.obs;


  String checkIsPaid(bool isPaid) {
    if (isPaid) {
      return 'Sudah Bayar';
    }
    return 'Belum Bayar';
  }

  String checkStatus(int status) {
    if (status == 0) {
      return 'Waiting Confirmation';
    }
    if (status == 1) {
      return 'Confirmed';
    }
    if (status == 2) {
      return 'Declined';
    }
    if (status ==3){
      return 'Canceled';
    }
    return 'Unknown';
  }

  Future updateReservation(String reservationId,var body) async {
    loading.value = true;
    try {
      final value = await _api.updateReservation(reservation_id: reservationId,body: body);
      if (value["code"] == 200) {


        Get.back();
        Notif.snackBar('Update Reservation', 'Success');
        loading.value = false;
      } else {
        Get.back();
        Notif.snackBar('Update Reservation Failed',
            value['message'].toString().toUpperCase());
        loading.value = false;
      }
    } catch (error) {
      Get.back();
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString().toUpperCase());
      return null;
    }
  }

  Future cancelReservation(String reservationId) async {
    loading.value = true;
    try {
      final value = await _api.cancelReservation(reservation_id: reservationId);
      if (value["code"] == 200) {



        Get.back();
        Notif.snackBar('Cancel Reservation', 'Success');
        loading.value = false;
      } else {
        Get.back();
        Notif.snackBar('Cancel Reservation Failed',
            value['message'].toString().toUpperCase());
        loading.value = false;
      }
    } catch (error) {
      Get.back();
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString().toUpperCase());
      return null;
    }
  }

  String intToMoneyString(int number) {
    final buffer = StringBuffer();
    final str = number.toString().split('').reversed.toList();

    for (int i = 0; i < str.length; i++) {
      if (i > 0 && i % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }

    return buffer.toString().split('').reversed.join();
  }


}
