import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:MeetingYuk/features/history/view_model/detailhistory_viewmodel.dart';
import 'package:MeetingYuk/features/history/view_model/history_viewmodel.dart';
import 'package:MeetingYuk/features/home/model/detail_reservation.dart';
import 'package:MeetingYuk/features/home/widget/card_room.dart';
import 'package:MeetingYuk/features/home/widget/facilities.dart';
import 'package:MeetingYuk/features/profile/widgets/button.dart';

import 'package:MeetingYuk/features/home/model/detail_place.dart';

class HistoryDetailPage extends GetView<DetailHistoryViewModel> {
  const HistoryDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailReservation detailReservation =
        Get.arguments['detailReservation'];
    final DetailPlace detailPlace = Get.arguments['detailPlace'];
    final _mapController = MapController();
    DateTime dateStart = DateTime.parse(detailReservation.startAt.toString());
    DateTime dateEnd = DateTime.parse(detailReservation.endAt.toString());

    Widget buildRating(double rating) {
      List<Widget> stars = [];

      // Add full stars
      for (int i = 0; i < rating.floor(); i++) {
        stars.add(Icon(Icons.star_sharp, color: primaryColor, size: 12));
      }

      // Add a half star if there's a remainder
      if (rating - rating.floor() >= 0.5) {
        stars.add(Icon(Icons.star_half_sharp, color: primaryColor, size: 12));
      }

      // Add empty stars to fill up to 5
      while (stars.length < 5) {
        stars.add(Icon(Icons.star_border_sharp, color: primaryColor, size: 12));
      }
      stars.add(SizedBox(width: 5));
      stars.add(Text(
        '$rating / 5.0',
        style: boldPrim12,
      ));

      return Row(children: stars);
    }

    void toCancel() {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Cancel This Reservation?',
              textAlign: TextAlign.center, style: mediumBlack16),
          titlePadding: EdgeInsets.only(top: 30, left: 11, right: 11),
          contentPadding: EdgeInsets.only(top: 50, bottom: 20),
          content: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFilledButton(
                        title: Text('NO', style: boldWhite16),
                        borderRad: 10,
                        width: 118,
                        height: 40,
                        onPressed: () {
                          Get.back();
                        },
                        color: redColor),
                    SizedBox(width: 20),
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
                              title: Text('YES', style: boldWhite16),
                              borderRad: 10,
                              width: 118,
                              height: 40,
                              onPressed: () {
                                controller
                                    .cancelReservation(detailReservation.id);
                                Get.back();
                              },
                              color: primaryColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    }

    VoidCallback? funcButtonCancel(int detailStatus) {
      switch (detailStatus) {
        case 0:
          return () {
            toCancel();
          };
        case 1:
          return () {};
        case 2:
          return () {};
        case 3:
          return () {};
      }
    }

    VoidCallback funcButtonUpdate(int detailStatus) {
      switch (detailStatus) {
        case 3:
          return () {};
        default:
          return () {
            Get.toNamed('/reservation', arguments: {
              'reservationId': detailReservation.id,
              'detailPlace': detailPlace
            });
          };
      }
    }

    Color colorButtonCancel(int detailStatus) {
      switch (detailStatus) {
        case 0:
          return redColor;
        case 1:
          return lightGrey;
        case 2:
          return lightGrey;
        case 3:
          return lightGrey;
        default:
          return lightGrey;
      }
    }

    Color colorButtonUpdate(int detailStatus) {
      switch (detailStatus) {
        case 3:
          return lightGrey;
        default:
          return primaryColor;
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: IconButton(
                  onPressed: () {
                    Get.delete<HistoryViewModel>();
                    Get.back();
                    Get.put(HistoryViewModel());
                  },
                  icon: Icon(Icons.arrow_back_ios_new_sharp,
                      size: 20, color: grey)),
            ),
            backgroundColor: Colors.white,
            expandedHeight: 215,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
              detailPlace.imageUrl,
              height: 215,
              width: double.infinity,
              fit: BoxFit.cover,
            )),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //Cafe Info
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              strokeAlign: BorderSide.strokeAlignInside,
                              color: Color(0xFFC7C7c7),
                              width: 1))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        detailPlace.name,
                        style: boldGrey14,
                        overflow: TextOverflow.clip,
                      ),
                      SizedBox(height: 3),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(
                          Icons.location_on_sharp,
                          size: 12,
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Flexible(
                          child: Text(
                            detailPlace.address,
                            style: regularPrim12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ]),
                      SizedBox(height: 3),
                      buildRating(detailPlace.ratings),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                //Status Info
                Container(
                  margin: EdgeInsets.only(
                      left: 7.5, right: 7.5, top: 15, bottom: 15),
                  padding:
                      EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 4.0))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text('Status', style: boldBlack14),
                      SizedBox(height: 5),
                      Text(
                        controller.checkStatus(detailReservation.status),
                        style: boldBlack20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //Update button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomFilledButton(
                              title: Text('UPDATE', style: boldWhite12),
                              color:
                                  colorButtonUpdate(detailReservation.status),
                              width: 85,
                              height: 35,
                              borderRad: 10,
                              onPressed:
                                  funcButtonUpdate(detailReservation.status)),
                          SizedBox(width: 10),
                          CustomFilledButton(
                              title: Text('CANCEL', style: boldWhite12),
                              color:
                                  colorButtonCancel(detailReservation.status),
                              width: 85,
                              height: 35,
                              borderRad: 10,
                              onPressed:
                                  funcButtonCancel(detailReservation.status))
                        ],
                      ),
                    ],
                  ),
                ),
                detailReservation.participants.isEmpty
                    ? SizedBox()
                    : Container(
                        height: 150,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        margin: EdgeInsets.symmetric(horizontal: 7.5),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(0, 1.0),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Participant',
                              style: boldBlack14,
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.only(top: 10),
                                itemCount:
                                    detailReservation.participants.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 5),
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.person),
                                        SizedBox(width: 10),
                                        Text(
                                          detailReservation
                                              .participants[index].name,
                                          style: mediumBlack14,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                SizedBox(
                  height: 10,
                ),
                //Room
                Container(
                  padding:
                      EdgeInsets.only(left: 5, top: 15, right: 5, bottom: 15),
                  margin: EdgeInsets.symmetric(horizontal: 7.5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 1.0))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Room', style: boldBlack14),
                      SizedBox(height: 10),
                      CardRoom(
                        imageUrl: '${detailReservation.room.imageUrls[0]}',
                        nameRoom: '${detailReservation.room.name}',
                        maxPerson: '${detailReservation.room.maxCapacity}',
                        maxTimeBook: '${detailReservation.room.maxDuration}',
                        priceRoom:
                            '${controller.intToMoneyString(detailReservation.room.price.toInt())}',
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 12, left: 35, right: 35),
                        child: Column(
                          children: [
                            //Biaya
                            Container(
                                padding: EdgeInsets.only(
                                    left: 12, top: 6, right: 24, bottom: 6),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 4,
                                          spreadRadius: 0,
                                          offset: Offset(0, 3.0))
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total Biaya',
                                          style: boldBlack16,
                                        ),
                                        Text(
                                          "${dateStart.day} ${dateStart.month.toString().padLeft(2, '0')} ${dateStart.year}",
                                          style: regularBlack12,
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Rp ${controller.intToMoneyString(detailReservation.totalPrice)}',
                                          style: boldBlack20,
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            //Time
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          top: 6,
                                          right: 24,
                                          bottom: 6),
                                      margin: EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                                offset: Offset(0, 3.0))
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 24,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Start',
                                                style: regularBlack12,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                '${dateStart.hour.toString().padLeft(2, '0')}:${dateStart.minute.toString().padLeft(2, '0')}',
                                                style: boldBlack14,
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                //Time Booking
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          top: 6,
                                          right: 24,
                                          bottom: 6),
                                      margin: EdgeInsets.only(top: 15),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                spreadRadius: 0,
                                                offset: Offset(0, 3.0))
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            size: 24,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'End',
                                                style: regularBlack12,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                '${dateEnd.hour.toString().padLeft(2, '0')}:${dateEnd.minute.toString().padLeft(2, '0')}',
                                                style: boldBlack14,
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Facilities
                widgetFacilitiesByRoomId(
                  detailPlace,
                  detailReservation.room.roomId,
                ),
                //Location
                Container(
                  margin: EdgeInsets.only(left: 7.5, right: 7.5, bottom: 15),
                  padding:
                      EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: Offset(0, 4.0))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Location', style: boldGrey14),
                      SizedBox(height: 10),
                      Container(
                          height: 145,
                          child: FlutterMap(
                            options: MapOptions(
                              center: LatLng(
                                  detailPlace.location.latitude.toDouble(),
                                  detailPlace.location.longitude.toDouble()),
                              zoom: 16,
                            ),
                            nonRotatedChildren: [
                              // RichAttributionWidget(
                              //   attributions: [
                              //     TextSourceAttribution(
                              //       'OpenStreetMap contributors',
                              //       onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                              //     ),
                              //   ],
                              // ),
                            ],
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.app',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                      point: LatLng(
                                          detailPlace.location.latitude
                                              .toDouble(),
                                          detailPlace.location.longitude
                                              .toDouble()),
                                      builder: (context) => Icon(
                                            Icons.location_on,
                                            color: primaryColor,
                                            size: 30,
                                          ))
                                ],
                              )
                            ],
                          )),
                      // GoogleMapImage(
                      //     apiKey: 'AIzaSyBEISB8hHC1XiisTkTxRSi0Ot8Pi3tIwtk',
                      //     cafeName: 'Cronica Creative',
                      //     width: 350,
                      //     height: 145),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(
                              detailPlace.address,
                              style: regularGrey10,
                            )),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                        width: 1, color: primaryColor)),
                                height: 19,
                                width: 35,
                                child: IconButton(
                                  padding: EdgeInsets.all(0),
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  icon: Icon(Icons.turn_right,
                                      color: primaryColor, size: 16),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //
    );
  }
}
