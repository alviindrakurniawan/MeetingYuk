import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/explore/widget/explore_listtile.dart';
import 'package:meetingyuk/features/profile/widgets/button.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/view_model/place_viewmodel.dart';
import 'package:meetingyuk/ulits/style.dart';

class PlaceMerchant extends GetView<PlaceViewModel> {
  const PlaceMerchant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0,
          toolbarHeight: 60.0,
          elevation: 0,
          title: Text('Places', style: extraBoldBlack24),
          backgroundColor: Colors.white,
        ),
        body: Obx(
          () {
            if (controller.loading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (controller.placeList.isEmpty) {
                return Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                              EdgeInsets.only(right: 10, top: 15, bottom: 10),
                              child: CustomFilledButton(
                                title: Text(
                                  '+',
                                  style: boldWhite24,
                                ),
                                width: 60,
                                height: 40,
                                borderRad: 20,
                                onPressed: (){

                                },
                              ),
                            )),
                        Text(
                          '0 Place',
                          textAlign: TextAlign.center,
                          style: boldBlack16,
                        ),
                      ],
                    ));
              }else{
                return ListView(
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding:
                          EdgeInsets.only(right: 10, top: 15, bottom: 10),
                          child: CustomFilledButton(
                            title: Text(
                              '+',
                              style: boldWhite24,
                              textAlign: TextAlign.center,
                            ),
                            width: 60,
                            height: 40,
                            borderRad: 20,
                            onPressed: (){
                              Get.toNamed('/addPlace1-merchant',arguments: {'code':'add-place'});
                            },
                          ),
                        )),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.placeList.length,
                      itemBuilder: (BuildContext context, index) {
                        return ExploreListTile(
                          title: controller.placeList[index].name,
                          address: controller.placeList[index].address,
                          imageUrl: controller.placeList[index].imageUrl,
                          rating: controller.placeList[index].ratings,
                          desc: '',
                          onPress: () async {
                            print('PENYEKKKK');
                            final detailPlace = await controller
                                .getDetailPlace(controller.placeList[index].id);
                            Get.toNamed('/detailplace-merchant',
                                arguments: {'detailPlace': detailPlace});
                          },
                        );
                      },
                    ),
                  ],
                );
              }
            }
          },
        ));
  }
}
