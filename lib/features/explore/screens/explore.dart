import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetingyuk/features/explore/view_model/explore_viewmodel.dart';
import 'package:meetingyuk/features/profile/widgets/button.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/style.dart';

class Explore extends GetView<ExploreViewModel> {
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mapController = MapController();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0,
          toolbarHeight: 60.0,
          elevation: 0,
          title: Text('Explore', style: extraBoldBlack24),
          backgroundColor: backgroundColor,
        ),
        body: Container(
            constraints: BoxConstraints.expand(),
            color: backgroundColor,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                      height: 365,
                      child: Obx(() {
                        if (controller.loading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return FlutterMap(
                            mapController: _mapController,
                            options: MapOptions(
                              interactiveFlags: InteractiveFlag.none,
                              center: LatLng(
                                controller.currentPosition.value!.latitude,
                                controller.currentPosition.value!.longitude,
                              ),
                              zoom: controller
                                  .calculateZoom(controller.radius.value),
                            ),
                            nonRotatedChildren: [
                              CircleLayer(
                                circles: [
                                  CircleMarker(
                                      point: LatLng(
                                          controller
                                              .currentPosition.value!.latitude,
                                          controller.currentPosition.value!
                                              .longitude),
                                      radius: (controller.radius.value * 1000),
                                      useRadiusInMeter: true,
                                      borderStrokeWidth: 4,
                                      borderColor: primaryColor,
                                      color: Colors.transparent),
                                ],
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                      point: LatLng(
                                        controller
                                            .currentPosition.value!.latitude,
                                        controller
                                            .currentPosition.value!.longitude,
                                      ),
                                      builder: (context) => Icon(
                                            Icons.location_on,
                                            color: primaryColor,
                                            size: 30,
                                          ))
                                ],
                              )
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
                            ],
                          );
                        }
                      })),
                  //Set KM
                  Container(
                    margin: EdgeInsets.only(
                      top: 30,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          alignment: Alignment.center,
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: Offset(0, 4.0))
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Obx(
                            () => Text(
                              '${controller.radius.value.toInt()}',
                              style: boldBlack20,
                            ),
                          ),
                        ),
                        Text('KM', style: boldBlack16),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                'Set Range by Your Preference',
                                style: boldBlack16,
                              ),
                              Obx(() => Slider(
                                    min: 1,
                                    max: 10,
                                    divisions: 9,
                                    label: '${controller.radius.value}',
                                    activeColor: primaryColor,
                                    inactiveColor: secondaryColor,
                                    value: controller.radius.value,
                                    onChanged: (value) {
                                      controller.changeSlider(value);
                                    },
                                  )),
                              CustomFilledButton(
                                title: Text(
                                  'GO',
                                  style: boldWhite16,
                                ),
                                borderRad: 10,
                                width: 120,
                                onPressed: (){
                                  Get.toNamed('/explorelist',arguments: {'radius':controller.radius.value,'currentPosition':controller.currentPosition.value});


                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
