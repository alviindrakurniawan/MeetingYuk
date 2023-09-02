import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/profile/widgets/button.dart';
import 'package:meetingyuk/features/profile/widgets/custom_form.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/view_model/edit_place_viewmodel.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:meetingyuk/ulits/style.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EditPlace extends GetView<EditPlaceViewModel> {
  const EditPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Place',
            style: extraBoldBlack24,
          ),
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                splashRadius: 25,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: blackColor,
                )),
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(scrollDirection: Axis.vertical, children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 24, right: 24),
              padding:
                  EdgeInsets.only(top: 22, left: 22, right: 22, bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  CustomForm(
                    title: 'Place Name',
                    controller: controller.nameController,
                    focusNode: controller.nameFocusNode,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      Notif.fieldFocusChange(context, controller.nameFocusNode,
                          controller.addressFocusNode);
                    },
                    validator: (value) {
                      return controller.validateEmpty(value);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFilledButton(
                      width: 130,
                      height: 45,
                      borderRad: 15,
                      title: Text(
                        'Set Location',
                        style: boldWhite14,
                      ),
                      onPressed: () async{
                        //set centermap
                        controller.latitudeMap.value=controller.detailPlace.value!.location.latitude;
                        controller.longitudeMap.value=controller.detailPlace.value!.location.longitude;
                        Get.toNamed('/set-location');
                      }),
                  SizedBox(height: 10,),
                  GetBuilder<EditPlaceViewModel>(
                    id: 'maps',
                    builder: (controller) {
                      return Container(
                        height: 145,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: FlutterMap(
                            key: Key("${controller.latitudeMapFix.value}-${controller.longitudeMapFix.value}"),  // Unique Key based on latitude and longitude
                            options: MapOptions(
                              interactiveFlags: InteractiveFlag.none,
                              center: LatLng(
                                  controller.latitudeMapFix.value,
                                  controller.longitudeMapFix.value
                              ),
                              zoom: 15,
                            ),
                            nonRotatedChildren: [],
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.app',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                      point: LatLng(
                                          controller.latitudeMapFix.value,
                                          controller.longitudeMapFix.value
                                      ),
                                      builder: (context) => Icon(
                                        Icons.location_on_sharp,
                                        color: primaryColor,
                                        size: 30,
                                      )
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 22),
                  CustomForm(
                    title: 'Address',
                    controller: controller.addressController,
                    focusNode: controller.addressFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      Notif.fieldFocusChange(
                          context,
                          controller.addressFocusNode,
                          controller.mondayFocusNode);
                    },
                    validator: (value) {
                      return controller.validateEmpty(value);
                    },
                  ),
                  SizedBox(height: 22),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Operational Hours', style: boldBlack16),
                  SizedBox(
                    height: 22,
                  ),
                  //monday
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 56,
                          child: Image.asset('assets/icons/monday.png')),
                      SizedBox(width: 15),
                      Obx(
                        () => Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: CustomForm(
                              title: 'Open',
                              titleStyle: mediumBlack12,
                              controller: controller.mondayController,
                              focusNode: controller.mondayFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '08:00',
                              enable: !controller.closedMonday.value,
                              onFieldSubmitted: (value) {
                                Notif.fieldFocusChange(
                                    context,
                                    controller.mondayFocusNode,
                                    controller.mondayEndFocusNode);
                              },
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: CustomForm(
                              title: 'Close',
                              titleStyle: mediumBlack12,
                              controller: controller.mondayEndController,
                              focusNode: controller.mondayEndFocusNode,
                              keyboardType: TextInputType.datetime,
                              enable: !controller.closedMonday.value,
                              hintText: '20:00',
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Switch(
                            activeColor: primaryColor,
                            value: controller.closedMonday.value,
                            onChanged: (bool value) {
                              if (value == true) {
                                controller.mondayController.text = 'closed';
                                controller.mondayEndController.text = 'closed';
                              } else {
                                controller.mondayController.text = '';
                                controller.mondayEndController.text = '';
                              }
                              controller.closedMonday.value = value;
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  //tuesday
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 56,
                          child: Column(children: [
                            Image.asset('assets/icons/tuesday.png')
                          ])),
                      SizedBox(width: 15),
                      Obx(
                        () => Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: CustomForm(
                              title: 'Open',
                              titleStyle: mediumBlack12,
                              controller: controller.tuesdayController,
                              focusNode: controller.tuesdayFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '08:00',
                              enable: !controller.closedTuesday.value,
                              onFieldSubmitted: (value) {
                                Notif.fieldFocusChange(
                                    context,
                                    controller.tuesdayFocusNode,
                                    controller.tuesdayEndFocusNode);
                              },
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: CustomForm(
                              title: 'Close',
                              titleStyle: mediumBlack12,
                              controller: controller.tuesdayEndController,
                              focusNode: controller.tuesdayEndFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '20:00',
                              enable: !controller.closedTuesday.value,
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Switch(
                            activeColor: primaryColor,
                            value: controller.closedTuesday.value,
                            onChanged: (bool value) {
                              if (value == true) {
                                controller.tuesdayController.text = 'closed';
                                controller.tuesdayEndController.text = 'closed';
                              } else {
                                controller.tuesdayController.text = '';
                                controller.tuesdayEndController.text = '';
                              }
                              controller.closedTuesday.value = value;
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  //Wednesday
                  Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 56,
                            child: Image.asset(
                              'assets/icons/wednesday.png',
                              alignment: Alignment.center,
                            )),
                        SizedBox(width: 15),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: CustomForm(
                              title: 'Open',
                              titleStyle: mediumBlack12,
                              controller: controller.wednesdayController,
                              focusNode: controller.wednesdayFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '08:00',
                              enable: !controller.closedWednesday.value,
                              onFieldSubmitted: (value) {
                                Notif.fieldFocusChange(
                                    context,
                                    controller.wednesdayFocusNode,
                                    controller.wednesdayEndFocusNode);
                              },
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: CustomForm(
                              title: 'Close',
                              titleStyle: mediumBlack12,
                              controller: controller.wednesdayEndController,
                              focusNode: controller.wednesdayEndFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '20:00',
                              enable: !controller.closedWednesday.value,
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                        Switch(
                            activeColor: primaryColor,
                            value: controller.closedWednesday.value,
                            onChanged: (bool value) {
                              if (value == true) {
                                controller.wednesdayController.text = 'closed';
                                controller.wednesdayEndController.text =
                                    'closed';
                              } else {
                                controller.wednesdayController.text = '';
                                controller.wednesdayEndController.text = '';
                              }
                              controller.closedWednesday.value = value;
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 22),
                  //Thursday
                  Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 56,
                            child: Column(children: [
                              Image.asset('assets/icons/thursday.png')
                            ])),
                        SizedBox(width: 15),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: CustomForm(
                              title: 'Open',
                              titleStyle: mediumBlack12,
                              controller: controller.thursdayController,
                              focusNode: controller.thursdayFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '08:00',
                              enable: !controller.closedThursday.value,
                              onFieldSubmitted: (value) {
                                Notif.fieldFocusChange(
                                    context,
                                    controller.thursdayFocusNode,
                                    controller.thursdayEndFocusNode);
                              },
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: CustomForm(
                              title: 'Close',
                              titleStyle: mediumBlack12,
                              controller: controller.thursdayEndController,
                              focusNode: controller.thursdayEndFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '20:00',
                              enable: !controller.closedThursday.value,
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                        Switch(
                            activeColor: primaryColor,
                            value: controller.closedThursday.value,
                            onChanged: (bool value) {
                              if (value == true) {
                                controller.thursdayController.text = 'closed';
                                controller.thursdayEndController.text =
                                    'closed';
                              } else {
                                controller.thursdayController.text = '';
                                controller.thursdayEndController.text = '';
                              }
                              controller.closedThursday.value = value;
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 22),
                  //Friday
                  Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 56,
                            child: Column(children: [
                              Image.asset('assets/icons/friday.png')
                            ])),
                        SizedBox(width: 15),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: CustomForm(
                              title: 'Open',
                              titleStyle: mediumBlack12,
                              controller: controller.fridayController,
                              focusNode: controller.fridayFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '08:00',
                              enable: !controller.closedFriday.value,
                              onFieldSubmitted: (value) {
                                Notif.fieldFocusChange(
                                    context,
                                    controller.fridayFocusNode,
                                    controller.fridayEndFocusNode);
                              },
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: CustomForm(
                              title: 'Close',
                              titleStyle: mediumBlack12,
                              controller: controller.fridayEndController,
                              focusNode: controller.fridayEndFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '20:00',
                              enable: !controller.closedFriday.value,
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                        Switch(
                            activeColor: primaryColor,
                            value: controller.closedFriday.value,
                            onChanged: (bool value) {
                              if (value == true) {
                                controller.fridayController.text = 'closed';
                                controller.fridayEndController.text = 'closed';
                              } else {
                                controller.fridayController.text = '';
                                controller.fridayEndController.text = '';
                              }
                              controller.closedFriday.value = value;
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 22),
                  //Saturday
                  Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 56,
                            child: Column(children: [
                              Image.asset('assets/icons/saturday.png')
                            ])),
                        SizedBox(width: 15),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: CustomForm(
                              title: 'Open',
                              titleStyle: mediumBlack12,
                              controller: controller.saturdayController,
                              focusNode: controller.saturdayFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '08:00',
                              enable: !controller.closedSaturday.value,
                              onFieldSubmitted: (value) {
                                Notif.fieldFocusChange(
                                    context,
                                    controller.saturdayFocusNode,
                                    controller.saturdayEndFocusNode);
                              },
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: CustomForm(
                              title: 'Close',
                              titleStyle: mediumBlack12,
                              controller: controller.saturdayEndController,
                              focusNode: controller.saturdayEndFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '20:00',
                              enable: !controller.closedSaturday.value,
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                        Switch(
                            activeColor: primaryColor,
                            value: controller.closedSaturday.value,
                            onChanged: (bool value) {
                              if (value == true) {
                                controller.saturdayController.text = 'closed';
                                controller.saturdayEndController.text =
                                    'closed';
                              } else {
                                controller.saturdayController.text = '';
                                controller.saturdayEndController.text = '';
                              }
                              controller.closedSaturday.value = value;
                            }),
                      ],
                    ),
                  ),
                  SizedBox(height: 22),
                  //sunday
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: 56,
                          child: Image.asset('assets/icons/sunday.png')),
                      SizedBox(width: 15),
                      Obx(
                        () => Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: CustomForm(
                              title: 'Open',
                              titleStyle: mediumBlack12,
                              controller: controller.sundayController,
                              focusNode: controller.sundayFocusNode,
                              hintText: '08:00',
                              keyboardType: TextInputType.datetime,
                              onFieldSubmitted: (value) {
                                Notif.fieldFocusChange(
                                    context,
                                    controller.sundayFocusNode,
                                    controller.sundayEndFocusNode);
                              },
                              enable: !controller.closedSunday.value,
                              validator: (value) {
                                print(value);
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                      ),
                      // Padding(padding:EdgeInsets.only(bottom: 15,left: 10,right: 10),child: Text('-', style: mediumBlack14,)),
                      Obx(
                        () => Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: CustomForm(
                              title: 'Close',
                              titleStyle: mediumBlack12,
                              controller: controller.sundayEndController,
                              focusNode: controller.sundayEndFocusNode,
                              keyboardType: TextInputType.datetime,
                              hintText: '20:00',
                              enable: !controller.closedSunday.value,
                              validator: (value) {
                                return controller.validateHours(value);
                              },
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Switch(
                            activeColor: primaryColor,
                            value: controller.closedSunday.value,
                            onChanged: (bool value) {
                              if (value == true) {
                                controller.sundayController.text = 'closed';
                                controller.sundayEndController.text = 'closed';
                              } else {
                                controller.sundayController.text = '';
                                controller.sundayEndController.text = '';
                              }
                              controller.closedSunday.value = value;
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Flexible(
                  child: Container(
                      padding: EdgeInsets.only(left: 35, bottom: 10),
                      child: Obx(
                            () => CustomFilledButton(
                          title: Text('DELETE', style: boldWhite16),
                          color: controller.loading.value ? grey : redColor,
                          onPressed: controller.loading.value
                              ? null
                              : () async {
                            if (formKey.currentState!.validate()) {
                              print('already validated');
                              await controller.deletePlace();
                              await Get.offAndToNamed('/home-merchant');
                              Get.delete<EditPlaceViewModel>();
                            }
                          },
                        ),
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                      padding: EdgeInsets.only(right: 35, bottom: 10),
                      child: Obx(
                            () => CustomFilledButton(
                          title: Text('SAVE', style: boldWhite16),
                          color: controller.loading.value ? grey : primaryColor,
                          onPressed: controller.loading.value
                              ? null
                              : () async {
                            if (formKey.currentState!.validate()) {
                              print('already validated');
                              await controller.updatePlace();
                              controller.detailPlace.refresh();
                            }
                          },
                        ),
                      )),
                ),
              ],
            ),
          ]),
        ));
  }
}
