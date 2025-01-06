// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// import '../../config/master_colors.dart';
// import '../../core/constant/dimesions.dart';
// import '../../core/utils/utils.dart';

// class ShimmerItem extends StatelessWidget {
//   const ShimmerItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Shimmer.fromColors(
//         baseColor: Colors.black12,
//         highlightColor:
//             Utils.isLightMode(context) ? Colors.white12 : Colors.black54,
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             color: MasterColors.black,
//             borderRadius: BorderRadius.all(Radius.circular(Dimesion.height2)),
//           ),
//         ));
//   }
// }
