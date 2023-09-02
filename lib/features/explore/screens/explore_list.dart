import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/explore/view_model/explorelist_viewmodel.dart';
import 'package:meetingyuk/features/explore/widget/explore_listtile.dart';
import 'package:meetingyuk/features/home/view_model/dasboard_viewmodel.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/style.dart';

class ListExplore extends GetView<ListExploreViewModel> {
  const ListExplore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    final dashController = Get.find<DashViewModel>();


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        toolbarHeight: 60.0,
        elevation: 0,
        title: Text('Explore', style: extraBoldBlack24),
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  dashController.changeScreen2(0);
                  Get.toNamed('/home');
                },
                splashRadius: 25,
                icon: Icon(
                  Icons.home,
                  color: blackColor,
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.loading.value == true) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (controller.placeList.isEmpty) {
              return Container(
                alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 50),
                  child: Text(
                    '0 place \nhas been founded in this area',
                    textAlign: TextAlign.center,
                    style: boldBlack16,
                  ));
            } else {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, right: 10, left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Best places within ${controller.radius.value!.toInt()} KM',
                        style: mediumBlack14,
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.placeList.length,
                    itemBuilder: (BuildContext context, index) {
                      return ExploreListTile(
                        title: controller.placeList[index].name!,
                        address: controller.placeList[index].address!,
                        imageUrl: controller.placeList[index].imageUrl!,
                        rating: controller.placeList[index].ratings!,
                        desc:
                            '${controller.placeList[index].distanceInKm!.toStringAsFixed(2)} Km',
                        onPress: () async {
                          print('PENYEKKKK');
                          final detailPlace = await controller
                              .getDetailPlace(controller.placeList[index].id!);
                          Get.toNamed('/detailplace',
                              arguments: {'detailPlace': detailPlace});
                        },
                      );
                    },
                  ),
                ],
              );
            }
          }
        }),
      ),
    );
  }
}
