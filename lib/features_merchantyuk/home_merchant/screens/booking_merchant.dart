import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features_merchantyuk/home_merchant/view_model/booking_merchantVM.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/style.dart';

class BookingMerchant extends GetView<BookingViewModel> {
  BookingMerchant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          toolbarHeight: 60.0,
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 5, right: 10),
              child: GestureDetector(
                onTap: () async {},
                child: Image.asset(
                  'assets/icons/chat28.png',
                  height: 28,
                  width: 28,
                ),
              ),
            ),
          ],
          title: GestureDetector(
            onTap: () {
              Get.toNamed('/searchpage');
            },
            child: Container(
                height: 36,
                margin: const EdgeInsets.only(top: 5.0, left: 15, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: borderColor)),
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 15.0),
                    child: Icon(
                      Icons.search,
                      color: grey,
                      size: 22,
                    ),
                  ),
                  Text(
                    'Find a meeting spot',
                    style: regularLightGrey12,
                  )
                ])
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Obx(() {
                var uniquePlaces = controller.reservationListRaw.map((e) => e.placeName).toSet();
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: uniquePlaces.map((placeName) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => controller.togglePlaceSelection(placeName),
                          child: Text(placeName),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.selectedPlaces.contains(placeName)
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            Expanded(
              child: Obx(
                    () {
                  var reservations = controller.filteredReservations;
                  return ListView.builder(
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      var reservation = reservations[index];
                      return ListTile(
                        title: Text(reservation.placeName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reservation.roomName),
                            Text(reservation.updatedAt)
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}
