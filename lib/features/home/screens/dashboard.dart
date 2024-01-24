import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MeetingYuk/features/home/screens/home.dart';
import 'package:MeetingYuk/features/history/screens/history.dart';
import 'package:MeetingYuk/features/explore/screens/explore.dart';
import 'package:MeetingYuk/features/profile/screens/profile.dart';
import 'package:MeetingYuk/features/home/view_model/dasboard_viewmodel.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {

  final pageController = PageController();
  @override

  Widget build(BuildContext context) {
    return GetBuilder<DashViewModel>(
      builder: (controller){
        return Scaffold(
            body:
            Container(
              color: Colors.white,
              child: SafeArea(
                child: IndexedStack(
                  index: controller.currentTab,
                  children: [
                    Home(),
                    Explore(),
                    History(),
                    Profile()
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home,size: 24), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.explore,size: 24,), label: 'Explore'),
                BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/History.png'),size: 24), label: 'History'),
                BottomNavigationBarItem(icon: Icon(Icons.person,size: 24), label: 'Profile'),
              ],
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              currentIndex: controller.currentTab,
              onTap: controller.changeScreen2,
              iconSize: 30,
              unselectedFontSize: 14,
            ));
      },
    );
  }
}
