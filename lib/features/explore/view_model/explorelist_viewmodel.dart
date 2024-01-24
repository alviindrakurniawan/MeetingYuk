import 'dart:ffi';

import 'package:get/get.dart';
import 'package:MeetingYuk/features/explore/model/recommendation.dart';
import 'package:MeetingYuk/features/explore/repo/explore_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:MeetingYuk/features/home/model/detail_place.dart';

import 'package:MeetingYuk/common/ulits/notif.dart';

class ListExploreViewModel extends GetxController{
  final ExploreRepository _api = ExploreRepository();
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    radius.value = Get.arguments['radius'];
    latLng.value=Get.arguments['currentPosition'];

    await getForYouLocation(lat: latLng.value!.latitude.toString(), long: latLng.value!.longitude.toString(), max_radius: radius.value.toString());
  }


  var loading = false.obs;
  Rxn<Position> latLng = Rxn<Position>();
  var radius = RxnDouble();
 var placeList = <Recommendation>[].obs;


  Future getForYouLocation({required String lat, required String long,required String max_radius })async{
    loading.value=true;

    await _api.getForYouLocation(lat: lat, long: long, max_radius: max_radius).then((value) {
      print(latLng.value);
      print(radius.value);
      if (value["success"] == true) {
        placeList.assignAll((value['recommendations'] as List)
            .map((item) => Recommendation.fromJson(item))
            .toList());
        loading.value = false;
      } else {
        Notif.snackBar(
            'Get Recomendation Failed','Please try again later');
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString());
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




}


