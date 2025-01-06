import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bandula/config/master_colors.dart';
import 'package:bandula/core/viewobject/order.dart';
import '../../../../../core/constant/dimesions.dart';
import '../../../../config/route/route_paths.dart';
import '../../../../core/viewobject/holder/intent_holder/order_detail_intent_holder.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final OrderDetailsIntentHolder holder =
            OrderDetailsIntentHolder(id: order.orderID ?? '');
        Navigator.pushNamed(context, RoutePaths.orderDetails,
            arguments: holder);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(254, 242, 0, 1),
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(vertical: Dimesion.height20),
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.only(
            //     left: Dimesion.height10,
            //     right: Dimesion.height10,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(order.order!.date.toString(),
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //           style: Theme.of(context).textTheme.labelSmall!.copyWith(
            //               fontWeight: FontWeight.w700,
            //               color: MasterColors.black)),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Dimesion.height5, vertical: Dimesion.height10),
            //   child: Divider(
            //     color: MasterColors.black,
            //     height: 1,
            //   ),
            // ),
            Container(
              padding: EdgeInsets.only(
                left: Dimesion.height10,
                right: Dimesion.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.order!.date!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: MasterColors.black)),
                  SizedBox(
                    width: Dimesion.height150,
                    child: Text('Order #${order.orderID.toString()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: Dimesion.font12,
                            fontWeight: FontWeight.w700,
                            color: MasterColors.black)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimesion.height5, vertical: Dimesion.height10),
              child: Divider(
                color: MasterColors.black,
                height: 1,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Dimesion.height10,
                right: Dimesion.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: MasterColors.black)),
                  Text(
                      '${NumberFormat("#,##0", "en_Us").format(int.parse(order.order!.totalPrice.toString()))} MMK',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: MasterColors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
