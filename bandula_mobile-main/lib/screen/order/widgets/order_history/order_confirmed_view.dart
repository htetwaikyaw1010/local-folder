import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import '../../../../../core/constant/dimesions.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/provider/order/order_provider.dart';
import 'order_list_item.dart';

class ConfirmedOrderView extends StatefulWidget {
  const ConfirmedOrderView({Key? key}) : super(key: key);

  @override
  State<ConfirmedOrderView> createState() => _ConfirmedOrderViewState();
}

class _ConfirmedOrderViewState extends State<ConfirmedOrderView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvier>(
        builder: (BuildContext context, OrderProvier pro, Widget? child) {
      return pro.hasConfirmedOrders
          ? SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimesion.height20, vertical: Dimesion.height20),
                child: Column(children: [
                  MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 0.9,
                                  crossAxisSpacing: Dimesion.height20,
                                  mainAxisSpacing: Dimesion.height10,
                                  mainAxisExtent: Dimesion.height40 * 2.5),
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: pro.confirmedOrders.length,
                          itemBuilder: (context, index) {
                            return OrderListItem(
                              order: pro.confirmedOrders[index],
                            );
                          })),
                ]),
              ),
            )
          : Center(
              child: Text('no_confrimed'.tr,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: MasterColors.black,
                      )),
            );
    });
  }
}
