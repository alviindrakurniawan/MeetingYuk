import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:MeetingYuk/features/home/model/detail_place.dart';
import 'package:MeetingYuk/features/home/model/place.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/repo/place_repo.dart';
import 'package:MeetingYuk/common/ulits/notif.dart';


class PlaceViewModel extends GetxController {
  final PlaceMerchantRepo _api = PlaceMerchantRepo();
  final storage = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    await getPlaceMerchant();
  }

  var loading = false.obs;
  var placeList = <Place>[].obs;

  Future getPlaceMerchant() async {
    loading.value = true;
    await _api.getPlaceMerchant().then((value) {
      if (value['code'] == 200) {
        print('error 1');
        placeList.assignAll((value['data'] as List)
            .map((item) => Place.fromJson(item))
            .toList());
        print('error 2');
        loading.value = false;
      }else {
        Notif.snackBar('Get Place Failed', 'Please try again later');
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      if(error.toString().contains('Token Expired')){
        Get.offAllNamed('/login');
      }
      loading.value = false;
      print('error getPlaceMerchant :$error');

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
            value['message'].toString());
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


}
