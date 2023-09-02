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


class SearchViewModel extends GetxController {
  final HomeRepository _api = HomeRepository();

  final focusNode = FocusNode();

  @override
  void onReady() async {
    super.onReady();
    focusNode.requestFocus();
  }


  var loading= false.obs;

  var searchList = <Place>[].obs;

  TextEditingController searchbar = TextEditingController();

  Future<void> searchPlace(var querySearch) async {
    loading.value = true;
    await _api
        .searchPlace(search: querySearch).then((value) {
      if (value["code"] == 200) {
        if(value['data']!=null){
          print('search place: ${value['data']}');
          searchList.assignAll((value['data'] as List)
              .map((item) => Place.fromJson(item))
              .toList()
          );
        }else{
          searchList.value =[];
        }

        //reverse or not

        // searchList.sort((a, b) => b.ratings.compareTo(a.ratings));
        loading.value = false;
      } else {
        Notif.snackBar('Search Failed', 'Please try again later');

        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print('ERROR SEARCH :$error');
      Notif.snackBar('Error', error.toString());
    });
  }

}