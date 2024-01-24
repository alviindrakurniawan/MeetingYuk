import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MeetingYuk/features/home/view_model/home_viewmodel.dart';
import 'package:MeetingYuk/features/home/widget/card_cafe_distance.dart';
import 'package:MeetingYuk/features/home/widget/card_cafe_noprice.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:MeetingYuk/features/home/widget/cafe_card_recommen.dart';

class Home extends GetView<HomeViewModel> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<HomeViewModel>(HomeViewModel());
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
              onTap: () async {
                Get.toNamed('/chat');
              },
              child: Image.asset(
                'assets/icons/chat28.png',
                height: 28,
                width: 28,
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: () async {},
          //   child: Padding(
          //     padding: EdgeInsets.only(right: 15, left: 10, top: 5),
          //     child: Image.asset(
          //       'assets/icons/bookmark.png',
          //       height: 28,
          //       width: 28,
          //     ),
          //   ),
          // ),
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
              ])),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          //NearMe
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text('Near Me', style: boldPrimMenu)),
              GestureDetector(
                onTap: () async {
                  controller.headerListPage.value = 'Near Me';
                  Get.toNamed('/listpage');
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: primaryColor,
                    )),
              )
            ],
          ),
          //NearMe card
          Container(
            padding: EdgeInsets.only(left: 8),
            margin: EdgeInsets.only(top: 10, bottom: 20),
            height: 260,
            child: Obx(
              () {
                if (controller.loadingNearme.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 20 / 15),
                    itemCount: controller.nearMeList.length < 6
                        ? controller.nearMeList.length
                        : 6,
                    itemBuilder: (BuildContext context, index) {
                      return CardCafeDistance(
                        imageUrl: controller.nearMeList[index].imageUrl!,
                        name: controller.nearMeList[index].name!,
                        address: controller.nearMeList[index].address!,
                        rating: controller.nearMeList[index].ratings!,
                        distance: controller.nearMeList[index].distanceInKm!,
                        onTap: () async {
                          final detailPlace = await controller
                              .getDetailPlace(controller.nearMeList[index].id!);
                          Get.toNamed('/detailplace',
                              arguments: {'detailPlace': detailPlace});
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),

          //Best Rated
          Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text('Best Rated', style: boldPrimMenu)),
              GestureDetector(
                onTap: () async {
                  controller.headerListPage.value = 'Best Rated';
                  Get.toNamed('/listpage');
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: primaryColor,
                    )),
              )
            ],
          ),
          //BestRated Card
          Container(
            padding: EdgeInsets.only(left: 8),
            margin: EdgeInsets.only(top: 10, bottom: 20),
            height: 240,
            child: Obx(() {
              if (controller.loadingBestRated.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 20 / 15),
                    itemCount: controller.bestRatedList.length < 6
                        ? controller.bestRatedList.length
                        : 6,
                    itemBuilder: (BuildContext context, index) {
                      return CardCafeNoPrice(
                        imageUrl: controller.bestRatedList[index].imageUrl,
                        name: controller.bestRatedList[index].name,
                        address: controller.bestRatedList[index].address,
                        rating: controller.bestRatedList[index].ratings,
                        onTap: () async {
                          final detailPlace = await controller.getDetailPlace(
                              controller.bestRatedList[index].id);
                          Get.toNamed('/detailplace',
                              arguments: {'detailPlace': detailPlace});
                        },
                      );
                    });
              }
            }),
          ),

          //Prev Booking
          Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text('Previous Bookings', style: boldPrimMenu)),
            ],
          ),
          //Prev Booking Card
          Obx(
            () => controller.loadingPrevious.value == true
                ? Center(child: CircularProgressIndicator())
                : controller.reservationHistoryList.isEmpty
                    ? Container(height: 30)
                    : Container(
                        padding: EdgeInsets.only(left: 8),
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        height: 285,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 255 / 165),
                          itemCount:
                              controller.reservationHistoryList.length < 6
                                  ? controller.reservationHistoryList.length
                                  : 6,
                          itemBuilder: (BuildContext context, index) {
                            return CafeCardRecom(
                              imageUrl: controller
                                  .reservationHistoryList[index].placeImage,
                              namePlace: controller
                                  .reservationHistoryList[index].placeName,
                              nameRoom: controller
                                  .reservationHistoryList[index].roomName,
                              startAt: controller
                                  .reservationHistoryList[index].startAt,
                              endAt: controller
                                  .reservationHistoryList[index].endAt,
                              totalPrice: controller
                                  .reservationHistoryList[index].totalPrice,
                              onTap: () async {
                                final detailPlace =
                                    await controller.getDetailPlace(controller
                                        .reservationHistoryList[index].placeId);
                                Get.toNamed('/detailplace',
                                    arguments: {'detailPlace': detailPlace});
                              },
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
