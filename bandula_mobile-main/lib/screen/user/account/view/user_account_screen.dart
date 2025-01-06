// ignore_for_file: deprecated_member_use

import 'package:bandula/core/provider/cart/cart_provider.dart';
import 'package:bandula/core/repository/Common/master_repository.dart';
import 'package:bandula/core/repository/card_repository.dart';
import 'package:bandula/core/utils/ps_progress_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/utils/utils.dart';

import 'package:bandula/core/viewobject/common/master_value_holder.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/master_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../../core/provider/user/user_provider.dart';
import '../../../../core/repository/user_repository.dart';
import '../../../common/dialog/confirm_dialog_view.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  MasterValueHolder? valueHolder;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext contexts) {
    valueHolder = Provider.of<MasterValueHolder>(context);
    final UserRepository userRepository = Provider.of<UserRepository>(context);
    print("TOKEN ${valueHolder?.fcmToken}");
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
          backgroundColor: MasterColors.grey,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: Dimesion.height10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(254, 242, 0, 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  height: Dimesion.height100,
                  width: Dimesion.height100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: valueHolder!.loginUserPhoto ?? '',
                      height: Dimesion.height100,
                      width: Dimesion.height100,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: MasterColors.mainColor,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/userprofile.png'),
                      imageBuilder: (context, img) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimesion.width20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimesion.radius15 / 2),
                            image: DecorationImage(
                              image: img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (Utils.isLogined(valueHolder)) ...[
                  Container(
                    margin: EdgeInsets.only(top: Dimesion.height10),
                    alignment: Alignment.center,
                    child: Text(
                      valueHolder!.loginUserName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: MasterColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimesion.height10),
                    alignment: Alignment.center,
                    child: Text(
                      '${valueHolder!.loginUserEmail}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: MasterColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimesion.height20,
                        vertical: Dimesion.height30),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(254, 242, 0, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutePaths.changePassword,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimesion.height18,
                                vertical: Dimesion.height12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.key_outlined,
                                      size: Dimesion.height24,
                                      color: MasterColors.mainColor,
                                    ),
                                    SizedBox(
                                      width: Dimesion.height24,
                                    ),
                                    Text(
                                      'change_password'.tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: MasterColors.black,
                                              fontSize: 16),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: MasterColors.black,
                                  size: Dimesion.height24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimesion.height20),
                          child: const Divider(
                            height: 1,
                            color: Colors.black38,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            return showDialog<dynamic>(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmDialogView(
                                  title: 'delete_confrim'.tr,
                                  description: 'ask_delete'.tr,
                                  leftButtonText: 'no_delete'.tr,
                                  rightButtonText: 'delete'.tr,
                                  onAgreeTap: () async {
                                    Navigator.pop(context);
                                    await userProvider.deleteAccount(
                                      contexts,
                                      valueHolder!.loginUserToken ?? '',
                                      valueHolder!.loginUserId.toString(),
                                      (String user) {
                                        Navigator.pushReplacementNamed(
                                          contexts,
                                          RoutePaths.login,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimesion.height18,
                                vertical: Dimesion.height12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.delete_forever,
                                      size: Dimesion.height24,
                                      color: MasterColors.mainColor,
                                    ),
                                    SizedBox(
                                      width: Dimesion.height24,
                                    ),
                                    Text(
                                      'delete_account'.tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: MasterColors.black,
                                            fontSize: 16,
                                          ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: MasterColors.black,
                                  size: Dimesion.height24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimesion.height20),
                          child: const Divider(
                            height: 1,
                            color: Colors.black38,
                          ),
                        ),
                        Consumer<AppLocalization>(
                          builder: (context, currentData, child) {
                            return InkWell(
                                onTap: () async {
                                  return showDialog<dynamic>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          width: double.maxFinite,
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListTile(
                                                  onTap: () {
                                                    currentData.setLocale(
                                                        const Locale("my"));
                                                    Navigator.pop(context);
                                                  },
                                                  leading: SvgPicture.asset(
                                                      'assets/svgs/mm.svg',
                                                      width: 20),
                                                  title: const Text(
                                                    "မြန်မာ",
                                                  ),
                                                ),
                                                ListTile(
                                                  onTap: () {
                                                    currentData.setLocale(
                                                        const Locale("en"));
                                                    Navigator.pop(context);
                                                  },
                                                  leading: SvgPicture.asset(
                                                    'assets/svgs/eng.svg',
                                                    width: 20,
                                                  ),
                                                  title: const Text(
                                                    "English",
                                                    style: TextStyle(),
                                                  ),
                                                )
                                              ]),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Dimesion.height18,
                                      vertical: Dimesion.height12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.language,
                                            size: Dimesion.height24,
                                            color: MasterColors.mainColor,
                                          ),
                                          SizedBox(
                                            width: Dimesion.height24,
                                          ),
                                          Text(
                                            'language'.tr,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                  color: MasterColors.black,
                                                  fontSize: 16,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: MasterColors.black,
                                        size: Dimesion.height24,
                                      ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: Dimesion.height60,
                      right: Dimesion.height60,
                      top: Dimesion.height40,
                    ),
                    decoration: BoxDecoration(
                      color: MasterColors.mainColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            return showDialog<dynamic>(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmDialogView(
                                  title: 'confirm_logout'.tr,
                                  description: 'ask_logut'.tr,
                                  leftButtonText: 'no_logout'.tr,
                                  rightButtonText: 'go_logout'.tr,
                                  onAgreeTap: () async {
                                    Navigator.pop(context);
                                    userProvider.userLogout(contexts,
                                        valueHolder!.loginUserToken ?? '',
                                        callFuntion: (String user) {
                                          MasterProgressDialog.dismissDialog();
                                      Navigator.pushReplacementNamed(
                                        contexts,
                                        RoutePaths.login,
                                      );
                                    });
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimesion.height18,
                                vertical: Dimesion.height8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      size: Dimesion.height24,
                                      color: Color.fromRGBO(254, 242, 0, 1),
                                    ),
                                    SizedBox(
                                      width: Dimesion.height24,
                                    ),
                                    Text(
                                      'logout'.tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color:
                                                Color.fromRGBO(254, 242, 0, 1),
                                            fontSize: 16,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ] else ...[
                  Container(
                    margin: EdgeInsets.only(
                      left: Dimesion.height60,
                      right: Dimesion.height60,
                      top: Dimesion.height40,
                    ),
                    decoration: BoxDecoration(
                      color: MasterColors.mainColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            await Navigator.pushReplacementNamed(
                              context,
                              RoutePaths.login,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimesion.height18,
                                vertical: Dimesion.height8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      size: Dimesion.height24,
                                      color: Color.fromRGBO(254, 242, 0, 1),
                                    ),
                                    SizedBox(
                                      width: Dimesion.height24,
                                    ),
                                    Text(
                                      'login'.tr,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color:
                                                Color.fromRGBO(254, 242, 0, 1),
                                            fontSize: 16,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                const SizedBox(height: 50),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: const Color(0xFF3b5998),
                          onPressed: () {
                            _launchUrl();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/facebook.svg',
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "ဗန္ဓုလ Mobile's Facebook Page",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: const Color(0xFF3b5998),
                          onPressed: () {
                            _launchSocial("fb-messenger://user/107142824168821",
                                "https://m.me/BandulaMobile");
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/images/facebook-messenger.svg',
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "ဗန္ဓုလ Mobile's Messenger",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
          // : const CallLoginView(),
          ),
    );
  }

  final Uri _url = Uri.parse('https://web.facebook.com/Bandulamobile');

  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
