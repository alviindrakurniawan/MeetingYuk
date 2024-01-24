import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:MeetingYuk/features/profile/widgets/button.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/view_model/edit_place_viewmodel.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/common/ulits/notif.dart';
import 'package:MeetingYuk/common/ulits/style.dart';

class PickLocation extends GetView<EditPlaceViewModel> {
  const PickLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapController _mapController = MapController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pick Location',
          style: extraBoldBlack24,
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
              onPressed: () {
                controller.addressMapDetail.value='';
                controller.addressMapName.value='';
                Get.back();
              },
              splashRadius: 25,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: blackColor,
              )),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 200,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(
                    controller.latitudeMap.value,
                    controller.longitudeMap.value),
                zoom: 15,
                onPositionChanged: (position, hasGesture) {
                  if (hasGesture) {
                    controller.setCenterPoint(_mapController.center);
                  }
                },
              ),
              nonRotatedChildren: [
                Align(
                  alignment:Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Icon(
                      Icons.location_on_sharp,
                      color: primaryColor,
                      size: 40,
                    ),
                  ),
                )
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
                            controller.currentPosition.value!
                                .latitude,
                            controller.currentPosition.value!
                                .longitude),
                        builder: (context) => Icon(
                          Icons.my_location,
                          color: primaryColor,
                          size: 30,
                        ))
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              child: BottomAppBar(
                child: Container(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5,top: 5),
                        child: Text(
                          'Select Place Location',
                          style: boldBlack20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 40,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(()=>
                                  Text(
                                    controller.addressMapName.value,
                                    style: boldBlack16,
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 35,
                                  child: Obx(()=>
                                    Text(
                                      controller.addressMapDetail.value,
                                      style: regBlack14,
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomFilledButton(
                        height: 50,
                        borderRad: 20,
                        title: Text(
                          'Pick Location',
                          style: boldWhite16,
                        ),
                        onPressed: ()async{
                         await controller.setPickLocation();
                         Get.back();
                         controller.refreshMaps();
                         controller.latitudeMapFix.refresh();
                         controller.longitudeMapFix.refresh();


                         



                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      //   child: BottomAppBar(
      //     child: Container(
      //       padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      //       decoration: BoxDecoration(
      //           color: Colors.white),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(left: 5,top: 5),
      //             child: Text(
      //               'Select Place Location',
      //               style: boldBlack20,
      //             ),
      //           ),
      //           SizedBox(
      //             height: 20,
      //           ),
      //           Row(
      //             mainAxisSize: MainAxisSize.min,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Icon(
      //                 Icons.location_pin,
      //                 size: 40,
      //                 color: primaryColor,
      //               ),
      //               SizedBox(
      //                 width: 10,
      //               ),
      //               Flexible(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       'BRI Cafe & Hotel',
      //                       style: boldBlack16,
      //                     ),
      //                     SizedBox(
      //                       height: 5,
      //                     ),
      //                     Text(
      //                       'Jalan Piyungan prambanan km 2,ngaglikm, sleman, DIT',
      //                       style: regBlack14,
      //                       softWrap: true,
      //                       maxLines: 2,
      //                       overflow: TextOverflow.clip,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: 15,
      //           ),
      //           CustomFilledButton(
      //             height: 50,
      //             borderRad: 20,
      //             title: Text(
      //               'Pick Location',
      //               style: boldWhite16,
      //             ),
      //             onPressed: (){
      //
      //             },
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
