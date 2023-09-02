import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features/auth/view_model/auth_viewmodel.dart';

class Login extends GetView<AuthViewModel> {
  const Login({Key? key}) : super(key: key);

//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   bool _passwordObscure = true;
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   String? _email, _passwords;
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
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3880A4),
                  ),
                ),
                const SizedBox(height: 25.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    hintText: 'email@gmail.com',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                const SizedBox(height: 20.0),
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
                Container(
                  height: 40,
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(color: Color(0xFF3880A4)),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
                  height: 48.0,
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3880A4)),
                      onPressed: controller.loading.value
                          ? null
                          : () async {
                              await controller.login();
                            },
                      child: Text(
                        'LOGIN',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have account?'),
                      TextButton(
                          onPressed: () {
                            Get.offAllNamed('/register');
                          },
                          child: const Text(
                            'Register Now!',
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
