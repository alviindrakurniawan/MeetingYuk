import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/profile/view_model/profile_viewmodel.dart';
import 'package:meetingyuk/features/profile/widgets/button.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends GetView<ProfileViewModel> {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void toMerchant() {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Change your account to Merchant ?',
              textAlign: TextAlign.center, style: mediumBlack16),
          titlePadding: EdgeInsets.only(top: 30, left: 11, right: 11),
          contentPadding: EdgeInsets.only(top: 50, bottom: 20),
          content: Wrap(
            alignment: WrapAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.center,
                  child: const Text(
                    'You cannot undo this change',
                    style: regularBlack12,
                    textAlign: TextAlign.center,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomFilledButton(
                      title: Text('NO', style: boldWhite16),
                      width: 118,
                      height: 40,
                      onPressed: () {
                        Get.back();
                      },
                      color: redColor),
                  SizedBox(width: 30),
                  Obx(
                    () => controller.loading.value
                        ? CustomFilledButton(
                            title: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            width: 118,
                            height: 40,
                            color: primaryColor)
                        : CustomFilledButton(
                            title: Text('YES', style: boldWhite16),
                            width: 118,
                            height: 40,
                            onPressed: () {
                              controller.updrageMerchant();
                            },
                            color: primaryColor),
                  )
                ],
              ),
            ],
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    }

    void logout() {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text(
            'Log Out ?',
            textAlign: TextAlign.center,
            style: mediumBlack16,
          ),
          titlePadding: EdgeInsets.only(top: 30, left: 30, right: 30),
          contentPadding: EdgeInsets.only(top: 50, bottom: 20),
          content: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomFilledButton(
                        title: Text('NO', style: boldWhite16),
                        width: 118,
                        height: 40,
                        onPressed: () {
                          Get.back();
                        },
                        color: redColor),
                    Obx(
                      () => controller.loading.value
                          ? CustomFilledButton(
                              title: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              width: 118,
                              height: 40,
                              color: primaryColor)
                          : CustomFilledButton(
                              title: Text('YES', style: boldWhite16),
                              width: 118,
                              height: 40,
                              onPressed: () {
                                controller.logout();
                              },
                              color: primaryColor),
                    )
                  ],
                ),
              ],
            ),
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    }

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: backgroundColor,
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 35),
                Obx(
                  () => Text(
                    // Var Is merchant
                    controller.account.value,
                    style: extraBoldBlack24,
                  ),
                ),
                SizedBox(height: 25),
                Obx(() => controller.imageUrl.value == 'default'
                    ? CircleAvatar(
                        radius: 66,
                        // _imageFile != null
                        //     ? FileImage(File(_imageFile!.path))
                        backgroundImage: AssetImage(
                            'assets/icons/photo_profile.png'), // add your default profile image in assets
                      )
                    : CircleAvatar(
                        radius: 66,
                        backgroundImage: NetworkImage(
                            '${controller.imageUrl.value}'), // add your default profile image in assets
                      )),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding:
                      EdgeInsets.only(top: 30, left: 35, right: 35, bottom: 35),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        width: double.infinity,
                        child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/editprofile');
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/person_profile.png',
                                  width: 24,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Edit Profile',
                                  style: mediumBlack14,
                                )
                              ],
                            )),
                      ),
                      Obx(()=> controller.account.value == 'MeetingYuk Account'
                            ? Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: GestureDetector(
                                    onTap: () {
                                      toMerchant();
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/store_iconscout.png',
                                          width: 24,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          'Upgrade to Merchant',
                                          style: mediumBlack14,
                                        )
                                      ],
                                    )),
                              )
                            : Container(),
                      ),
                      // Container(
                      //   margin: EdgeInsets.symmetric(vertical: 15),
                      //   child: GestureDetector(
                      //       onTap: () {
                      //
                      //       },
                      //       child: Row(
                      //         children: [
                      //           Image.asset(
                      //             'assets/icons/password.png',
                      //             width: 24,
                      //           ),
                      //           SizedBox(width: 20),
                      //           Text(
                      //             'Reset Password',
                      //             style: mediumBlack14,
                      //           )
                      //         ],
                      //       )),
                      // ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: GestureDetector(
                            onTap: () {
                              logout();
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/logout_awesome.png',
                                  width: 24,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Log Out',
                                  style: mediumBlack14,
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
