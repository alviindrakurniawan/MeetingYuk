import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/profile/widgets/button.dart';
import 'package:meetingyuk/features/profile/widgets/custom_form.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/view_model/edit_place_viewmodel.dart';
import 'package:meetingyuk/features/home/widget/facilities.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/widget/facility_checkbox.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:meetingyuk/ulits/style.dart';

class AddPlace2 extends GetView<EditPlaceViewModel> {
  const AddPlace2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Widget buildFacilitiesWithCheckbox() {
      return Column(
        children: facilityIcons.keys.map((facility) {
          return Obx(
            () => FacilityCheckbox(
                facility: facility,
                value: controller.facilitiesChecklist[facility] ?? false,
                onpress: (checked) {
                  controller.toggleFacility(facility);
                }),
          );
        }).toList(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          // title: Text(
          //   '',
          //   style: extraBoldBlack24,
          // ),
          backgroundColor: backgroundColor,
          elevation: 0,
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
                )),
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(scrollDirection: Axis.vertical, children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Create your first room',
                style: boldBlack18,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 24, right: 24),
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
                    title: 'Room Name',
                    controller: controller.roomNameController,
                    focusNode: controller.roomNameFocusNode,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      Notif.fieldFocusChange(
                          context,
                          controller.roomNameFocusNode,
                          controller.roomPriceFocusNode);
                    },
                    validator: (value) {
                      return controller.validateEmpty(value);
                    },
                  ),
                  SizedBox(height: 22),
                  CustomForm(
                    title: 'Price Room',
                    controller: controller.roomPriceController,
                    focusNode: controller.roomPriceFocusNode,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      Notif.fieldFocusChange(
                          context,
                          controller.roomPriceFocusNode,
                          controller.maxCapacityFocusNode);
                    },
                    validator: (value) {
                      return controller.validatePositiveNumbers(value);
                    },
                  ),
                  SizedBox(height: 22),
                  CustomForm(
                    title: 'Max Capacity (Person)',
                    controller: controller.maxCapacityController,
                    focusNode: controller.maxCapacityFocusNode,
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      Notif.fieldFocusChange(
                          context,
                          controller.maxCapacityFocusNode,
                          controller.maxDurationFocusNode);
                    },
                    validator: (value) {
                      return controller.validatePositiveNumbers(value);
                    },
                  ),
                  SizedBox(height: 22),
                  CustomForm(
                    title: 'Max Duration (hours)',
                    controller: controller.maxDurationController,
                    focusNode: controller.maxDurationFocusNode,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return controller.validatePositiveNumbers(value);
                    },
                  ),
                  SizedBox(height: 22),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Facilities', style: boldBlack16),
                  SizedBox(
                    height: 22,
                  ),
                  buildFacilitiesWithCheckbox()
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'You can add another room at detailpage',
                style: mediumBlack14,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 16, left: 24, right: 24),
                padding: EdgeInsets.only(left: 22, right: 22, bottom: 20),
                width: double.infinity,
                child: Obx(
                  () => CustomFilledButton(
                    title: Text('CREATE NOW', style: boldWhite16),
                    color: controller.loading.value ? grey : primaryColor,
                    onPressed: controller.loading.value
                        ? null
                        : () async {
                            if (formKey.currentState!.validate()) {
                              print('already validated');
                              controller.createPlace();
                              Get.offAndToNamed('/home-merchant');
                              Get.delete<EditPlaceViewModel>();
                            }
                          },
                  ),
                )),
          ]),
        ));
  }
}
