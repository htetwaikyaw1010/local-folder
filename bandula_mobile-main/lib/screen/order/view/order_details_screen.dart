import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/constant/dimesions.dart';
import 'package:bandula/core/provider/order/order_details_provider.dart';
import 'package:bandula/core/repository/order_details_repository.dart';
import 'package:bandula/core/viewobject/common/master_value_holder.dart';
import '../../../config/master_colors.dart';
import '../../../core/utils/utils.dart';
import '../../../core/viewobject/holder/request_path_holder.dart';
import '../../../core/viewobject/order_detail.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({Key? key, required this.orderID}) : super(key: key);
  final String orderID;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final MasterValueHolder valueHolder =
        Provider.of<MasterValueHolder>(context);

    final OrderDetailsRepository repository =
        Provider.of<OrderDetailsRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrderDetailsProvier>(
          lazy: false,
          create: (BuildContext context) {
            OrderDetailsProvier orderProvier =
                OrderDetailsProvier(repo: repository);
            orderProvier.loadData(
              requestPathHolder: RequestPathHolder(
                orderId: widget.orderID,
                headerToken: valueHolder.loginUserToken,
              ),
            );
            return orderProvier;
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: MasterColors.grey,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: MasterColors.mainColor,
          title: Text(
            'Order Details',
            style: TextStyle(color: Color.fromRGBO(254, 242, 0, 1)),
          ),
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Color.fromRGBO(254, 242, 0, 1)),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
        ),
        body: Consumer<OrderDetailsProvier>(
          builder:
              (BuildContext context, OrderDetailsProvier pro, Widget? child) {
            OrderDetails order = pro.order;
            return pro.hasData
                ? Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimesion.height10,
                        vertical: Dimesion.height10),
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimesion.height10,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Dimesion.height10),
                                width: Dimesion.height200,
                                height: Dimesion.height200,
                                child: CachedNetworkImage(
                                  imageUrl: order.paymentPhoto ?? "",
                                  fit: BoxFit.fill,
                                  errorWidget: (BuildContext context,
                                          String url, Object? error) =>
                                      Image.asset(
                                    'assets/images/placeholder_image.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // if (order == null)
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Dimesion.height10),
                            child: Divider(
                              height: 1,
                              color: MasterColors.black,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Dimesion.height50,
                                child: Text(
                                  'Photo',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: MasterColors.black,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: Dimesion.height100,
                                child: Text(
                                  'Product Name',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: MasterColors.black,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: Dimesion.height100,
                                child: Text(
                                  'Product Price',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: MasterColors.black,
                                      ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(254, 242, 0, 1),
                                borderRadius: BorderRadius.circular(13)),
                            margin: EdgeInsets.symmetric(
                                vertical: Dimesion.height20),
                            padding: EdgeInsets.symmetric(
                                vertical: Dimesion.width10),
                            height: Dimesion.height30 * 2,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              children: List.generate(
                                order.orderProduct!.length,
                                (i) => Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Dimesion.height50,
                                          height: Dimesion.height50,
                                          child: CachedNetworkImage(
                                            imageUrl: order.orderProduct![i]
                                                    .product?.photo ??
                                                '',
                                            fit: BoxFit.fill,
                                            errorWidget: (BuildContext context,
                                                    String url,
                                                    Object? error) =>
                                                Image.asset(
                                              'assets/images/placeholder_image.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Text(
                                            order.orderProduct![i].product
                                                    ?.name ??
                                                '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: MasterColors.black,
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimesion.height100,
                                          child: Text(
                                            '${NumberFormat("#,##0", "en_Us").format(int.parse(order.orderProduct![i].subPrice.toString()))}  MMK',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: MasterColors.black,
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: Dimesion.height10),
                                      child: const Divider(
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(bottom: Dimesion.height10),
                            child: Divider(
                              height: 1,
                              color: MasterColors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                order.date ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                              Card(
                                margin: const EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Utils.statusColor(order.status!),
                                elevation: 3,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 20,
                                  child: Text(
                                    checkStatus(order.status ?? ""),
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: MasterColors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Dimesion.height10),
                            child: const Divider(
                              height: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Order-ID',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                              Text(
                                ' Order#${widget.orderID} ',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              )
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Dimesion.height5),
                            child: const Divider(
                              height: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Delivery Name',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                              Text(
                                '${order.customerName}',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimesion.height5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Delivery Phone',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                              Text(
                                '${order.phone}',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimesion.height5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Delivery Fee ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                              Text(
                                '${NumberFormat("#,##0", "en_Us").format(int.parse(order.deliveryFee.toString()))}  MMK',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Dimesion.height10),
                            child: const Divider(
                              height: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Payment Type',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                              Text(
                                order.paymentMethod!,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              )
                            ],
                          ),
                          SizedBox(height: Dimesion.height5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Payment number',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                              Text(
                                order.paymentNumber ?? '',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              )
                            ],
                          ),
                          SizedBox(height: Dimesion.height10),
                          LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              final double boxWidth =
                                  constraints.constrainWidth();
                              const double dashWidth = 10.0;
                              final int dashCount =
                                  (boxWidth / (2 * dashWidth)).floor();
                              return Flex(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                direction: Axis.horizontal,
                                children: List<Widget>.generate(dashCount, (_) {
                                  return const SizedBox(
                                    width: dashWidth,
                                    height: 1,
                                    child: DecoratedBox(
                                      decoration:
                                          BoxDecoration(color: Colors.grey),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),

                          SizedBox(height: Dimesion.height10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Product Qty',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                              Text(
                                '${order.totalProductQty}',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              )
                            ],
                          ),
                          const SizedBox(height: 6),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Total Amount',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: MasterColors.black),
                              ),
                              Text(
                                '${NumberFormat("#,##0", "en_Us").format(int.parse(order.totalPrice.toString()))}  MMK',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: MasterColors.black,
                                    ),
                              )
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Dimesion.height10),
                            child: const Divider(
                              height: 1,
                            ),
                          ),

                          if (order.refundSlip!.isNotEmpty)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Refund Slip',
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: MasterColors.black,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                                Text(
                                  order.refundMessage ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: MasterColors.black,
                                      ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Dimesion.width10,
                                      horizontal: Dimesion.height10),
                                  width: Dimesion.height200,
                                  height: Dimesion.height200,
                                  child: CachedNetworkImage(
                                    imageUrl: order.refundSlip!,
                                    fit: BoxFit.fill,
                                    errorWidget: (BuildContext context,
                                            String url, Object? error) =>
                                        Image.asset(
                                      'assets/images/placeholder_image.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  )
                : Container();
          },
        ),
      ),
    );
  }

  String checkStatus(String status) {
    switch (status) {
      case "0":
        return "Pending";
      case "1":
        return "Comfirm";
      case "2":
        return "Completed";
      case "3":
        return "Reject";
      case "4":
        return "Refund";
      default:
    }
    return '';
  }
}
