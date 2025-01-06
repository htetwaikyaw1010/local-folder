import 'package:bandula/core/viewobject/common/master_value_holder.dart';
import 'package:bandula/noti_controller.dart';
import 'package:bandula/screen/notification/view/noti_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:provider/provider.dart';
import '../../../../config/master_colors.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../../core/provider/cart/cart_provider.dart';
import '../../../../core/utils/utils.dart';

final _notiController = Get.put(NotiController());

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key, required this.appBarTitleName, required this.isAccount, required this.index});
  final String appBarTitleName;
  final bool isAccount;
  final String index;

  @override
  Widget build(BuildContext context) {
    final MasterValueHolder valueHolder =
        Provider.of<MasterValueHolder>(context);

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 60,
      // backgroundColor: MasterColors.lappBarColor,
      title:const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bandula",
          ),
          Visibility(
            visible: true,
            child: Text(
              'Mobile',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
      ),
      titleTextStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: Color.fromRGBO(254, 242, 0, 1)),
      actions: [
        Obx(() => GestureDetector(
              onTap: () {
                _notiController.showBadge.value = false;
                _notiController.callNoti(valueHolder.loginUserToken ?? '',
                    int.parse(valueHolder.loginUserId ?? ''));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotiPage(),
                    ));
              },
              child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: _notiController.showBadge.value
                            ? const Icon(
                                Icons.notifications_active_outlined,
                                color: Color.fromRGBO(254, 242, 0, 1),
                              )
                            : const Icon(
                                Icons.notifications_none,
                                color: Color.fromRGBO(254, 242, 0, 1),
                              ),
                      ),
                      _notiController.count.value == 0
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    "${_notiController.count}",
                                    style: const TextStyle(
                                        fontSize: 8.5, color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                    ],
                  )),
            )),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutePaths.cart,
            );
          },
          child: Stack(
            children: [
              SizedBox(
                width: Dimesion.height50,
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Color.fromRGBO(254, 242, 0, 1),
                    size: Dimesion.height20,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Consumer<CartProvider>(
                  builder: (BuildContext context, CartProvider cartProvider,
                      Widget? child) {
                    if (cartProvider.dataLength != 0) {
                      int cartItemCount = cartProvider.dataLength;

                      return Container(
                        alignment: Alignment.topCenter,
                        height: Dimesion.height18,
                        width: Dimesion.height18,
                        // decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: Color.fromRGBO(254, 242, 0, 1)),
                        child: Text(
                          cartItemCount > 9 ? '9+' : cartItemCount.toString(),
                          // textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: MasterColors.white,
                                  fontSize: Dimesion.font16),
                          maxLines: 1,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
      iconTheme: IconThemeData(color: MasterColors.textColor2),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
