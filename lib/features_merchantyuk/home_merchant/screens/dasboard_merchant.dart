import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meetingyuk/features/explore/screens/explore.dart';
import 'package:meetingyuk/features/profile/screens/profile.dart';
import 'package:get/get.dart';
import 'package:meetingyuk/features_merchantyuk/home_merchant/screens/booking_merchant.dart';
import 'package:meetingyuk/features_merchantyuk/home_merchant/view_model/dashboard_merchantVM.dart';
import 'package:meetingyuk/features_merchantyuk/place_merchant/screens/place_merchant.dart';

class DashboardMerchant extends StatelessWidget {

  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashMerchantViewModel>(
      builder: (controller){
        return Scaffold(
            body:
            Container(
              color: Colors.white,
              child: SafeArea(
                child: IndexedStack(
                  index: controller.currentTab,
                  children: [
                    BookingMerchant(),
                    Explore(),
                    PlaceMerchant(),
                    Profile()
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.clock_fill,size: 24), label: "Booking"),
                BottomNavigationBarItem(icon: Icon(Icons.chat,size: 24,), label: 'Chat'),
                BottomNavigationBarItem(icon: Icon(Icons.meeting_room,size: 24,), label: 'Place'),
                // BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/chat_black.png'),size: 24), label: 'Chat'),
                // BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/icons/History.png'),size: 24), label: 'History'),
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
