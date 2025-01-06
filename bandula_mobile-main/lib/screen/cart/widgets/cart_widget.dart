import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/cart/cart_provider.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../core/viewobject/cart_product.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({super.key, required this.cartProduct});
  final CartProduct cartProduct;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Dismissible(
      key: ValueKey<int>(widget.cartProduct.product!.id!),
      onDismissed: (DismissDirection direction) {
        cartProvider.deleteFromDatabase(widget.cartProduct);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimesion.height5),
        decoration: BoxDecoration(
            color: Color.fromRGBO(254, 242, 0, 1),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text('${Dimesion.screenWidth * 0.3}'),
            SizedBox(
              width: Dimesion.screenWidth * 0.4,
              child: Stack(
                children: [
                  SizedBox(
                    height: Dimesion.height60 * 2,
                    width: Dimesion.height130,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12)),
                      child: CachedNetworkImage(
                          imageUrl:
                              widget.cartProduct.product!.photos![0] ?? '',
                          height: Dimesion.height60 * 2,
                          width: double.infinity,
                          placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: MasterColors.mainColor,
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/noimg.png'),
                          imageBuilder: (context, img) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimesion.width20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimesion.radius15 / 2),
                                  image: DecorationImage(
                                      image: img, fit: BoxFit.cover)),
                            );
                          }),
                    ),
                  ),
                  Positioned(
                    top: Dimesion.height10,
                    left: Dimesion.height10,
                    child: Container(
                        decoration: BoxDecoration(
                          color: MasterColors.successColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimesion.height20,
                            vertical: Dimesion.height2),
                        child: Text(
                          'Instock',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Color.fromRGBO(254, 242, 0, 1)),
                        )),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   width: Dimesion.height10,
            // ),
            SizedBox(
              width: Dimesion.screenWidth * 0.45,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        top: Dimesion.height10,
                      ),
                      width: Dimesion.height120,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              widget.cartProduct.product!.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: MasterColors.black,
                                  ),
                            ),
                          ],
                        ),
                      )),
                  Container(
                      // color: Colors.amber,
                      // alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: Dimesion.height8),
                      child: Text(
                          '${NumberFormat("#,##0", "en_Us").format(widget.cartProduct.cost)} MMK',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall!)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: Dimesion.height5),
                          decoration: BoxDecoration(
                            color: MasterColors.mainColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimesion.height10,
                              vertical: Dimesion.height2),
                          child: Text(
                            widget.cartProduct.product!.brandName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Color.fromRGBO(254, 242, 0, 1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimesion.height10,
                  ),
                  SizedBox(
                    width: Dimesion.screenWidth * 0.45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: MasterColors.black, fontSize: 14),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (widget.cartProduct.quantity! > 1) {
                                  setState(() {
                                    widget.cartProduct.quantity =
                                        widget.cartProduct.quantity! - 1;
                                    widget.cartProduct.cost = widget
                                            .cartProduct.quantity! *
                                        double.parse(
                                            widget.cartProduct.product!.price!);
                                    cartProvider.totalCost -= double.parse(
                                        widget.cartProduct.product!.price!);
                                  });

                                  await cartProvider
                                      .updateToDatabase(widget.cartProduct);
                                }
                              },
                              child: Icon(
                                Icons.remove,
                                size: Dimesion.iconSize20,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: Dimesion.height20,
                            ),
                            Text(
                              widget.cartProduct.quantity.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: MasterColors.black,
                                  ),
                            ),
                            SizedBox(
                              width: Dimesion.height20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (widget.cartProduct.product!.stock! > 1 &&
                                    widget.cartProduct.quantity! <
                                        widget.cartProduct.product!.stock!) {
                                  setState(() {
                                    widget.cartProduct.quantity =
                                        widget.cartProduct.quantity! + 1;
                                    widget.cartProduct.cost = widget
                                            .cartProduct.quantity! *
                                        double.parse(
                                            widget.cartProduct.product!.price!);
                                    cartProvider.totalCost += double.parse(
                                        widget.cartProduct.product!.price!);
                                  });
                                  await cartProvider.updateToDatabase(
                                    widget.cartProduct,
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Only ${widget.cartProduct.product!.stock!} stock left",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey[400],
                                      textColor: Colors.black,
                                      fontSize: 16.0);
                                  print(
                                      "Only ${widget.cartProduct.product!.stock!} stock left!!");
                                }
                              },
                              child: Icon(
                                Icons.add,
                                size: Dimesion.iconSize20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
