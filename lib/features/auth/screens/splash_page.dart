
import 'package:flutter/material.dart';
import 'package:MeetingYuk/common/ulits/color.dart';
import 'package:MeetingYuk/features/auth/repo/splash_repo.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashRepository splashRepo = SplashRepository();
  final storage = GetStorage();
  @override
  void initState() {
    super.initState();
    splashRepo.isLogin();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        backgroundColor: lightBlue,
        body: Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/images/MeetingYuk_Logo_Alt_White.png',
              ),
            )),
          ),
        ),
      ),
    );
  }
}
