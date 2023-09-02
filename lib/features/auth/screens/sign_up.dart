import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/auth/view_model/auth_viewmodel.dart';
import 'package:meetingyuk/ulits/notif.dart';

class SignUp extends GetView<AuthViewModel> {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40.0),
                Image.asset(
                  "assets/images/logocolor_name.png",
                  scale: 1.5,
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(height: 20.0),
                Container(
                  alignment: AlignmentDirectional.center,
                  child: const Text(
                    'Daftar Akun',
                    style: TextStyle(
                      color: Color(0xFF3880A4),
                      fontSize: 35.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                //Container Nama
                TextFormField(
                  validator: (value) {
                    return controller.validateName(value);
                  },
                  keyboardType: TextInputType.name,
                  controller: controller.namaController,
                  onFieldSubmitted: (value) {
                    Notif.fieldFocusChange(context, controller.namaFocusNode,
                        controller.telpFocusNode);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Dadang',
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                const SizedBox(height: 20),
                //Container NoTelp
                TextFormField(
                  validator: (value) {
                    return controller.validatePhone(value);
                  },
                  keyboardType: TextInputType.number,
                  controller: controller.telpController,
                  focusNode: controller.telpFocusNode,
                  onFieldSubmitted: (value) {
                    Notif.fieldFocusChange(context, controller.telpFocusNode,
                        controller.emailFocusNode);
                  },
                  decoration: const InputDecoration(
                    hintText: '08122233344',
                    labelText: 'Nomor Telepon',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                const SizedBox(height: 20),
                //Container Email
                TextFormField(
                  validator: (value) {
                    return controller.validateEmail(value);
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailController,
                  focusNode: controller.emailFocusNode,
                  onFieldSubmitted: (value) {
                    Notif.fieldFocusChange(context, controller.emailFocusNode,
                        controller.passwordFocusNode);
                  },
                  decoration: const InputDecoration(
                    hintText: 'email@gmail.com',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                const SizedBox(height: 20),
                //Container Passwords
                Obx(
                  () => TextFormField(
                    validator: (value) {
                      return controller.validatePassword(value);
                    },
                    obscureText: controller.passwordObscure.value,
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      hintText: "Password",
                      labelText: "Password",
                      helperStyle: const TextStyle(color: Colors.green),
                      suffixIcon: IconButton(
                        icon: Icon(controller.passwordObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          controller.togglePasswordVisibility();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Button
                SizedBox(
                    height: 48.0,
                    width: double.infinity,
                    child: Obx(
                      () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3880A4)),
                        onPressed: controller.loading.value
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  await controller.register();
                                }
                              },
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),

                Container(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                          onPressed: () {
                            Get.offAllNamed('/login');
                          },
                          child: const Text(
                            'Login ',
                            style: TextStyle(color: Color(0xFF3880A4)),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
