import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meetingyuk/features/explore/repo/explore_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meetingyuk/ulits/notif.dart';

class ExploreViewModel extends GetxController{
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await _getCurrentPosition();
  }
  final ExploreRepository _api = ExploreRepository();
  final storage = GetStorage();

  var loading = false.obs;
  var loadingButton = false.obs;
  var currentPosition = Rxn<Position>();
  var radius = RxDouble(1);
  var zoom = RxDouble(14);
  var sliderValue = RxDouble(1);

  Future changeSlider(double value)async{
    loading.value = true;
    await Future.delayed(Duration(milliseconds: 050));
    radius.value=value;
    loading.value=false;

  }
  double calculateZoom(double radius) {
    return 14.5 - (radius /2.3);
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Notif.snackBar('Location Service are disable',
          'Please enable the services');

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Notif.snackBar('Location permissions',
            'DENIED');

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Notif.snackBar('Location permissions ',
          'Permanently denied, we cannot request permissions');

      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    loading.value = true;
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition.value= position;
      print(currentPosition.value);
      loading.value = false;
    }).catchError((e) {
      loading.value = false;

      print(e);
    });
  }




}