// import 'package:flutter/material.dart';

// import '../../../core/constant/dimesions.dart';

// class LoadingUi extends StatefulWidget {
//   const LoadingUi({super.key});

//   @override
//   State<LoadingUi> createState() => _LoadingUiState();
// }

// class _LoadingUiState extends State<LoadingUi> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/images/bg_img.png"),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SingleChildScrollView(
//             // height: 400,
//             // color: MasterColors.baseColor,
//             child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 ScaleTransition(
//                   scale: controller,
//                   child: Container(
//                     padding: EdgeInsets.only(left: Dimesion.height35),
//                     alignment: Alignment.centerLeft,
//                     height: MediaQuery.of(context).size.height * 0.55,
//                     child: Container(
//                         margin: EdgeInsets.only(top: Dimesion.height10),
//                         height: Dimesion.height40 * 6,
//                         width: Dimesion.width30 * 8,
//                         child: Image.asset("assets/images/logo.png")),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }
