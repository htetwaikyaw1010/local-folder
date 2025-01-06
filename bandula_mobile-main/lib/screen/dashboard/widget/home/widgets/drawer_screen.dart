// import 'package:BinaryStore/Screens/Drawer/drawer_controller.dart';

// import 'package:BinaryStore/utils/constants.dart';
// import 'package:BinaryStore/utils/dimesions.dart';
// import 'package:BinaryStore/widgets/expandel_widget.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:toggle_switch/toggle_switch.dart';

// class DrawerScreen extends StatefulWidget {
//   DrawerScreen({Key? key}) : super(key: key);

//   @override
//   State<DrawerScreen> createState() => _DrawerScreenState();
// }

// bool isClickLanguage = false;
// bool isClickContact = false;

// class _DrawerScreenState extends State<DrawerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<MyDrawerController>(builder: (controller) {
//       return Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [primary, Colors.black87])),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             leading: GestureDetector(
//               onTap: () {
//                 controller.tootgleDrawer();
//               },
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.black,
//                 size: Dimesion.iconSize16,
//               ),
//             ),
//             elevation: 0,
//           ),
//           body: Drawer(
//             backgroundColor: Colors.transparent,
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [primary, Colors.black54]),
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(Dimesion.radius20),
//                 ),
//                 color: Colors.white,
//               ),
//               child: ListView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: EdgeInsets.symmetric(horizontal: Dimesion.width5),
//                   children: [
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: Dimesion.height10),
//                       padding: EdgeInsets.all(Dimesion.height15),
//                       height: Dimesion.height40 * 3,
//                       width: Dimesion.width30 * 2,
//                       decoration: const BoxDecoration(
//                           color: Colors.black, shape: BoxShape.circle),
//                       child: Image.asset(
//                         'assets/logo.png',
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     Center(
//                         child: Text("Welcome To Binary-Store".tr,
//                             style: GoogleFonts.oswald(
//                                 color: Colors.white,
//                                 fontSize: Dimesion.font16 - 2,
//                                 fontWeight: FontWeight.bold))),
//                     SizedBox(
//                       height: Dimesion.height10,
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                             decoration: const BoxDecoration(
//                                 border: Border(
//                                     bottom: BorderSide(
//                                         color: Colors.black54,
//                                         width: 2,
//                                         style: BorderStyle.solid))),
//                             child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isClickLanguage = !isClickLanguage;
//                                   });
//                                 },
//                                 child: firstMenuItem(
//                                     text: "language".tr,
//                                     icon: Icons.language_rounded,
//                                     drop: !isClickLanguage
//                                         ? Icons.keyboard_arrow_down_rounded
//                                         : Icons.keyboard_arrow_up_rounded))),
//                         ExpandedSection(
//                           child: Container(
//                             alignment: Alignment.center,
//                             margin: EdgeInsets.symmetric(
//                                 vertical: Dimesion.height10),
//                             child: ToggleSwitch(
//                               minWidth: Dimesion.width30 * 2.5,
//                               cornerRadius: 20.0,
//                               activeBgColors: [
//                                 [primary],
//                                 [primary]
//                               ],
//                               activeFgColor: primary,
//                               inactiveBgColor: Colors.grey,
//                               inactiveFgColor: Colors.white,
//                               initialLabelIndex:
//                                   controller.currentSelectedLangID.value,
//                               totalSwitches: 2,
//                               customTextStyles: [
//                                 TextStyle(
//                                     color: Colors.white,
//                                     fontSize: Dimesion.font12 - 2),
//                                 TextStyle(
//                                     color: Colors.white,
//                                     fontSize: Dimesion.font12 - 2)
//                               ],
//                               labels: ['english'.tr, 'myanmar'.tr],
//                               radiusStyle: true,
//                               onToggle: (index) {
//                                 controller.onClickLanguage(index);
//                                 // print(index);
//                               },
//                             ),
//                           ),
//                           expand: isClickLanguage,
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                             decoration: const BoxDecoration(
//                                 border: Border(
//                                     bottom: BorderSide(
//                                         color: Colors.black54,
//                                         width: 2,
//                                         style: BorderStyle.solid))),
//                             child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     isClickContact = !isClickContact;
//                                   });
//                                 },
//                                 child: firstMenuItem(
//                                     text: "contactUs".tr,
//                                     icon: Icons.contact_phone_rounded,
//                                     drop: !isClickContact
//                                         ? Icons.keyboard_arrow_down_rounded
//                                         : Icons.keyboard_arrow_up_rounded))),
//                       ],
//                     ),
//                     Container(
//                         decoration: const BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(
//                                     color: Colors.black54,
//                                     width: 2,
//                                     style: BorderStyle.solid))),
//                         child: GestureDetector(
//                             onTap: () {},
//                             child: MenuItem(
//                               text: "terms",
//                               icon: Icons.description_outlined,
//                             ))),
//                     Container(
//                         decoration: const BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(
//                                     color: Colors.black54,
//                                     width: 2,
//                                     style: BorderStyle.solid))),
//                         child: GestureDetector(
//                             onTap: () {
//                               // Get.to(() => PrivacyScreen(),
//                               //     transition: Transition.rightToLeftWithFade,
//                               //     duration: Duration(milliseconds: 200));
//                             },
//                             child: MenuItem(
//                               text: "privacy".tr,
//                               icon: Icons.policy_rounded,
//                             ))),
//                     SizedBox(
//                       height: Dimesion.height10,
//                     ),
//                     Center(
//                         child: Text(
//                       APP_VERSION,
//                       style: TextStyle(fontSize: Dimesion.font12 - 2),
//                     )),
//                     SizedBox(
//                       height: Dimesion.height40,
//                     ),
//                   ]),
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget MenuItem({
//     required String text,
//     required IconData icon,
//   }) {
//     final color = Colors.black;
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: Colors.black,
//       ),
//       title: Text(
//         text,
//         style: TextStyle(color: color, fontSize: Dimesion.font12),
//       ),
//     );
//   }

//   Widget firstMenuItem({
//     IconData? drop,
//     required String text,
//     required IconData icon,
//   }) {
//     final color = Colors.black;
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: Colors.black,
//       ),
//       title: Text(
//         text,
//         style: TextStyle(color: color, fontSize: Dimesion.font12),
//       ),
//       trailing: Icon(
//         drop,
//         size: Dimesion.iconSize16,
//         color: primary,
//       ),
//     );
//   }
// }
