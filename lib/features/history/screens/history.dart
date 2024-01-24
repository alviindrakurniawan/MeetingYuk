import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MeetingYuk/features/history/view_model/history_viewmodel.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/notif.dart';
import 'package:MeetingYuk/common/ulits/style.dart';

class History extends GetView<HistoryViewModel> {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<HistoryViewModel>(HistoryViewModel());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0,
          toolbarHeight: 60.0,
          elevation: 0,
          title: Text('History', style: extraBoldBlack24),
          backgroundColor: Colors.white,
        ),
        body: Obx(
          () {
            if (controller.loading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              if(controller.reservationList.isEmpty){
               return Container(
                   alignment: Alignment.center,
                   child: Text(
                     '0 History',
                     textAlign: TextAlign.center,
                     style: boldBlack16,
                   ));
              }
              return ListView(
                padding: EdgeInsets.only(left:10, right: 10),
                children: controller.groupedReservations.entries.map((entry) {
                  var date = entry.key;
                  var reservations = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(date,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      ...reservations.map((reservation) {
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 3,
                          color: Colors.white,
                          child: ListTile(
                            leading: Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Image.asset(
                                    'assets/images/merchant_circle.png')),
                            // CircleAvatar(radius:20,child: Image.asset('assets/images/merchant_circle.png'),),
                            visualDensity: VisualDensity(vertical: 4),
                            title: Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${reservation.placeName}',
                                    style: boldUnderBlack16,
                                    maxLines: 2,
                                    overflow: TextOverflow.clip,
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '${reservation.roomName}',
                                    style: regBlack14,
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '${controller.getTime(reservation.startAt)} - ${controller.getTime(reservation.endAt)}',
                                    style: regBlack14,
                                  ),
                                  GetBuilder<HistoryViewModel>(
                                    builder: (controller) {
                                      String paymentStatus = controller
                                          .checkIsPaid(reservation.isPaid);
                                      return Text(
                                        paymentStatus,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: paymentStatus == 'Sudah Bayar'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            //Trailing
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GetBuilder<HistoryViewModel>(
                                  builder: (controller) {
                                    String reservationStatus = controller
                                        .checkStatus(reservation.status);
                                    Color statusColor;

                                    switch (reservationStatus) {
                                      case 'Waiting\nConfirmation':
                                        statusColor = grey;
                                        break;
                                      case 'Confirmed':
                                        statusColor = Colors.green;
                                        break;
                                      case 'Canceled':
                                        statusColor = Colors.red;
                                        break;
                                      default:
                                        statusColor = Colors.grey;
                                        break;
                                    }
                                    return Text(
                                      reservationStatus,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: statusColor),
                                    );
                                  },
                                ),
                              ],
                            ),
                            onTap: () async {
                              final detailPlace = await controller
                                  .getDetailPlace(reservation.placeId);
                              final detailReservation = await controller
                                  .getDetailReservation(reservation.id);

                              if (detailPlace != null) {
                                Get.toNamed('/detailhistory', arguments: {
                                  'detailReservation': detailReservation,
                                  'detailPlace': detailPlace
                                });
                              } else {
                                Notif.snackBar(
                                    'Error', 'Failed to get detail place.');
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              );
            }
          },
        ));
  }
}
