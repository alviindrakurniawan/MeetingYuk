import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/home/model/detail_place.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/repo/place_repo.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/view_model/place_viewmodel.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:meetingyuk/features/home/widget/facilities.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
class EditPlaceViewModel extends GetxController {
  final PlaceMerchantRepo _api = PlaceMerchantRepo();
  final storage = GetStorage();
  PlaceViewModel placeController = Get.find<PlaceViewModel>();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    if (Get.arguments['code'] == 'add-place') {
      await getCurrentPosition();
      //set pin center map using current location
      await setPin();
    } else {
      // await getCurrentPosition();
      detailPlace.value = Get.arguments['detailPlace'];
      await getCurrentPosition();
    }
  }

  var loading = false.obs;
  var activeButton = false.obs;
  var indexRoom = 0.obs;
  Rxn<DetailPlace> detailPlace = Rxn<DetailPlace>();
  var facilitiesChecklist = <String, bool>{}.obs;
  var currentPosition = Rxn<Position>();

  var latitudeMap = 0.0.obs;
  var longitudeMap = 0.0.obs;
  var latitudeMapFix = 0.0.obs;
  var longitudeMapFix = 0.0.obs;
  var unlockAddress= false.obs;

  Timer? _debounceTimer;
  var addressMapName=''.obs;
  var addressMapDetail=''.obs;

  final nameController = TextEditingController();
  final addressController = TextEditingController();

  final sundayController = TextEditingController();
  final sundayEndController = TextEditingController();
  final mondayController = TextEditingController();
  final mondayEndController = TextEditingController();
  final tuesdayController = TextEditingController();
  final tuesdayEndController = TextEditingController();
  final wednesdayController = TextEditingController();
  final wednesdayEndController = TextEditingController();
  final thursdayController = TextEditingController();
  final thursdayEndController = TextEditingController();
  final fridayController = TextEditingController();
  final fridayEndController = TextEditingController();
  final saturdayController = TextEditingController();
  final saturdayEndController = TextEditingController();

  final roomNameController = TextEditingController();
  final maxCapacityController = TextEditingController();
  final maxDurationController = TextEditingController();
  final roomPriceController = TextEditingController();

  final nameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final sundayFocusNode = FocusNode();
  final sundayEndFocusNode = FocusNode();
  final mondayFocusNode = FocusNode();
  final mondayEndFocusNode = FocusNode();
  final tuesdayFocusNode = FocusNode();
  final tuesdayEndFocusNode = FocusNode();
  final wednesdayFocusNode = FocusNode();
  final wednesdayEndFocusNode = FocusNode();
  final thursdayFocusNode = FocusNode();
  final thursdayEndFocusNode = FocusNode();
  final fridayFocusNode = FocusNode();
  final fridayEndFocusNode = FocusNode();
  final saturdayFocusNode = FocusNode();
  final saturdayEndFocusNode = FocusNode();

  final roomNameFocusNode = FocusNode();
  final maxCapacityFocusNode = FocusNode();
  final maxDurationFocusNode = FocusNode();
  final roomPriceFocusNode = FocusNode();

  var closedSunday = false.obs;
  var closedMonday = false.obs;
  var closedTuesday = false.obs;
  var closedWednesday = false.obs;
  var closedThursday = false.obs;
  var closedFriday = false.obs;
  var closedSaturday = false.obs;

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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Notif.snackBar(
          'Location Service are disable', 'Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Notif.snackBar('Location permissions', 'DENIED');
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

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (hasPermission == true) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        currentPosition.value = position;
        print(currentPosition.value);
      }).catchError((e) {
        print(e);
      });
    } else {
      print('gagal');
      return;
    }
  }

  //pick location
  void setCenterPoint(LatLng centerPoint) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 200), () async {

      latitudeMap.value = centerPoint.latitude;
      longitudeMap.value = centerPoint.longitude;
      await _getAddressFromLatLng(latitudeMap.value, longitudeMap.value);
    });
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      addressMapName.value='${place.name}';
      addressMapDetail.value = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea} ${place.postalCode} ';


    } catch (e) {
      print(e);
    }
  }

  Future setPin()async{

    latitudeMap.value = currentPosition.value!.latitude;
    longitudeMap.value = currentPosition.value!.longitude;

  }

  Future setPickLocation() async{
    latitudeMapFix.value= latitudeMap.value;
    longitudeMapFix.value= longitudeMap.value;
    unlockAddress.value=true;
    addressController.text = addressMapDetail.value;
    update(['address']);
  }
  Future refreshMaps()async{
    latitudeMapFix.refresh();
    longitudeMapFix.refresh();
    update(['maps']);
  }
  void updateTuesday(String newOpenTime, String newCloseTime, bool isClosed) {
    tuesdayController.text = newOpenTime;
    tuesdayEndController.text = newCloseTime;
    closedTuesday.value = isClosed;
    update(['tuesday']);
  }
  void updateWednesday(String newOpenTime, String newCloseTime, bool isClosed) {
    wednesdayController.text = newOpenTime;
    wednesdayEndController.text = newCloseTime;
    closedWednesday.value = isClosed;
    update(['wednesday']);
  }


  //edit place
  void toggleFacility(String facility) {
    facilitiesChecklist[facility] = !facilitiesChecklist[facility]!;
  }

  Future setEditPlace() async {
    nameController.text = detailPlace.value!.name;
    addressController.text = detailPlace.value!.address;

    sundayController.text = detailPlace.value?.openingHours.sunday != ''
        ? detailPlace.value!.openingHours.sunday.split('-')[0]
        : 'closed';
    sundayEndController.text = detailPlace.value?.openingHours.sunday != ''
        ? detailPlace.value!.openingHours.sunday.split('-')[1]
        : 'closed';
    mondayController.text = detailPlace.value?.openingHours.monday != ''
        ? detailPlace.value!.openingHours.monday.split('-')[0]
        : 'closed';
    mondayEndController.text = detailPlace.value?.openingHours.monday != ''
        ? detailPlace.value!.openingHours.monday.split('-')[1]
        : 'closed';
    tuesdayController.text = detailPlace.value?.openingHours.tuesday != ''
        ? detailPlace.value!.openingHours.tuesday.split('-')[0]
        : 'closed';
    tuesdayEndController.text = detailPlace.value?.openingHours.tuesday != ''
        ? detailPlace.value!.openingHours.tuesday.split('-')[1]
        : 'closed';
    wednesdayController.text = detailPlace.value?.openingHours.wednesday != ''
        ? detailPlace.value!.openingHours.wednesday.split('-')[0]
        : 'closed';
    wednesdayEndController.text =
        detailPlace.value?.openingHours.wednesday != ''
            ? detailPlace.value!.openingHours.wednesday.split('-')[1]
            : 'closed';
    thursdayController.text = detailPlace.value?.openingHours.thursday != ''
        ? detailPlace.value!.openingHours.thursday.split('-')[0]
        : 'closed';
    thursdayEndController.text = detailPlace.value?.openingHours.thursday != ''
        ? detailPlace.value!.openingHours.thursday.split('-')[1]
        : 'closed';
    fridayController.text = detailPlace.value?.openingHours.friday != ''
        ? detailPlace.value!.openingHours.friday.split('-')[0]
        : 'closed';
    fridayEndController.text = detailPlace.value?.openingHours.friday != ''
        ? detailPlace.value!.openingHours.friday.split('-')[1]
        : 'closed';
    saturdayController.text = detailPlace.value?.openingHours.saturday != ''
        ? detailPlace.value!.openingHours.saturday.split('-')[0]
        : 'closed';
    saturdayEndController.text = detailPlace.value?.openingHours.saturday != ''
        ? detailPlace.value!.openingHours.saturday.split('-')[1]
        : 'closed';

    closedSunday.value =
        detailPlace.value?.openingHours.sunday == '' ? true : false;
    closedMonday.value =
        detailPlace.value?.openingHours.monday == '' ? true : false;
    closedTuesday.value =
        detailPlace.value?.openingHours.tuesday == '' ? true : false;
    closedWednesday.value =
        detailPlace.value?.openingHours.wednesday == '' ? true : false;
    closedThursday.value =
        detailPlace.value?.openingHours.thursday == '' ? true : false;
    closedFriday.value =
        detailPlace.value?.openingHours.friday == '' ? true : false;
    closedSaturday.value =
        detailPlace.value?.openingHours.saturday == '' ? true : false;

    latitudeMapFix.value = detailPlace.value!.location.latitude;
    longitudeMapFix.value = detailPlace.value!.location.longitude;
  }

  Future setEditRoom() async {
    roomNameController.text = detailPlace.value!.rooms[indexRoom.value].name;
    roomPriceController.text =
        detailPlace.value!.rooms[indexRoom.value].price.toString();
    maxDurationController.text =
        detailPlace.value!.rooms[indexRoom.value].maxDuration.toString();
    maxCapacityController.text =
        detailPlace.value!.rooms[indexRoom.value].maxCapacity.toString();

    //sync facilitieschekclist with data
    facilitiesChecklist.clear();
    for (var facility in facilityIcons.keys) {
      facilitiesChecklist[facility] = detailPlace
          .value!.rooms[indexRoom.value].facilities
          .contains(facility);
    }
  }

  Future setAddRoom() async {
    roomNameController.clear();
    roomPriceController.clear();
    maxDurationController.clear();
    maxCapacityController.clear();
    facilitiesChecklist.clear();

    for (var facility in facilityIcons.keys) {
      facilitiesChecklist[facility] = false;
    }
  }

  Future updatePlace() async {
    loading.value = true;

    Map<String, dynamic> data = {
      "name": nameController.text,
      "address": addressController.text,
      "location": {
        "latitude": latitudeMapFix.value,
        "longitude": longitudeMapFix.value
      },
      "opening_hours": {
        "monday": closedMonday.isFalse
            ? "${mondayController.text}-${mondayEndController.text}"
            : "",
        "tuesday": closedTuesday.isFalse
            ? "${tuesdayController.text}-${tuesdayEndController.text}"
            : "",
        "wednesday": closedWednesday.isFalse
            ? "${wednesdayController.text}-${wednesdayEndController.text}"
            : "",
        "thursday": closedThursday.isFalse
            ? "${thursdayController.text}-${thursdayEndController.text}"
            : "",
        "friday": closedFriday.isFalse
            ? "${fridayController.text}-${fridayEndController.text}"
            : "",
        "saturday": closedSaturday.isFalse
            ? "${saturdayController.text}-${saturdayEndController.text}"
            : "",
        "sunday": closedSunday.isFalse
            ? "${sundayController.text}-${sundayEndController.text}"
            : "",
      }
    };
    await _api
        .updatePlace(placeId: detailPlace.value!.id, body: data)
        .then((value) {
      if (value["code"] == 200) {
        detailPlace.value!.name = value['data']['name'] ?? '';
        detailPlace.value!.address = value['data']['address'];
        detailPlace.value!.openingHours.sunday =
            value['data']['opening_hours']['sunday'] ?? '';
        detailPlace.value!.openingHours.monday =
            value['data']['opening_hours']['monday'] ?? '';
        detailPlace.value!.openingHours.tuesday =
            value['data']['opening_hours']['tuesday'] ?? '';
        detailPlace.value!.openingHours.wednesday =
            value['data']['opening_hours']['wednesday'] ?? '';
        detailPlace.value!.openingHours.thursday =
            value['data']['opening_hours']['thursday'] ?? '';
        detailPlace.value!.openingHours.friday =
            value['data']['opening_hours']['friday'] ?? '';
        detailPlace.value!.openingHours.saturday =
            value['data']['opening_hours']['saturday'] ?? '';
        Get.back();
        Notif.snackBar('Update Place', value['message']);
        print('update place success');
        loading.value = false;
      } else {
        Notif.snackBar('Error', value['message']);
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString());
    });
  }

  Future updateRoom() async {
    loading.value = true;

    List<String> facilities = facilitiesChecklist.keys
        .where((key) => facilitiesChecklist[key] == true)
        .toList();

    Map<String, dynamic> data = {
      "name": roomNameController.text,
      "image_urls": [
        "https://archive.org/download/no-photo-available/no-photo-available.png"
      ],
      "max_capacity": int.parse(maxCapacityController.text),
      "max_duration": int.parse(maxDurationController.text),
      "facilities": facilities,
      "price": int.parse(roomPriceController.text),
    };
    await _api
        .updateRoom(
            placeId: detailPlace.value!.id,
            roomId: detailPlace.value!.rooms[indexRoom.value].roomId,
            body: data)
        .then((value) {
      if (value["code"] == 200) {
        detailPlace.value!.rooms[indexRoom.value].name = value['data']['name'];
        detailPlace.value!.rooms[indexRoom.value].imageUrls =
            List<String>.from(value["data"]["image_urls"].map((x) => x));
        detailPlace.value!.rooms[indexRoom.value].maxCapacity =
            value['data']['max_capacity'];
        detailPlace.value!.rooms[indexRoom.value].maxDuration =
            value['data']['max_duration'];
        detailPlace.value!.rooms[indexRoom.value].facilities =
            List<String>.from(value["data"]["facilities"].map((x) => x));
        detailPlace.value!.rooms[indexRoom.value].price =
            value['data']['price'];

        Get.back();
        Notif.snackBar('Update Room', value['message']);
        print('update place success');
        loading.value = false;
      } else {
        Notif.snackBar('Error', value['message']);
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString());
    });
  }

  Future addRoom() async {
    loading.value = true;

    List<String> facilities = facilitiesChecklist.keys
        .where((key) => facilitiesChecklist[key] == true)
        .toList();

    Map<String, dynamic> data = {
      "name": roomNameController.text,
      "image_urls": [
        "https://archive.org/download/no-photo-available/no-photo-available.png"
      ],
      "max_capacity": int.parse(maxCapacityController.text),
      "max_duration": int.parse(maxDurationController.text),
      "facilities": facilities,
      "price": int.parse(roomPriceController.text),
    };
    await _api
        .addRoom(placeId: detailPlace.value!.id, body: data)
        .then((value) {
      if (value["code"] == 201) {
        detailPlace.value = DetailPlace.fromJson(value["data"]);

        Get.back();
        Notif.snackBar('Add Room', value['message']);
        print('add room success');
        loading.value = false;
      } else {
        Notif.snackBar('Error', value['message']);
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString());
    });
  }

  Future deleteRoom() async {
    await _api
        .deleteRoom(
            placeId: detailPlace.value!.id,
            roomId: detailPlace.value!.rooms[indexRoom.value].roomId)
        .then((value) {
      if (value["code"] == 200) {
        detailPlace.value = DetailPlace.fromJson(value["data"]);

        Get.back();
        Notif.snackBar('Delete Room', value['message']);
        print('Delete room success');
        loading.value = false;
      } else {
        Notif.snackBar('Error', value['message']);
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString());
    });
  }
  Future deletePlace() async {
    await _api.deletePlace(placeId: detailPlace.value!.id,)
        .then((value) {
      if (value["code"] == 200) {

        placeController.getPlaceMerchant();

        Notif.snackBar('Delete Place', value['message']);
        print('Delete place success');
        loading.value = false;
      } else {
        Notif.snackBar('Error', value['message']);
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString());
    });
  }

  Future createPlace() async {
    List<String> facilities = facilitiesChecklist.keys
        .where((key) => facilitiesChecklist[key] == true)
        .toList();

    Map<String, dynamic> data = {
      "name": nameController.text,
      "address": addressController.text,
      "location": {
        "latitude": latitudeMapFix.value,
        "longitude": longitudeMapFix.value
      },
      "opening_hours": {
        "monday": closedMonday.isFalse
            ? "${mondayController.text}-${mondayEndController.text}"
            : "",
        "tuesday": closedTuesday.isFalse
            ? "${tuesdayController.text}-${tuesdayEndController.text}"
            : "",
        "wednesday": closedWednesday.isFalse
            ? "${wednesdayController.text}-${wednesdayEndController.text}"
            : "",
        "thursday": closedThursday.isFalse
            ? "${thursdayController.text}-${thursdayEndController.text}"
            : "",
        "friday": closedFriday.isFalse
            ? "${fridayController.text}-${fridayEndController.text}"
            : "",
        "saturday": closedSaturday.isFalse
            ? "${saturdayController.text}-${saturdayEndController.text}"
            : "",
        "sunday": closedSunday.isFalse
            ? "${sundayController.text}-${sundayEndController.text}"
            : "",
      },
      "rooms": [
        {
          "name": roomNameController.text,
          "image_urls": [
            "https://archive.org/download/no-photo-available/no-photo-available.png"
          ],
          "max_capacity": int.parse(maxCapacityController.text),
          "max_duration": int.parse(maxDurationController.text),
          "facilities": facilities,
          "price": int.parse(roomPriceController.text),
        }
      ],
    };
    await _api.createPlace(body: data).then((value) {
      if (value["code"] == 201) {

        placeController.getPlaceMerchant();

        Notif.snackBar('Create Place', value['message']);
        print('Create Place success');
        loading.value = false;
      } else {
        Notif.snackBar('Error', value['message']);
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      Notif.snackBar('Error', error.toString());
    });
  }



  //validate form
  String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return "Fill this";
    } else {
      return null;
    }
  }

  String? validateEmptyAddress(String? value) {
    if (value!.isEmpty) {
      Notif.snackBar('Error', 'Please Set Location');
      return "Fill this";
    } else {
      return null;
    }
  }

  String? validateHours(String? value) {
    if (value!.isEmpty) {
      return "Fill this";
    } else if (value == 'closed') {
      return null;
    } else if (!RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$').hasMatch(value)) {
      return "ex: 23:59";
    } else {
      return null;
    }
  }

  String? validatePositiveNumbers(String? value) {
    if (value!.isEmpty) {
      return "Please fill this";
    } else if (!RegExp(r'^[1-9][0-9]*$').hasMatch(value)) {
      return "Please input positive number";
    } else {
      return null;
    }
  }

  String? validatNumbers(String? value) {
    if (value!.isEmpty) {
      return "Please fill this";
    } else if (!RegExp(r'^([1-9][0-9]*(\.[0-9]+)?|0\.[0-9]*[1-9][0-9]*)$')
        .hasMatch(value)) {
      return "Please input number";
    } else {
      return null;
    }
  }
}
