import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/profile/view_model/profile_viewmodel.dart';
import 'package:meetingyuk/features/profile/widgets/button.dart';
import 'package:meetingyuk/features/profile/widgets/custom_form.dart';
import 'package:meetingyuk/ulits/color.dart';
import 'package:meetingyuk/ulits/notif.dart';
import 'package:meetingyuk/ulits/style.dart';

class EditProfile extends GetView<ProfileViewModel> {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: extraBoldBlack24,
          ),
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
        body: ListView(scrollDirection: Axis.vertical, children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(() => CircleAvatar(
                  radius: 66,
                  backgroundImage: controller.imageUrl.value =='default'
                      ? AssetImage('assets/icons/photo_profile.png') as ImageProvider<Object>
                      : NetworkImage(controller.imageUrl.value) as ImageProvider<Object>,
                )),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        controller.openImagePicker();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.only(top: 10, bottom: 30),
          //   width: 132,
          //   height: 132,
          //   decoration: BoxDecoration(
          //     color: Colors.black,
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       image: AssetImage(
          //         'assets/img_profile.png',
          //       ),
          //     ),
          //   ),
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 30, left: 24, right: 24),
            padding: EdgeInsets.only(top: 22, left: 22, right: 22, bottom: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomForm(
                    title: 'Name',
                    controller: controller.nameController,
                    focusNode: controller.namaFocusNode,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (value) {
                      Notif.fieldFocusChange(context, controller.namaFocusNode,
                          controller.emailFocusNode);
                    },
                    validator: (value) {
                      return controller.validateName(value);
                    },
                  ),
                  SizedBox(height: 22),
                  CustomForm(
                    title: 'Email Address',
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      Notif.fieldFocusChange(context, controller.emailFocusNode,
                          controller.telpFocusNode);
                    },
                    validator: (value) {
                      return controller.validateEmail(value);
                    },
                  ),
                  SizedBox(height: 22),
                  CustomForm(
                    title: 'Phone Number',
                    controller: controller.telpController,
                    focusNode: controller.telpFocusNode,
                    keyboardType: TextInputType.phone,
                    onFieldSubmitted: (value) {
                      Notif.fieldFocusChange(context, controller.telpFocusNode,
                          controller.passwordFocusNode);
                    },
                    validator: (value) {
                      return controller.validatePhone(value);
                    },
                  ),
                  SizedBox(height: 22),
                  SizedBox(height: 22),
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 16, left: 24, right: 24),
              padding: EdgeInsets.only(left: 22, right: 22, bottom: 20),
              width: double.infinity,
              child: Obx(
                () => CustomFilledButton(
                  title: Text('SAVE CHANGES', style: boldWhite16),
                  onPressed: controller.loading.value
                      ? null
                      : () async {
                          if (formKey.currentState!.validate()) {
                            await controller.putProfile();
                          }
                        },
                ),
              ))
        ]));
  }
}
