import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:MeetingYuk/features/chat/view_model/chat_controller.dart';
import 'package:MeetingYuk/features/home/view_model/reservation_viewmodel.dart';
import 'package:MeetingYuk/features/home/widget/card_room.dart';
import 'package:MeetingYuk/features/home/widget/facilities.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:get/get.dart';

class DetailPlace extends GetView<ReservationViewModel> {
  const DetailPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildRating(double rating) {
      List<Widget> stars = [];

      // Add full stars
      for (int i = 0; i < rating.floor(); i++) {
        stars.add(const Icon(
          Icons.star_sharp,
          size: 12,
          color: primaryColor,
        ));
      }

      // Add a half star if there's a remainder
      if (rating - rating.floor() >= 0.5) {
        stars.add(
            const Icon(Icons.star_half_sharp, size: 12, color: primaryColor));
      }

      // Add empty stars to fill up to 5
      while (stars.length < 5) {
        stars.add(
            const Icon(Icons.star_border_sharp, size: 12, color: primaryColor));
      }
      stars.add(const SizedBox(width: 5));
      stars.add(Text(
        '${rating.toStringAsFixed(1)} / 5.0',
        style: regularBlack12,
      ));

      return Row(children: stars);
    }

    void popUpDetail(int indexPage) {
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider.builder(
                    itemCount: controller
                        .detailPlace.value!.rooms[indexPage].imageUrls.length,
                    itemBuilder: (context, int itemIndex, int pageViewIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        // Border radius
                        child: Image.network(
                            controller.detailPlace.value!.rooms[indexPage].imageUrls[itemIndex],
                            fit: BoxFit
                                .cover), // To ensure the image covers the container
                      );
                    },
                    options: CarouselOptions(
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayInterval: Duration(seconds: 5),
                      enlargeCenterPage: true,
                      autoPlay: true,
                      viewportFraction: 1,
                      // Ensures there's no space between items
                      onPageChanged: (index, reason) {
                        // Handle page change if needed
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(24, 17, 24, 17),
                  // decoration: BoxDecoration(border: Border.all(color: grey.withOpacity(50), width: 1),),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.detailPlace.value!.rooms[indexPage].name}',
                        style: boldBlack14,
                      ),
                      SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: blackColor,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${controller.detailPlace.value!.rooms[indexPage].maxCapacity} Person',
                            style: regularBlack12,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.access_time_filled,
                            color: blackColor,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Max ${controller.detailPlace.value!.rooms[indexPage].maxDuration} Hours',
                            style: regularBlack12,
                          )
                        ],
                      ),
                      Row(children: [
                        Icon(Icons.location_on,size: 14,color: primaryColor,),
                        SizedBox(width: 4),
                        Expanded(child: Text('${controller.detailPlace.value!.address}',style: regularPrim12,overflow: TextOverflow.ellipsis,))
                      ],),
                      SizedBox(height: 20),
                      buildFacilitiesPopUp(controller.detailPlace.value!.rooms[indexPage].facilities)

                    ],
                  ),
                ),
                // Divider(color: blackColor.withOpacity(50))
              ],
            ),
          ),
        ),
      );
    }
    GetStorage storage=GetStorage();
    final ChatViewModel chatController = Get.find();

    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                      Get.delete<ReservationViewModel>;
                    },
                    icon: Icon(Icons.arrow_back_ios_new_sharp,
                        size: 20, color: grey)),
              ),
              backgroundColor: Colors.white,
              expandedHeight: 215,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  controller.detailPlace.value!.imageUrl,
                  height: 215,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
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
                        SizedBox(height: 4),
                        Text(
                          controller.detailPlace.value!.name,
                          style: boldGrey14,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                size: 12,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Expanded(
                                child: Text(
                                  controller.detailPlace.value!.address,
                                  style: regularPrim12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ]),
                        SizedBox(height: 3),
                        buildRating(controller.detailPlace.value!.ratings),
                        SizedBox(height: 4),
                        InkWell(
                          onTap: () {
                            print('1');
                            chatController
                                .getChatId(controller.detailPlace.value!.name)
                                .then((result) {
                                  print(result['chatId']);
                              if (result['chatId'] == 'NOT FOUND') {
                                print('2.1');

                                final key = storage.read('public_key');
                                final merchPubKey= 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh9li1m0VWUjN2wZiCX46k9U3aAgfJ6WKkW0Y6MP30n2ajScZUFqj2eB3w7qHyLJAXVAxXe0E2sxtO20mRphOtv91fRjWj2nLXGKi//jZb/JewZvvgXRIi5JAZQlL5ChrBpNf8RRFscj2HzBNyNlZd0GrOwYoyf8+fSGO8Sj4tDrcq0FctCEqww7eUEP8+4VKOYSnwmMtnowxmeEv6hNUz0hHx2qiT425YtOIwRB0H5B773oTsZH9o04343ZlU+8H/3TEU1QA/OZU+S45jc6tmy9cmS+wulsyB1ps3XMAorvVkDcEBZTvJGr2iO/R4pfT8DW0PtzqwcWxiqkn40ZnZQIDAQAB';
                                chatController.initiateChat(
                                  controller.detailPlace.value!.ownerId,
                                  controller.detailPlace.value!.name,
                                  controller.detailPlace.value!.imageUrl,
                                  key,
                                  merchPubKey,
                                );
                                print('2');
                                Get.toNamed('/chat');
                              } else {
                                print('3.1');
                                chatController.selectChat(
                                  result['chatId'],
                                  controller.detailPlace.value!.ownerId,
                                  controller.detailPlace.value!.name,
                                  controller.detailPlace.value!.imageUrl,
                                  result['roomKey'],
                                );
                                print('3');
                                Get.toNamed('/detail-chat');
                              }
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.chat,
                                  color: Color(0xFF5ABCD0),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Chat Now',
                                  style: TextStyle(
                                    color: Color(0xFF5ABCD0),
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  //Operational Hours
                  Container(
                    margin: EdgeInsets.only(left: 7.5, right: 7.5, bottom: 15),
                    padding: EdgeInsets.only(
                        left: 15, top: 10, right: 15, bottom: 10),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text('Operational Hours', style: boldBlack14)),
                        SizedBox(height: 10),
                        Table(
                          columnWidths: {
                            0: FlexColumnWidth(4),
                            1: FlexColumnWidth(0.5),
                            2: FlexColumnWidth(10),
                          },
                          children: [
                            TableRow(children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text('Monday', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text(':', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: controller.detailPlace.value!
                                          .openingHours.monday.isNotEmpty
                                      ? Text(
                                          '${controller.detailPlace.value!.openingHours.monday}',
                                          style: regularGrey12)
                                      : Text('Closed',
                                          style: TextStyle(
                                              fontSize: 12, color: redColor)))
                            ]),
                            TableRow(children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text('Tuesday', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text(':', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: controller.detailPlace.value!
                                          .openingHours.tuesday.isNotEmpty
                                      ? Text(
                                          '${controller.detailPlace.value!.openingHours.tuesday}',
                                          style: regularGrey12)
                                      : Text('Closed',
                                          style: TextStyle(
                                              fontSize: 12, color: redColor)))
                            ]),
                            TableRow(children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child:
                                      Text('Wednesday', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text(':', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: controller.detailPlace.value!
                                          .openingHours.wednesday.isNotEmpty
                                      ? Text(
                                          '${controller.detailPlace.value!.openingHours.wednesday}',
                                          style: regularGrey12)
                                      : Text('Closed',
                                          style: TextStyle(
                                              fontSize: 12, color: redColor)))
                            ]),
                            TableRow(children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text('Thursday', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text(':', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: controller.detailPlace.value!
                                          .openingHours.thursday.isNotEmpty
                                      ? Text(
                                          '${controller.detailPlace.value!.openingHours.thursday}',
                                          style: regularGrey12)
                                      : Text('Closed',
                                          style: TextStyle(
                                              fontSize: 12, color: redColor)))
                            ]),
                            TableRow(children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text('Friday', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text(':', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: controller.detailPlace.value!
                                          .openingHours.friday.isNotEmpty
                                      ? Text(
                                          '${controller.detailPlace.value!.openingHours.friday}',
                                          style: regularGrey12)
                                      : Text('Closed',
                                          style: TextStyle(
                                              fontSize: 12, color: redColor)))
                            ]),
                            TableRow(children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text('Saturday', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text(':', style: mediumGrey12)),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.5),
                                  child: controller.detailPlace.value!
                                          .openingHours.saturday.isNotEmpty
                                      ? Text(
                                          '${controller.detailPlace.value!.openingHours.saturday}',
                                          style: regularGrey12)
                                      : Text('Closed',
                                          style: TextStyle(
                                              fontSize: 12, color: redColor)))
                            ]),
                            TableRow(children: [
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text('Sunday', style: mediumGrey12)),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.5),
                                  child: Text(':', style: mediumGrey12)),
                              Container(
                                  margin: EdgeInsets.symmetric(vertical: 2.5),
                                  child: controller.detailPlace.value!
                                          .openingHours.sunday.isNotEmpty
                                      ? Text(
                                          '${controller.detailPlace.value!.openingHours.sunday}',
                                          style: regularGrey12)
                                      : Text('Closed',
                                          style: TextStyle(
                                              fontSize: 12, color: redColor)))
                            ])
                          ],
                        ),
                      ],
                    ),
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
                        Text('Location', style: boldBlack14),
                        SizedBox(height: 10),
                        Container(
                            height: 145,
                            child: FlutterMap(
                              options: MapOptions(
                                center: LatLng(
                                    controller
                                        .detailPlace.value!.location.latitude,
                                    controller
                                        .detailPlace.value!.location.longitude),
                                zoom: 15,
                              ),
                              nonRotatedChildren: [],
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
                                            controller.detailPlace.value!
                                                .location.latitude,
                                            controller.detailPlace.value!
                                                .location.longitude),
                                        builder: (context) => Icon(
                                              Icons.location_on,
                                              color: primaryColor,
                                              size: 30,
                                            ))
                                  ],
                                )
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Text(
                                controller.detailPlace.value!.address,
                                style: regularGrey10,
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                              )),

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //Room
                  Container(
                    padding:
                        EdgeInsets.only(left: 5, top: 15, right: 5, bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Where do you want to meet ?', style: boldBlack14),
                        SizedBox(height: 10),
                        CarouselSlider.builder(
                            itemCount:
                                controller.detailPlace.value!.rooms.length,
                            options: CarouselOptions(
                              initialPage: 0,
                              viewportFraction: 0.6,
                              height: 235,
                              autoPlay: false,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.1,
                              onPageChanged: (index,reason){
                                controller.indexRoom.value = index;
                                print( controller.indexRoom.value);
                              },
                            ),
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                CardRoom(
                                  imageUrl: controller.detailPlace.value!
                                      .rooms[itemIndex].imageUrls[0],
                                  nameRoom: controller
                                      .detailPlace.value!.rooms[itemIndex].name,
                                  maxPerson: controller.detailPlace.value!
                                      .rooms[itemIndex].maxCapacity
                                      .toString(),
                                  maxTimeBook: controller.detailPlace.value!
                                      .rooms[itemIndex].maxDuration
                                      .toString(),
                                  priceRoom: controller.intToMoneyString(
                                      controller.detailPlace.value!
                                          .rooms[itemIndex].price),
                                  doubleTap: () {
                                    popUpDetail(pageViewIndex);
                                  },
                                )),
                        SizedBox(height: 5),
                        Text(
                          'Double click to see the detail',
                          style: mediumBlack12,
                        ),
                        SizedBox(height: 3)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: primaryColor,
          width: double.infinity,
          height: 60.0,
          child: TextButton(
            onPressed: () {
              Get.toNamed('/reservation');

            },
            child: Text(
              'BOOK THIS ROOM',
              style: boldWhite14,
            ),
          ),
        ));
  }
}
