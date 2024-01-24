import 'package:flutter/material.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/style.dart';
import 'package:MeetingYuk/features/explore/widget/explore_listtile.dart';
import 'package:MeetingYuk/features/home/view_model/home_viewmodel.dart';

import 'package:get/get.dart';

class ListPage extends GetView<HomeViewModel> {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0,
          toolbarHeight: 60.0,
          elevation: 0,
          title: Obx(()=>Text('${controller.headerListPage.value}', style: extraBoldBlack24)),
          backgroundColor: Colors.white,
          leading: Padding(
            padding: EdgeInsets.only(left: 20),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                splashRadius: 25,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: blackColor,
                  size: 18,
                )),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Obx(() =>
              controller.headerListPage.value=='Near Me'?
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.nearMeList.length,
                itemBuilder: (BuildContext context, index) {
                  return ExploreListTile(
                    title: controller.nearMeList[index].name!,
                    address: controller.nearMeList[index].address!,
                    imageUrl: controller.nearMeList[index].imageUrl!,
                    rating: controller.nearMeList[index].ratings!,
                    desc:
                    '${controller.nearMeList[index].distanceInKm!.toStringAsFixed(2)} Km',
                    onPress: () async {
                      print('PENYEKKKK');
                      final detailPlace = await controller
                          .getDetailPlace(controller.nearMeList[index].id!);
                      Get.toNamed('/detailplace',
                          arguments: {'detailPlace': detailPlace});
                    },
                  );
                },
              )
              : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 15,
                itemBuilder: (BuildContext context, index) {
                  return ExploreListTile(
                    title: controller.bestRatedList[index].name,
                    address: controller.bestRatedList[index].address,
                    imageUrl: controller.bestRatedList[index].imageUrl,
                    rating: controller.bestRatedList[index].ratings,
                    desc:
                    'No ${index+1}',
                    onPress: () async {
                      final detailPlace = await controller
                          .getDetailPlace(controller.bestRatedList[index].id);
                      Get.toNamed('/detailplace',
                          arguments: {'detailPlace': detailPlace});
                    },
                  );
                },
              )
            )
            // ListView.builder(
            //   physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true, // This is important!
            //   itemCount: controller.placeList.length,
            //   itemBuilder: (BuildContext context, index) {
            //     return ExploreListTile(
            //       title: controller.placeList[index].name!,
            //       address: controller.placeList[index].address!,
            //       imageUrl: controller.placeList[index].imageUrl!,
            //       rating: controller.placeList[index].ratings!,
            //       desc:
            //       '${controller.placeList[index].distanceInKm!.toStringAsFixed(2)} Km',
            //       onPress: () async {
            //         print('PENYEKKKK');
            //         final detailPlace = await controller
            //             .getDetailPlace(controller.placeList[index].id!);
            //         Get.toNamed('/detailplace',
            //             arguments: {'detailPlace': detailPlace});
            //       },
            //     );
            //   },
            // ),
          ],
        )));
  }
}
