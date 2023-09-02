import 'package:flutter/material.dart';
import 'package:meetingyuk/features/explore/widget/explore_listtile.dart';
import 'package:meetingyuk/features/home/view_model/home_viewmodel.dart';
import 'package:meetingyuk/features/home/view_model/search_viewmodel.dart';
import 'package:meetingyuk/ulits/color.dart';

import 'package:get/get.dart';
import 'package:meetingyuk/ulits/style.dart';

class SeachPage extends GetView<SearchViewModel> {
  const SeachPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerHome = Get.find<HomeViewModel>();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0,
          toolbarHeight: 60.0,
          elevation: 0,
          title: Container(
            height: 36,
            margin: EdgeInsets.only(right: 20),
            child: TextField(
              controller: controller.searchbar,
              textAlignVertical: TextAlignVertical.bottom,
              style: const TextStyle(fontSize: 12),
              focusNode: controller.focusNode,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 20.0, left: 15.0),
                    child: Icon(
                      Icons.search,
                      color: grey,
                      size: 22,
                    ),
                  ),
                  hintText: 'Find a meeting spot',
                  hintStyle: TextStyle(
                    fontSize: 12.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                      borderRadius: BorderRadius.circular(10.0)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                      borderRadius: BorderRadius.circular(10.0))),
              onChanged: (value) {
                controller.searchPlace(value);
              },
            ),
          ),
          backgroundColor: Colors.white,
          leading: Padding(
            padding: EdgeInsets.only(left: 5),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: blackColor,
                size: 18,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => controller.searchList.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50),
                    child: Text(
                      '0 Place Founded',
                      textAlign: TextAlign.center,
                      style: boldBlack16,
                    ))
                : controller.loading.value == true
                    ? Container(
                        constraints: BoxConstraints.expand(),
                        child: CircularProgressIndicator())
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.searchList.length<15
                            ? controller.searchList.length
                            :15,
                        itemBuilder: (BuildContext context, index) {
                          return ExploreListTile(
                            title: controller.searchList[index].name,
                            address: controller.searchList[index].address,
                            imageUrl: controller.searchList[index].imageUrl,
                            rating: controller.searchList[index].ratings,
                            desc: '',
                            onPress: () async {
                              final detailPlace =
                                  await controllerHome.getDetailPlace(
                                      controller.searchList[index].id);
                              Get.toNamed('/detailplace',
                                  arguments: {'detailPlace': detailPlace});
                            },
                          );
                        },
                      ))
          ],
        )));
  }
}
