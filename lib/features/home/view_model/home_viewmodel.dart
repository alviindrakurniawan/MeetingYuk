import 'package:get/get.dart';
import 'package:meetingyuk/features/explore/model/recommendation.dart';
import 'package:meetingyuk/features/home/model/detail_place.dart';
import 'package:meetingyuk/features/home/repo/home_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:meetingyuk/features/history/model/reservation.dart';
import 'package:meetingyuk/features/home/model/place.dart';
import 'dart:async';
import 'package:flutter/material.dart';


class HomeViewModel extends GetxController {
  final HomeRepository _api = HomeRepository();

  @override
  void onInit() async {
    super.onInit();
    getReservationHistory();
    getBestRated();
    await getCurrentPosition();
  }

  var loading= false.obs;
  var loadingNearme = false.obs;
  var loadingBestRated = false.obs;
  var loadingPrevious = false.obs;

  var currentPosition = Rxn<Position>();

  var nearMeList = <Recommendation>[].obs;
  var reservationHistoryList = <Reservation>[].obs;
  var bestRatedList = <Place>[].obs;


  var headerListPage='Near Me'.obs;

  TextEditingController searchbar = TextEditingController();

  Future getNearme() async {
    loadingNearme.value = true;
    String lat = currentPosition.value!.latitude.toString();
    String long =currentPosition.value!.longitude.toString();
    await _api
        .getNearMe(
            lat: lat,
            long: long,
            max_radius: "5.0")
        .then((value) {
      if (value["success"] == true) {

        nearMeList.assignAll((value['recommendations'] as List)
            .map((item) => Recommendation.fromJson(item))
            .toList());

        loadingNearme.value = false;
        print('SUCCESS NEARME');
      } else {
        Notif.snackBar('Get Nearme Failed', 'Please try again later');
        loadingNearme.value = false;
      }
    }).onError((error, stackTrace) {
      print('ERROR NEARME :$error');
      loadingNearme.value = false;
      Notif.snackBar('Error', error.toString());
    });
  }

  Future<void> getBestRated() async {
    loadingBestRated.value = true;
    await _api
        .getAllPlace().then((value) {
      if (value["code"] == 200) {
        print('best rated: ${value['data']}');
        //belum sort
        bestRatedList.assignAll((value['data'] as List)
            .map((item) => Place.fromJson(item))
            .toList()
        );

        bestRatedList.sort((a, b) => b.ratings.compareTo(a.ratings));
        loadingBestRated.value = false;
      } else {
        Notif.snackBar('Get BestRated Failed', 'Please try again later');

        loadingBestRated.value = false;
      }
    }).onError((error, stackTrace) {
      loadingBestRated.value = false;
      print('ERROR BESTRATED :$error');
      Notif.snackBar('Error', error.toString());
    });
  }

  Future getReservationHistory() async {
    loadingPrevious.value = true;
    await _api
        .getReservationHistory()
        .then((value) {
      if (value["code"] == 200) {
        reservationHistoryList.assignAll((value['data']as List)
            .map((item) => Reservation.fromJson(item))
            .toList()
            .reversed);

        loadingPrevious.value = false;
      } else {
        Notif.snackBar('Get ReservationHistor Failed', 'Please try again later');
        loadingPrevious.value = false;
      }
    }).onError((error, stackTrace) {
      loadingPrevious.value = false;
      if(error.toString()=='place not found'){

      }else{
        print('ERROR PREVBOOKING :$error');
        Notif.snackBar('Error', error.toString());
      }
    });
  }

  Future<DetailPlace?> getDetailPlace(String placeId) async {
    loading.value = true;
    try {
      final value = await _api.getDetailPlace(placeId: placeId);
      if (value["code"] == 200) {
        final detailPlace = DetailPlace.fromJson(value["data"]);
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
      Notif.snackBar('Error', error.toString());
      return null;
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Notif.snackBar(
          'Location Service are disable', 'Please enable the services');
      print('gagal 1');

      return false;
    }
    permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.) {
    //   Notif.snackBar('Location permissions ',
    //       'Permanently denied, we cannot request permissions');
    //
    //   return false;
    // }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Notif.snackBar('Location permissions', 'DENIED');
        print('gagal 2');

        return false;
      }
      print('gagal 3');
    }
    if (permission == LocationPermission.deniedForever) {
      Notif.snackBar('Location permissions ',
          'Permanently denied, we cannot request permissions');
      print('gagal 4');

      return false;
    }
    print('gagal 5');
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (hasPermission==true){
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        currentPosition.value = position;
        print('MASOK1');
      }).catchError((e) {
        print(e);
      });
      print('MASOK2');
      getNearme();

    }else{
      print('gagal');
      return;}

  }
}
