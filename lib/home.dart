//TIDAK DIPAKAI
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreen();
// }
//
// class _HomeScreen extends State<HomeScreen> {
//   int currentTab = 0;
//   final List<Widget> screens = [Beranda(), Riwayat(), Notifikasi(), Profil()];
//
//   final PageStorageBucket bucket = PageStorageBucket();
//   Widget currentScreen = Beranda();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageStorage(
//         child: currentScreen,
//         bucket: bucket,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: Color(0xFF3880A4),
//         child: Icon(Icons.add, size: 35.0),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 5.0,
//         child: Container(
//           padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0),
//           height: 50,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: 10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MaterialButton(
//                       minWidth: 80,
//                       onPressed: () {
//                         setState(() {
//                           currentScreen = Beranda();
//                           currentTab = 0;
//                         });
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.home,
//                             color: currentTab == 0
//                                 ? Color(0xFF3880A4)
//                                 : Colors.grey,
//                             size: 30,
//                           ),
//                           Text(
//                             'Home',
//                             style: TextStyle(
//                               color: currentTab == 0
//                                   ? Color(0xFF3880A4)
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     MaterialButton(
//                       minWidth: 80,
//                       onPressed: () {
//                         setState(() {
//                           currentScreen = Riwayat();
//                           currentTab = 1;
//                         });
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.search,
//                             color: currentTab == 1
//                                 ? Color(0xFF3880A4)
//                                 : Colors.grey,
//                             size: 30,
//                           ),
//                           Text(
//                             'Riwayat',
//                             style: TextStyle(
//                               color: currentTab == 1
//                                   ? Color(0xFF3880A4)
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(right: 10.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MaterialButton(
//                       minWidth: 80,
//                       onPressed: () {
//                         setState(() {
//                           currentScreen = Notifikasi();
//                           currentTab = 2;
//                         });
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.notifications,
//                             color: currentTab == 2
//                                 ? Color(0xFF3880A4)
//                                 : Colors.grey,
//                             size: 30,
//                           ),
//                           Text(
//                             'Notifikasi',
//                             style: TextStyle(
//                               color: currentTab == 2
//                                   ? Color(0xFF3880A4)
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     MaterialButton(
//                       minWidth: 80,
//                       onPressed: () {
//                         setState(() {
//                           currentScreen = Profil();
//                           currentTab = 3;
//                         });
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.person,
//                             color: currentTab == 3
//                                 ? Color(0xFF3880A4)
//                                 : Colors.grey,
//                             size: 30,
//                           ),
//                           Text(
//                             'Profil',
//                             style: TextStyle(
//                               color: currentTab == 3
//                                   ? Color(0xFF3880A4)
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
