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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late UserProvider userProvider;

  var fcm = "";

  @override
  void initState() {
    super.initState();
  }

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
      child: Scaffold(
        backgroundColor: MasterColors.lMainColor,
        appBar: AppBar(
          toolbarHeight: 60,
          foregroundColor: Colors.white,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: MasterColors.black,
              size: Dimesion.height24,
            ),
          ),
          elevation: 0,
          iconTheme: IconThemeData(color: MasterColors.textColor2),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset(
                      "assets/images/360profile.png",
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimesion.height20, vertical: Dimesion.height5),
                child: Text(
                  "register".tr,
                  style: TextStyle(
                      color: Color.fromRGBO(254, 242, 0, 1),
                      fontSize: Dimesion.font16,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                  child: SizedBox(
                    height: 61,
                    child: MasterTextFieldWidget(
                        hintText: "name".tr,
                        textEditingController: nameController),
                  )),
              SizedBox(
                height: Dimesion.height10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                  child: SizedBox(
                    height: 62,
                    child: MasterTextFieldWidget(
                        hintText: "phone".tr,
                        textEditingController: phoneController),
                  )),
              SizedBox(
                height: Dimesion.height10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                child: SizedBox(
                  height: 62,
                  child: MasterTextFieldWidget(
                    hintText: "email (optional)".tr,
                    textEditingController: emailController,
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
                    textEditingController: passwordController),
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
                                        unselectedWidgetColor:
                                            MasterColors.black),
                                    child: Checkbox(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3))),
                                      activeColor: MasterColors.black,
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    ),
                                  )),
                              Text(
                                'remeber'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: Dimesion.font12,
                                ),
                              )
                            ]),
                      ),
                    ]),
              ),
              SizedBox(
                height: Dimesion.height10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    if (nameController.text == '') {
                      callWarningDialog(context, 'warning_dialog_name'.tr);
                    } 
                     else if (passwordController.text == '') {
                      callWarningDialog(context, 'warning_dialog_password'.tr);
                    } else if (passwordController.text.length < 8) {
                      callWarningDialog(context,
                          'password must be more than 7 characters'.tr);
                    } else if (phoneController.text == '') {
                      callWarningDialog(context, 'warning_dialog_password'.tr);
                    } else if (phoneController.text.length < 8) {
                      callWarningDialog(context,
                          'password must be more than 7 characters'.tr);
                    } else {
                      await userProvider.postUserRegister(
                        context,
                        name: nameController.text,
                        password: passwordController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                        fcmToken: _notiController.fcm.value,
                        callBackAfterLoginSuccess: (String user) {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutePaths.home,
                          );
                        },
                      );
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
                        "next".tr,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimesion.height5,
              ),
            ],
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
