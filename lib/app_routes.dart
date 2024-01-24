
import 'package:get/get.dart';
import 'package:MeetingYuk/bindings/auth_binding.dart';
import 'package:MeetingYuk/bindings/chat_binding.dart';
import 'package:MeetingYuk/bindings/dashboard_binding.dart';
import 'package:MeetingYuk/bindings/dashboard_merchant_binding.dart';
import 'package:MeetingYuk/bindings/detailplace_binding.dart';
import 'package:MeetingYuk/bindings/editplace_merchant_binding.dart';
import 'package:MeetingYuk/bindings/explorelist_binding.dart';
import 'package:MeetingYuk/bindings/history_binding.dart';
import 'package:MeetingYuk/bindings/home_binding.dart';
import 'package:MeetingYuk/bindings/profile_binding.dart';
import 'package:MeetingYuk/bindings/reservation_binding.dart';
import 'package:MeetingYuk/features/auth/screens/login.dart';
import 'package:MeetingYuk/features/auth/screens/sign_up.dart';
import 'package:MeetingYuk/features/chat/screens/broadcast_screen.dart';
import 'package:MeetingYuk/features/chat/screens/chat_screen.dart';
import 'package:MeetingYuk/features/chat/screens/clientchat_screen.dart';
import 'package:MeetingYuk/features/chat/screens/merchantchat_screen.dart';
import 'package:MeetingYuk/features/explore/screens/explore_list.dart';
import 'package:MeetingYuk/features/history/screens/history_detail.dart';
import 'package:MeetingYuk/features/home/screens/dashboard.dart';
import 'package:MeetingYuk/features/home/screens/detail_place.dart';
import 'package:MeetingYuk/features/home/screens/list_page.dart';
import 'package:MeetingYuk/features/home/screens/reservation_page.dart';
import 'package:MeetingYuk/features/home/screens/search_page.dart';
import 'package:MeetingYuk/features/profile/screens/edit_profile.dart';
import 'package:MeetingYuk/features/profile/screens/profile.dart';
import 'package:MeetingYuk/features_merchantyuk/home_merchant/screens/dasboard_merchant.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/screens/addplace1_merchant.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/screens/addplace2_merchant.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/screens/addroom_merchant.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/screens/detail_place_merchant.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/screens/editplace_merchant.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/screens/editroom_merchant.dart';
import 'package:MeetingYuk/features_merchantyuk/place_merchant/screens/picklocation_merchant.dart';
import 'package:MeetingYuk/features/auth/screens/splash_page.dart';


class AppRoutes {

  static appRoutes() => [
    GetPage(
      name: '/',
      page: () => const SplashPage() ,
      binding: AuthBinding(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/login',
      page: () => const Login() ,
      binding: AuthBinding(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/register',
      page: () => const SignUp() ,
      binding: AuthBinding(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/home',
      page: () => Dashboard(),
      transitionDuration: Duration(milliseconds: 250),
      binding: DashBinding(),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/listpage',
      page: () => ListPage() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: HomeBinding(),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/searchpage',
      page: () => SeachPage() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: HomeBinding(),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/detailplace',
      page: () => DetailPlace() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: DetailPlaceBinding(),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/profile',
      page: () => Profile() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: ProfileBinding(),
      transition: Transition.noTransition,
    ) ,
    GetPage(
      name: '/editprofile',
      page: () => EditProfile() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: ProfileBinding(),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/detailhistory',
      page: () => HistoryDetailPage() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: HistoryBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/explorelist',
      page: () => ListExplore() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: ListExploreBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/reservation',
      page: () => ReservationPage(),
      transitionDuration: Duration(milliseconds: 250),
      transition: Transition.leftToRightWithFade,
      binding: ReservationBinding()
    ),

    GetPage(
      name: '/home-merchant',
      page: () => DashboardMerchant() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: DashMerchantBinding(),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/detailplace-merchant',
      page: () => DetailPlaceMerchant() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: EditPlaceMerchantBinding(),
      transition: Transition.leftToRightWithFade ,
    ) ,
    GetPage(
      name: '/editplace-merchant',
      page: () => EditPlace() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: EditPlaceMerchantBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/editroom-merchant',
      page: () => EditRoom() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: EditPlaceMerchantBinding(),
      transition: Transition.leftToRightWithFade ,
    ), GetPage(
      name: '/addroom-merchant',
      page: () => AddRoom(),
      transitionDuration: Duration(milliseconds: 250),
      binding: EditPlaceMerchantBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/addPlace1-merchant',
      page: () => AddPlace1() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: EditPlaceMerchantBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/addPlace2-merchant',
      page: () => AddPlace2() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: EditPlaceMerchantBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/set-location',
      page: () => PickLocation() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: EditPlaceMerchantBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/chat',
      page: () => ClientChatScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: ChatBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/chat-merchant',
      page: () => MerchantChatScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: ChatBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/detail-chat',
      page: () => ChatScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: ChatBinding(),
      transition: Transition.leftToRightWithFade ,
    ),
    GetPage(
      name: '/broadcast',
      page: () => BroadcastScreen() ,
      transitionDuration: Duration(milliseconds: 250),
      binding: ChatBinding(),
      transition: Transition.leftToRightWithFade ,
    ),








  ];

}