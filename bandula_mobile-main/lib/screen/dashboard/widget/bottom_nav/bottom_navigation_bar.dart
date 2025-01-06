// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shusarmal/config/master_colors.dart';
// import 'package:shusarmal/core/constant/master_constants.dart';
// import 'package:shusarmal/core/provider/language/app_localization_provider.dart';
// import 'package:shusarmal/core/utils/utils.dart';
// import 'package:shusarmal/core/viewobject/common/master_value_holder.dart';
// import 'package:shusarmal/screen/dashboard/widget/bottom_nav/widgets/selected_nav_item_widget.dart';
// import 'package:provider/provider.dart';

// class BottomNaviationWidget extends StatefulWidget {
//   const BottomNaviationWidget(
//       {required this.currentIndex,
//       required this.updateSelectedIndexWithAnimation});
//   final int? currentIndex;
//   final Function updateSelectedIndexWithAnimation;
//   @override
//   BottomNavigationWidgetState<BottomNaviationWidget> createState() =>
//       BottomNavigationWidgetState<BottomNaviationWidget>();
// }

// class BottomNavigationWidgetState<T extends BottomNaviationWidget>
//     extends State<BottomNaviationWidget> {
//   late MasterValueHolder psValueHolder;

//   @override
//   Widget build(BuildContext context) {
//     psValueHolder = Provider.of<MasterValueHolder>(context);
//     if (isCorrectIndex())
//       return Container(
//         //  height:Dimesion.height120,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(32), topLeft: Radius.circular(32)),
//           boxShadow: <BoxShadow>[
//             BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 8),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(32),
//             topLeft: Radius.circular(32),
//           ),
//           child: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: MasterColors.bottomNavigationColor,
//             currentIndex: getBottonNavigationIndex(widget.currentIndex),
//             showUnselectedLabels: false,
//             showSelectedLabels: false,
//             selectedItemColor: MasterColors.bottomNavigationSelectedColor,
//             onTap: (int index) {
//               final dynamic _returnValue =
//                   getIndexFromBottonNavigationIndex(index);
//               widget.updateSelectedIndexWithAnimation(
//                   _returnValue[0], _returnValue[1]);
//             },
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 activeIcon: SelectedNavItemWidget(
//                   icon: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
//                     child: SizedBox(
//                       width: 16,
//                       height: 18,
//                       child: SvgPicture.asset(
//                         'assets/images/home_bottom_selected.svg',
//                         color: MasterColors.mainColor,
//                       ),
//                     ),
//                   ),
//                 ),
//                 icon: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
//                   child: SizedBox(
//                     width: 16,
//                     height: 18,
//                     child: SvgPicture.asset(
//                       'assets/images/home_bottom.svg',
//                       color: Utils.isLightMode(context)
//                           ? MasterColors.secondary500
//                           : Colors.grey[320],
//                     ),
//                   ),
//                 ),
//                 label: ''.tr,
//               ),
//               BottomNavigationBarItem(
//                 activeIcon: SelectedNavItemWidget(
//                     icon: Icon(
//                   Icons.favorite,
//                   size: 24,
//                   color: MasterColors.mainColor,
//                 )),
//                 icon: Icon(
//                   Icons.favorite_border,
//                   size: 24,
//                   color: Utils.isLightMode(context)
//                       ? MasterColors.secondary500
//                       : Colors.grey[360],
//                 ),
//                 label: ''.tr,
//               ),
//               BottomNavigationBarItem(
//                 activeIcon: SelectedNavItemWidget(
//                     icon: Icon(
//                   Icons.account_circle,
//                   size: 24,
//                   color: MasterColors.mainColor,
//                 )),
//                 icon: Icon(
//                   Icons.account_circle_outlined,
//                   size: 24,
//                   color: Utils.isLightMode(context)
//                       ? MasterColors.secondary500
//                       : Colors.grey[360],
//                 ),
//                 label: ''.tr,
//               ),
//             ],
//           ),
//         ),
//       );
//     else
//       return const SizedBox();
//   }

//   int getBottonNavigationIndex(int? param) {
//     int index = 0;
//     switch (param) {
//       case MasterConst.REQUEST_CODE__MENU_HOME_FRAGMENT:
//         index = 0;
//         break;
//       case MasterConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT:
//         index = 1;
//         break;
//       case MasterConst.REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT:
//         if (!Utils.isLoginUserEmpty(psValueHolder)) {
//           index = 2;
//         } else {
//           index = 4;
//         }
//         break;
//       case MasterConst.REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT:
//         if (!Utils.isLoginUserEmpty(psValueHolder)) {
//           index = 2;
//         } else {
//           index = 4;
//         }
//         break;
//       case MasterConst.REQUEST_CODE__DASHBOARD_VERIFY_FORGOT_PASSWORD_FRAGMENT:
//         if (!Utils.isLoginUserEmpty(psValueHolder)) {
//           index = 2;
//         } else {
//           index = 4;
//         }
//         break;
//       case MasterConst.REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT:
//         if (!Utils.isLoginUserEmpty(psValueHolder)) {
//           index = 2;
//         } else {
//           index = 4;
//         }
//         break;
//       case MasterConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT:
//         if (!Utils.isLoginUserEmpty(psValueHolder)) {
//           index = 2;
//         } else {
//           index = 4;
//         }
//         break;
//       case MasterConst.REQUEST_CODE__DASHBOARD_VERIFY_EMAIL_FRAGMENT:
//         index = 2;
//         break;
//       // case MasterConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT:
//       case MasterConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT:
//         index = 2;
//         break;
//       case MasterConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT:
//         index = 2;
//         break;
//       case MasterConst.REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT:
//         index = 2;
//         break;
//       // case MasterConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT:
//       case MasterConst.REQUEST_CODE__MENU_FAVOURITE_FRAGMENT:
//         index = 3;
//         break;
//       //case MasterConst.REQUEST_CODE__DASHBOARD_SEARCH_FRAGMENT:
//       case MasterConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT:
//         index = 4;
//         break;
//       default:
//         index = 0;
//         break;
//     }
//     return index;
//   }

//   dynamic getIndexFromBottonNavigationIndex(int param) {
//     int index = MasterConst.REQUEST_CODE__MENU_HOME_FRAGMENT;
//     String title;
//     final MasterValueHolder psValueHolder =
//         Provider.of<MasterValueHolder>(context, listen: false);
//     switch (param) {
//       case 0:
//         index = MasterConst.REQUEST_CODE__MENU_HOME_FRAGMENT;
//         title = 'app_name'.tr;
//         break;
//       case 1:
//         index = MasterConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT;
//         title = Utils.isLoginUserEmpty(psValueHolder)
//             ? 'home_login'.tr
//             : 'dashboard__bottom_navigation_message'.tr;
//         break;
//       case 2:
//         index = MasterConst.REQUEST_CODE__DASHBOARD_ITEM_UPLOAD_FRAGMENT;
//         title = Utils.isLoginUserEmpty(psValueHolder)
//             ? 'home_login'.tr
//             : 'item_entry__listing_entry'.tr;
//         break;
//       case 3:
//         index = MasterConst.REQUEST_CODE__MENU_FAVOURITE_FRAGMENT;
//         title = Utils.isLoginUserEmpty(psValueHolder)
//             ? 'home_login'.tr
//             : 'home__menu_drawer_favourite'.tr;
//         break;
//       case 4:
//         index = MasterConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT;
//         title = Utils.isLoginUserEmpty(psValueHolder)
//             ? 'home_login'.tr
//             : 'home__bottom_app_bar_login'.tr;
//         break;

//       default:
//         index = 0;
//         title = ''; //Utils.getString(context, 'app_name');
//         break;
//     }
//     return <dynamic>[title, index];
//   }

//   bool isCorrectIndex() {
//     return widget.currentIndex ==
//             MasterConst.REQUEST_CODE__MENU_HOME_FRAGMENT ||
//         widget.currentIndex ==
//             MasterConst.REQUEST_CODE__DASHBOARD_CATEGORY_FRAGMENT ||
//         widget.currentIndex ==
//             MasterConst.REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT ||
//         widget.currentIndex ==
//             MasterConst.REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT ||
//         widget.currentIndex ==
//             MasterConst
//                 .REQUEST_CODE__DASHBOARD_ITEM_UPLOAD_FRAGMENT || //go to profile
//         widget.currentIndex ==
//             MasterConst
//                 .REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT || //go to forgot password
//         widget.currentIndex ==
//             MasterConst
//                 .REQUEST_CODE__DASHBOARD_VERIFY_FORGOT_PASSWORD_FRAGMENT || //go to verify forgot password
//         widget.currentIndex ==
//             MasterConst
//                 .REQUEST_CODE__DASHBOARD_UPDATE_FORGOT_PASSWORD_FRAGMENT || //go to update forgot password
//         widget.currentIndex ==
//             MasterConst
//                 .REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT || //go to register
//         widget.currentIndex ==
//             MasterConst
//                 .REQUEST_CODE__DASHBOARD_VERIFY_EMAIL_FRAGMENT || //go to email verify
//         widget.currentIndex ==
//             MasterConst.REQUEST_CODE__DASHBOARD_SEARCH_FRAGMENT ||
//         widget.currentIndex ==
//             MasterConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT ||
//         widget.currentIndex ==
//             MasterConst.REQUEST_CODE__MENU_FAVOURITE_FRAGMENT ||
//         widget.currentIndex ==
//             MasterConst.REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT ||
//         widget.currentIndex ==
//             MasterConst.REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT ||
//         widget.currentIndex ==
//             MasterConst.REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT;
//   }
// }
