import 'package:bandula/screen/common/dialog/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/viewobject/common/master_value_holder.dart';

import '../../../config/master_colors.dart';
import '../../../core/constant/dimesions.dart';
import '../../../core/provider/user/user_provider.dart';
import '../../../core/repository/user_repository.dart';
import '../../../core/utils/utils.dart';
import '../../common/button_widgets.dart';
import '../../common/textfield_widget_with_icon.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  // bool _passwordVisible = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    // _passwordVisible = false;
  }

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
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
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  "assets/images/360profile.png",
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimesion.height20, vertical: Dimesion.height5),
                child: Text(
                  "change_password".tr,
                  style: TextStyle(
                      color: MasterColors.black,
                      fontSize: Dimesion.font18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                child: MasterPasswordTextFieldWidget(
                    hintText: "old_password".tr,
                    textEditingController: oldPasswordController),
              ),
              SizedBox(
                height: Dimesion.height10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                child: MasterPasswordTextFieldWidget(
                    hintText: "new_password".tr,
                    textEditingController: passwordController),
              ),
              SizedBox(
                height: Dimesion.height10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimesion.width20),
                child: MasterPasswordTextFieldWidget(
                    hintText: "confirm_password".tr,
                    textEditingController: confirmPasswordController),
              ),
              SizedBox(
                height: Dimesion.height10,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    if (oldPasswordController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      showDialog<dynamic>(
                          context: context,
                          builder: (BuildContext context) {
                            return const ErrorDialog(
                              message: "Fill in all password fields",
                            );
                          });
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      showDialog<dynamic>(
                          context: context,
                          builder: (BuildContext context) {
                            return const ErrorDialog(
                              message: "Passwords do not match!",
                            );
                          });
                    } else {
                      await userProvider.changePassword(
                        context,
                        valueHolder.loginUserToken ?? '',
                        oldPasswordController.text.trim(),
                        passwordController.text,
                        confirmPasswordController.text,
                      );
                    }
                  },
                  child: BigButton(
                    text: "change_password".tr,
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
}
