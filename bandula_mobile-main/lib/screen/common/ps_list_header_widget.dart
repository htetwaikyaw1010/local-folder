// import 'package:flutter/material.dart';
// import 'package:shusarmal/config/master_colors.dart';
// import 'package:shusarmal/core/constant/master_dimens.dart';
// import 'package:shusarmal/core/provider/language/app_localization_provider.dart';
// import 'package:shusarmal/core/utils/utils.dart';

// class ListHeaderWidget extends StatelessWidget {
//   const ListHeaderWidget(
//       {Key? key,
//       required this.headerName,
//       this.headerDescription = '',
//       this.viewAllClicked,
//       this.showViewAll = true,
//       this.useSliver = false})
//       : super(key: key);

//   final String headerName;
//   final String? headerDescription;
//   final Function? viewAllClicked;
//   final bool showViewAll;
//   final bool useSliver;

//   @override
//   Widget build(BuildContext context) {
//     if (useSliver)
//       return SliverToBoxAdapter(
//           child: _ListHeaderWidget(
//               headerName: headerName,
//               headerDescription: headerDescription,
//               viewAllClicked: viewAllClicked ?? () {},
//               showViewAll: showViewAll));
//     else
//       return _ListHeaderWidget(
//           headerName: headerName,
//           headerDescription: headerDescription,
//           viewAllClicked: viewAllClicked ?? () {},
//           showViewAll: showViewAll);
//   }
// }

// class _ListHeaderWidget extends StatelessWidget {
//   const _ListHeaderWidget({
//     Key? key,
//     required this.headerName,
//     this.headerDescription = '',
//     required this.viewAllClicked,
//     this.showViewAll = true,
//   }) : super(key: key);

//   final String headerName;
//   final String? headerDescription;
//   final Function viewAllClicked;
//   final bool showViewAll;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: viewAllClicked as void Function()?,
//       child: Container(
//         margin: const EdgeInsets.all(Dimesion.height16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                 Expanded(
//                   child: Text(headerName,
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           fontSize: 18,
//                           color: Utils.isLightMode(context)
//                               ? MasterColors.secondary800
//                               : MasterColors.textColor2,
//                           fontWeight: FontWeight.w600)),
//                 ),
//                 Visibility(
//                   visible: showViewAll,
//                   child: Text(
//                     // 'dashboard__view_all'.tr,
//                     'view all'.tr,
//                     textAlign: TextAlign.start,
//                     style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                         color: MasterColors.mainColor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ],
//             ),
//             if (headerDescription != '')
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top:Dimesion.height10),
//                       child: Text(
//                         headerDescription!,
//                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                             color: Utils.isLightMode(context)
//                                 ? MasterColors.secondary300
//                                 : MasterColors.primaryDarkGrey),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
