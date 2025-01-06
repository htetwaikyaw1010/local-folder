import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import '../../config/master_colors.dart';
import '../../config/route/route_paths.dart';
import '../../core/constant/dimesions.dart';
import '../../core/utils/utils.dart';

class LoginOrSignUpView extends StatefulWidget {
  const LoginOrSignUpView({Key? key}) : super(key: key);

  @override
  State<LoginOrSignUpView> createState() => _LoginOrSignUpViewState();
}

class _LoginOrSignUpViewState extends State<LoginOrSignUpView> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  bool selected = true;
  List<String> itemsList = [
    'https://varro.imgix.net/1680590502894.jfif?w=600&h=370&fit=scale&q=65',
    'https://varro.imgix.net/1680590539865.jfif?w=600&h=370&fit=scale&q=65',
    'https://varro.imgix.net/1680600677822.jpg?w=600&h=370&fit=scale&q=65',
    'https://varro.imgix.net/1680600689626.jpg?w=600&h=370&fit=scale&q=65',
    'https://varro.imgix.net/1680600702003.jpg?w=600&h=370&fit=scale&q=65',
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(254, 242, 0, 1),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Image.asset('assets/images/360profile.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.login,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: Dimesion.height4,
                      right: Dimesion.height4,
                      top: 30,
                      bottom: 10,
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: MasterColors.mainColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text(
                      "login".tr,
                      style: TextStyle(
                        color: Color.fromRGBO(254, 242, 0, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.signUp,
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MasterColors.mainColor!,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "register".tr,
                        style: TextStyle(
                          color: MasterColors.mainColor,
                          fontSize: Dimesion.font12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // SingleChildScrollView(
      //   child: Stack(
      //     children: [
      //       Positioned(
      //         left: 0,
      //         right: 0,
      //         bottom: 0,
      //         top: 0,
      //         child: Container(
      //           decoration: const BoxDecoration(
      //             image: DecorationImage(
      //               image: AssetImage("assets/images/bg_img_red.png"),
      //               fit: BoxFit.fill,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Container(
      //             padding: EdgeInsets.only(left: Dimesion.height35),
      //             alignment: Alignment.centerLeft,
      //             height: MediaQuery.of(context).size.height * 0.55,
      //             child: Container(
      //                 margin: EdgeInsets.only(top: Dimesion.height10),
      //                 height: Dimesion.height40 * 6,
      //                 width: Dimesion.width30 * 8,
      //                 child: Image.asset("assets/images/logo.png")),
      //           ),
      //           InkWell(
      //             onTap: () {
      //               Navigator.pushNamed(
      //                 context,
      //                 RoutePaths.login,
      //               );
      //             },
      //             child: Container(
      //               alignment: Alignment.center,
      //               margin: EdgeInsets.symmetric(horizontal: Dimesion.height30),
      //               height: MediaQuery.of(context).size.height * 0.06,
      //               width: MediaQuery.of(context).size.width,
      //               decoration: BoxDecoration(
      //                 color: Color.fromRGBO(254, 242, 0, 1),
      //                 borderRadius:
      //                     BorderRadius.all(Radius.circular(Dimesion.height10)),
      //               ),
      //               child: Text(
      //                 "Login",
      //                 style: TextStyle(
      //                     color: MasterColors.mainColor,
      //                     fontSize: Dimesion.font12,
      //                     fontWeight: FontWeight.w700),
      //               ),
      //             ),
      //           ),
      //           InkWell(
      //             onTap: () {
      //               Navigator.pushNamed(
      //                 context,
      //                 RoutePaths.signUp,
      //               );
      //             },
      //             child: Container(
      //               alignment: Alignment.center,
      //               margin: EdgeInsets.symmetric(
      //                   horizontal: Dimesion.height30,
      //                   vertical: Dimesion.height20),
      //               height: MediaQuery.of(context).size.height * 0.06,
      //               width: MediaQuery.of(context).size.width,
      //               decoration: BoxDecoration(
      //                 border: Border.all(color: Colors.white, width: 1),
      //                 borderRadius:
      //                     BorderRadius.all(Radius.circular(Dimesion.height10)),
      //               ),
      //               child: Text(
      //                 "Register",
      //                 style: TextStyle(
      //                     color: Color.fromRGBO(254, 242, 0, 1),
      //                     fontSize: Dimesion.font12,
      //                     fontWeight: FontWeight.w700),
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             width: 250,
      //             height: 250,
      //             child: SvgPicture.asset(
      //               "assets/images/YourBestChoice.svg",
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
