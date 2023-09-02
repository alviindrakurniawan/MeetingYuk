
import 'dart:math';
import 'package:get_storage/get_storage.dart';
import 'package:meetingyuk/features/home/view_model/dasboard_viewmodel.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/home/model/detail_place.dart';
import 'package:meetingyuk/features/home/repo/reservation_repo.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:intl/intl.dart';

class ReservationViewModel extends GetxController {
  final ReservationRepository _api = ReservationRepository();
  final storage = GetStorage();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    detailPlace.value = Get.arguments['detailPlace'];
    reservationId.value = Get.arguments['reservationId'];

  }
  final dashController = Get.find<DashViewModel>();

  var loading = false.obs;
  var activeButton = false.obs;
  var indexRoom = 0.obs;

  // Rxn<DateTime> selectedDate = Rxn<DateTime>();
  Rxn<DetailPlace> detailPlace = Rxn<DetailPlace>();
  var reservationId=''.obs;

  var dateTime = DateTime.now().obs;

  var availableSlots = <DateTime>[].obs;
  var availableSlotsEnd = <DateTime>[].obs;
  var startTimeIndex = 0.obs;
  var endTimeIndex = 0.obs;
  Rxn<DateTime> startTime = Rxn<DateTime>();
  // var startTime = ''.obs;
  Rxn<DateTime> endTime = Rxn<DateTime>();

  var totalPrice='-'.obs;


  Future setDateTime(DateTime date) async {
    dateTime.value = date;
  }

  //Needed when create reservation
  String getStartTime(){
    DateTime wibDateTime = startTime.value!.toUtc();

    // Change format to WIB & dont needed to UTC+7
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formatted = formatter.format(wibDateTime) + ' WIB';
    return formatted;
  }
  String getEndTime(){
    DateTime wibDateTime = endTime.value!.toUtc();

    // Change format to WIB & dont needed to UTC+7
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formatted = formatter.format(wibDateTime) + ' WIB';
    return formatted;
  }

  //restart when change date
  Future resetStartEndPrice()async{
    startTimeIndex.value=0;
    endTimeIndex.value=0;
    startTime.value =null;
    endTime.value =null;
    totalPrice.value='-';
  }

  Future checkAvailability({required String selected_date}) async {
    loading.value = true;
    _api
        .checkAvailability(
            placeId: detailPlace.value!.id,
            roomId: detailPlace.value!.rooms[indexRoom.value].roomId,
            selected_date: selected_date)
        .then((value) {
          print(value);
      if (value["code"] == 200) {
        value['data'] == null
            ? availableSlots.value = availSlotByDay([])
            : availableSlots.value = availSlotByDay(value['data']);

        loading.value = false;
        activeButton.value = true;
      } else {
        Notif.snackBar('Error', value['message']);
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print('error checkavail');
      Notif.snackBar('Error', error.toString());
    });
  }

  //for parsing object room data & null checker
  List<DateTime> availSlotByDay(List<dynamic> bookedTime) {
    final dayOfWeek = DateFormat('EEEE').format(dateTime.value).toLowerCase();

    final openingHoursMap = {
      'monday': detailPlace.value?.openingHours.monday,
      'tuesday': detailPlace.value?.openingHours.tuesday,
      'wednesday': detailPlace.value?.openingHours.wednesday,
      'thursday': detailPlace.value?.openingHours.thursday,
      'friday': detailPlace.value?.openingHours.friday,
      'saturday': detailPlace.value?.openingHours.saturday,
      'sunday': detailPlace.value?.openingHours.sunday,
    };

    final hours = openingHoursMap[dayOfWeek];
    if (hours != null) {
      return generateAvailableTimes(bookedTime, hours);
    }
    return [];
  }

  List<DateTime> generateAvailableTimes(List<dynamic> bookedTimes, String openhour) {
    DateTime open =
        DateTime.parse('${DateFormat('yyyy-MM-dd').format(dateTime.value)}T${openhour.split('-')[0]}:00Z');
    print('open place $open');
    DateTime close =
        DateTime.parse('${DateFormat('yyyy-MM-dd').format(dateTime.value)}T${openhour.split('-')[1]}:00Z');
    print('close place $close');

    List<DateTime> bookedStartTimes = bookedTimes
        .map((booking) => DateTime.parse(booking['start_at']!))
        .toList();
    print('bookedStartTimes: $bookedStartTimes');

    List<DateTime> bookedEndTimes = bookedTimes
        .map((booking) => DateTime.parse(booking['end_at']!))
        .toList();
    print('bookedEndTimes: $bookedEndTimes');

    List<DateTime> availableTimes = [];
    while (open.isBefore(close)) {
      bool isBooked = false;

      for (var i = 0; i < bookedStartTimes.length; i++) {
        if (!open.isBefore(bookedStartTimes[i]) &&
            open.isBefore(bookedEndTimes[i])) {
          isBooked = true;
          break;
        }
      }

      if (!isBooked) {
        availableTimes.add(open);
      }

      open = open.add(Duration(minutes: 15));
    }

    return availableTimes;
  }

  //check at showDatePicker
  bool isDayAvailable(DateTime date, OpeningHours openingHours) {
    String day = '';
    switch (date.weekday) {
      case 1:
        day = openingHours.monday;
        break;
      case 2:
        day = openingHours.tuesday;
        break;
      case 3:
        day = openingHours.wednesday;
        break;
      case 4:
        day = openingHours.thursday;
        break;
      case 5:
        day = openingHours.friday;
        break;
      case 6:
        day = openingHours.saturday;
        break;
      case 7:
        day = openingHours.sunday;
        break;
    }
    return day.isNotEmpty;
  }

  //filtered startTime for endTime list
  List<DateTime> filterSlots() {
    List<DateTime> filteredSlots = [];

    for (int i = startTimeIndex.value; i < availableSlotsEnd.length - 1; i++) {
      DateTime currentSlot = availableSlotsEnd[i];
      DateTime nextSlot = availableSlotsEnd[i + 1];

      filteredSlots.add(currentSlot);

      // If difference between current and next slot is more than 15 mins, add a slot and break.
      if (nextSlot.difference(currentSlot).inMinutes > 15) {
        filteredSlots.add(currentSlot.add(Duration(minutes: 15)));
        break;
      }

      if (nextSlot == availableSlotsEnd.last) {
        filteredSlots.add(nextSlot);
      }
    }

    if (filteredSlots.isNotEmpty) {
      filteredSlots.removeAt(0);
    }

    return filteredSlots;
  }

  Future calculateTotalPrice() async{
    Duration diff = endTime.value!.difference(startTime.value!);
    int hours = diff.inHours;

    // Check if there are any extra minutes beyond the full hours
    if (diff.inMinutes > hours * 60) {
      hours++;
    }

    //calculate totalPrice
    String Input= (hours*detailPlace.value!.rooms[indexRoom.value].price).toString();

    //make it into money
    var parts = [];
    while (Input.isNotEmpty) {
      parts.insert(0, Input.substring(max(0, Input.length - 3)));
      Input = Input.substring(0, max(0, Input.length - 3));
    }

    totalPrice.value= parts.join('.');

  }

  //backup1
  int roundUpHourDifference(DateTime start, DateTime end) {
    Duration diff = end.difference(start);
    int hours = diff.inHours;

    // Check if there are any extra minutes beyond the full hours
    if (diff.inMinutes > hours * 60) {
      hours++;  // Add an extra hour if there are any additional minutes
    }

    return hours;
  }



  Future createReservation() async {
    loading.value = true;
    Map<String, dynamic> body = {
      "room_id": detailPlace.value!.rooms[indexRoom.value].roomId,
      "participants_id": [],
      "start_at": getStartTime(),
      "end_at": getEndTime()
    };
    _api.createReservation(body).then((value) {
      print('');
      print(value['message']);
      print('');
      if (value["code"] == 201) {
        loading.value = false;

        Notif.snackBar('Create Reservation', 'Success');
      } else {
        Notif.snackBar('Error', value['message']);
        loading.value = false;
        Get.back();
      }
    }).onError((error, stackTrace) {
      loading.value = false;

      print('error disini');
      Notif.snackBar('Error', error.toString());
    });
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
