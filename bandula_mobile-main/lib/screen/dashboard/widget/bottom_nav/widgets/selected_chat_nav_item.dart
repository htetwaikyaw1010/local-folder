// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:psxmpc/config/ps_colors.dart';
// import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

// import '../../../../../../core/vendor/constant/ps_constants.dart';
// import '../../../../../../core/vendor/constant/ps_dimens.dart';
// import '../../../../../../core/vendor/provider/chat/user_unread_message_provider.dart';
// import '../../../../../../core/vendor/utils/utils.dart';
// import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
// import '../../../../common/dialog/chat_noti_dialog.dart';

// class SelectedChatIconWithUnreadCount extends StatefulWidget {
//   const SelectedChatIconWithUnreadCount(
//       {required this.updateSelectedIndexWithAnimation});
//   final Function updateSelectedIndexWithAnimation;
//   @override
//   State<StatefulWidget> createState() =>
//       ChatIconWithUnreadCountState<SelectedChatIconWithUnreadCount>();
// }

// class ChatIconWithUnreadCountState<T extends SelectedChatIconWithUnreadCount>
//     extends State<SelectedChatIconWithUnreadCount> {
//   int sellerCount = 0;
//   int buyerCount = 0;
//   late UserUnreadMessageProvider provider;

//   @override
//   Widget build(BuildContext context) {
//     final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);
//     return Column(
//       children: <Widget>[
//         Stack(
//           children: <Widget>[
//             Container(
//               width: PsDimesion.height40,
//               height: PsDimesion.height36,
//               margin: const EdgeInsets.only(
//                 left: PsDimesion.height8,
//                 right: PsDimesion.height8,
//               ),
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Icon(
//                   Icons.chat,
//                   size: 24,
//                   color: PsColors.mainColor,
//                 ),
//               ),
//             ),
//             Positioned(
//                 top: 3,
//                 right: 8,
//                 child: Consumer<UserUnreadMessageProvider>(builder:
//                     (BuildContext context,
//                         UserUnreadMessageProvider userUnreadMessageProvider,
//                         Widget? child) {
//                   if (userUnreadMessageProvider.userUnreadMessage.data !=
//                       null) {
//                     provider = userUnreadMessageProvider;
//                     sellerCount = int.parse(userUnreadMessageProvider
//                         .userUnreadMessage.data!.sellerUnreadCount!);
//                     buyerCount = int.parse(userUnreadMessageProvider
//                         .userUnreadMessage.data!.buyerUnreadCount!);
//                     userUnreadMessageProvider.totalUnreadCount =
//                         sellerCount + buyerCount;
//                     if (Utils.isLoginUserEmpty(psValueHolder) ||
//                         userUnreadMessageProvider.totalUnreadCount == 0) {
//                       return const SizedBox();
//                     } else {
//                       if (userUnreadMessageProvider.totalUnreadCount > 0) {
//                         Future<dynamic>.delayed(
//                             Duration.zero, () => showMessageDialog(context));
//                       }
//                       return Container(
//                         width: PsDimesion.height20,
//                         height: PsDimesion.height20,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: PsColors.buttonColor, //PsColors.primary500,
//                         ),
//                         child: Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             userUnreadMessageProvider.totalUnreadCount > 9
//                                 ? '9+'
//                                 : userUnreadMessageProvider.totalUnreadCount
//                                     .toString(),
//                             textAlign: TextAlign.left,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(color: PsColors.baseColor),
//                             maxLines: 1,
//                           ),
//                         ),
//                       );
//                     }
//                   } else {
//                     return const SizedBox();
//                   }
//                 })),
//           ],
//         ),
//         Container(
//           width: 5,
//           height: 5,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: PsColors.mainColor,
//           ),
//         ),
//         const SizedBox(
//           height: PsDimesion.height6,
//         ),
//       ],
//     );
//   }

//   Future<dynamic> showMessageDialog(BuildContext context) async {
//     if (!Utils.isShowNotiFromToolbar() && !provider.isShowMessageDialog) {
//       showDialog<dynamic>(
//           context: context,
//           builder: (_) {
//             return ChatNotiDialog(
//                 description: 'noti_message__new_message'.tr,
//                 leftButtonText: 'chat_noti__cancel'.tr,
//                 rightButtonText: 'chat_noti__open'.tr,
//                 onAgreeTap: () {
//                   widget.updateSelectedIndexWithAnimation(
//                       'dashboard__bottom_navigation_message'.tr,
//                       PsConst.REQUEST_CODE__DASHBOARD_MESSAGE_FRAGMENT);
//                 });
//           });
//       provider.isShowMessageDialog = true;
//     }
//   }
// }
