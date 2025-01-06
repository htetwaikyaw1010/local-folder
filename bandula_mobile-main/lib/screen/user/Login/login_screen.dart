import 'package:bandula/noti_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/viewobject/common/master_value_holder.dart';

import '../../../config/master_colors.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/constant/dimesions.dart';
import '../../../core/provider/user/user_provider.dart';
import '../../../core/repository/user_repository.dart';
import '../../../core/utils/utils.dart';
import '../../common/dialog/warning_dialog_view.dart';
import '../../common/textfield_widget_with_icon.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

final _notiController = Get.put(NotiController());

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // bool _passwordVisible = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    // _passwordVisible = false;
  }

  String fcmToken = "";

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    final MasterValueHolder valueHolder =
        Provider.of<MasterValueHolder>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            lazy: false,
            create: (BuildContext context) {
              userProvider = UserProvider(repo: userRepository);
              return userProvider;
            }),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: MasterColors.lMainColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            // leading: InkWell(
            //   onTap: () => Navigator.pop(context),
            //   child: Icon(
            //     Icons.arrow_back,
            //     color: MasterColors.black,
            //     size: Dimesion.height24,
            //   ),
            // ),
            elevation: 0,
            iconTheme: IconThemeData(color: MasterColors.textColor2),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset(
                      "assets/images/360profile.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimesion.height20,
                        vertical: Dimesion.height5),
                    child: Text(
                      "login".tr,
                      style: TextStyle(
                          color: Color.fromRGBO(254, 242, 0, 1),
                          fontSize: Dimesion.font18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                    child: SizedBox(
                      height: 60,
                      child: MasterTextFieldWidget(
                        hintText: "phoneOrEmail".tr,
                        textEditingController: phoneController,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimesion.height10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                    child: MasterPasswordTextFieldWidget(
                      hintText: "password".tr,
                      textEditingController: passwordController,
                    ),
                  ),
        
                  const SizedBox(height: 10,),
        
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimesion.height20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: Dimesion.height24,
                                width: Dimesion.height24,
                                child: Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: MasterColors.black),
                                  child: Checkbox(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                    ),
                                    activeColor: MasterColors.black,
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                'remeber'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: Dimesion.font12,
                                ),
                              )
                            ],
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Text(
                        //     "Forget Password?",
                        //     style: TextStyle(
                        //       color: MasterColors.mainColor,
                        //       fontSize: Dimesion.font12,
                        //       fontWeight: FontWeight.normal,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimesion.height20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (phoneController.text == '') {
                        callWarningDialog(
                            context, 'warning_dialog_credentials'.tr);
                      } else if (passwordController.text == '') {
                        callWarningDialog(context, 'warning_dialog_password'.tr);
                      } else {
                        print("TOKEN ${valueHolder.fcmToken}");
                        await userProvider.postUserLogin(
                            context,
                            phoneController.text.trim(),
                            passwordController.text, (String user) {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutePaths.home,
                          );
                        }, _notiController.fcm.value);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 43,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(254, 242, 0, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "login".tr,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: Text("no_account".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: Dimesion.font12 - 2,
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutePaths.signUp,
                          );
                        },
                        child: Text(
                          'register'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.blue,
                            fontSize: Dimesion.font12 - 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimesion.height15),
                  Center(
                      child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutePaths.home,
                      );
                    },
                    child: Text(
                      'Continue as Guest'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontSize: Dimesion.font16 - 2,
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic callWarningDialog(BuildContext context, String text) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return WarningDialog(
          message: text.tr,
          onPressed: () {},
        );
      },
    );
  }
}
