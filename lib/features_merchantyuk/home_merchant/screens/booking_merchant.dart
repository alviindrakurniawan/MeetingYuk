import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MeetingYuk/features/profile/widgets/button.dart';
import 'package:MeetingYuk/features_merchantyuk/home_merchant/view_model/booking_merchantVM.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';

class BookingMerchant extends GetView<BookingViewModel> {
  BookingMerchant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<BookingViewModel>(BookingViewModel());
    Widget reservationStatus(int status) {
      switch (status) {
        case 0:
          return Text('Waiting Confirmation',
              style: TextStyle(
                  color: blackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic));
        case 1:
          return Text(
            'Booking Confirmed',
            style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          );
        case 2:
          return Text(
            'Booking Declined',
            style: TextStyle(
                color: redColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          );
        case 3:
          return Text(
            'Booking Canceled',
            style: TextStyle(
                color: redColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
          );
        default:
          return Text(
            'Unknown',
            style: regularBlack12,
          );
      }
    }

    void updateStatus(
        {required String roomName,
        required String placeName,
        required String bookingTime,
        required String reservationId}) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Update Reservation Status',
                  style: boldBlack18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$roomName',
                style: mediumBlack16,
              ),
              Text(
                '$placeName',
                style: mediumBlack16,
              ),
              Text(
                '$bookingTime',
                style: mediumBlack16,
              ),
            ],
          ),
          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFilledButton(
                  title: Text('REJECT', style: boldWhite16),
                  width: 118,
                  height: 40,
                  onPressed: () {
                    controller.rejectReservation(reservationId: reservationId);
                    controller.getReservation();
                    Get.back();
                  },
                  color: redColor),
              SizedBox(width: 10),
              Obx(
                () => controller.loading.value
                    ? CustomFilledButton(
                        title: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        width: 118,
                        height: 40,
                        color: primaryColor)
                    : CustomFilledButton(
                        title: Text('ACCEPT', style: boldWhite16),
                        width: 118,
                        height: 40,
                        onPressed: () {
                          controller.accReservation(
                              reservationId: reservationId);
                          controller.getReservation();
                          Get.back();
                        },
                        color: primaryColor),
              )
            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    }

    void updatePaymentStatus(
        {required String name,
        required String roomName,
        required String placeName,
        required String bookingTime,
        required String reservationId}) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Update Payment Status',
                  style: boldBlack16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$roomName',
                style: mediumBlack16,
              ),
              Text(
                '$placeName',
                style: mediumBlack16,
              ),
              Text(
                '$bookingTime',
                style: mediumBlack16,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '$name',
                style: mediumBlack16,
              ),
            ],
          ),
          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          contentPadding:
              EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFilledButton(
                  title: Text('CANCEL', style: boldWhite16),
                  width: 118,
                  height: 40,
                  onPressed: () {
                    Get.back();
                  },
                  color: redColor),
              SizedBox(width: 10),
              Obx(
                () => controller.loading.value
                    ? CustomFilledButton(
                        title: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        width: 118,
                        height: 40,
                        color: primaryColor)
                    : CustomFilledButton(
                        title: Text('PAY', style: boldWhite16),
                        width: 118,
                        height: 40,
                        onPressed: () {
                          controller.updatePayment(reservationId: reservationId);
                          Get.back();
                        },
                        color: primaryColor),
              )
            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Obx(
            () {
              var uniquePlaces =
                  controller.reservationListRaw.map((e) => e.placeName).toSet();
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: uniquePlaces.map((placeName) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.getReservation();
                          controller.togglePlaceSelection(placeName);
                        },
                        child: Text(placeName),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              controller.selectedPlaces.contains(placeName)
                                  ? Colors.blue
                                  : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          Expanded(
            child: Obx(() {
              return ListView(
                padding: EdgeInsets.all(10),
                children:
                    controller.groupByFilteredReservations.entries.map((entry) {
                  var date = entry.key;
                  var reservations = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Text(
                          date,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...reservations.map((reservation) {
                        return Container(
                          margin:
                              EdgeInsets.only(bottom: 10, left: 5, right: 5),
                          child: GestureDetector(
                            onTap: () {
                              reservation.status==0
                                  ? updateStatus(
                                  roomName: reservation.roomName,
                                  placeName: reservation.placeName,
                                  bookingTime:
                                      '${controller.getTime(reservation.startAt)} - ${controller.getTime(reservation.endAt)}',
                                  reservationId: reservation.id)
                                  :null;
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              elevation: 1,
                              child: ListTile(
                                title: Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reservation.roomName,
                                        style: boldBlack18,
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        reservation.placeName,
                                        style: mediumBlack14,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        '${controller.getTime(reservation.startAt)} - ${controller.getTime(reservation.endAt)} WIB',
                                        style: regBlack14,
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: Container(
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      reservation.isPaid == false
                                          ? GestureDetector(
                                              onTap: () async {
                                                await controller.findUserId(
                                                    userId: reservation.reservedBy);

                                                updatePaymentStatus(
                                                    name: controller.customerName.value,
                                                    roomName: reservation.roomName,
                                                    placeName: reservation.placeName,
                                                    bookingTime: '${controller.getTime(reservation.startAt)} - ${controller.getTime(reservation.endAt)}',
                                                    reservationId: reservation.id);
                                              },
                                              child: CustomFilledButton(
                                                  title: Text(
                                                    'UNPAID',
                                                    style: boldWhite12,
                                                  ),
                                                  width: 80,
                                                  height: 30,
                                                  color: redColor))
                                          : CustomFilledButton(
                                              title: Text('PAID',
                                                style: boldWhite12,),
                                              width: 80,
                                              height: 30,
                                              color: Colors.green,
                                            ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      reservationStatus(reservation.status)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}
