import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:bandula/core/viewobject/cart_product.dart';

import '../../../config/master_colors.dart';
import '../../../core/constant/dimesions.dart';
import '../../../core/provider/cart/cart_provider.dart';

class AddToCardBottomShetWiget extends StatefulWidget {
  const AddToCardBottomShetWiget(
      {Key? key, required this.cartProduct, required this.cartProvider})
      : super(key: key);

  final CartProduct cartProduct;
  final CartProvider cartProvider;

  @override
  State<AddToCardBottomShetWiget> createState() =>
      _AddToCardBottomShetWigetState();
}

class _AddToCardBottomShetWigetState extends State<AddToCardBottomShetWiget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimesion.height20),
      height: 250,
      decoration: BoxDecoration(
          color: Color.fromRGBO(254, 242, 0, 1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: Dimesion.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add to Cart',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: MasterColors.textColor2,
                      fontWeight: FontWeight.normal),
                ),
                InkWell(
                  child: const Icon(Icons.close),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: Dimesion.height5, right: Dimesion.height20),
                  child: Text(
                    'Quantity',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: MasterColors.black,
                        ),
                  )),
              Container(
                margin: EdgeInsets.only(
                  top: Dimesion.height5,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (widget.cartProduct.quantity! > 1) {
                          setState(() {
                            widget.cartProduct.quantity =
                                widget.cartProduct.quantity! - 1;
                            widget.cartProduct.cost =
                                widget.cartProduct.quantity! *
                                    double.parse(
                                        widget.cartProduct.product!.price!);
                          });
                        }
                      },
                      child: Icon(
                        Icons.remove,
                        size: Dimesion.iconSize16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: Dimesion.height20,
                    ),
                    Text(
                      widget.cartProduct.quantity.toString(),
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
                            widget.cartProduct.cost =
                                widget.cartProduct.quantity! *
                                    double.parse(
                                        widget.cartProduct.product!.price!);
                          });
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
                        size: Dimesion.iconSize16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimesion.height20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimesion.font16,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '${NumberFormat("#,##0", "en_Us").format(widget.cartProduct.cost)} MMK',
                  style: TextStyle(
                      color: MasterColors.mainColor,
                      fontSize: Dimesion.font16,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (widget.cartProduct.product!.stock! > 0) {
                // bool run = true;
                // for (CartProduct data in widget.cartProvider.dataList.data!) {
                //   if (data.product!.id == widget.cartProduct.product!.id) {
                //     run = false;
                //   }
                // }
                // if (run) {
                  await widget.cartProvider.addToDatabase(widget.cartProduct);
                  // await widget.cartProvider
                  //     .loadDataListFromDatabase(reset: true);
                //}
              }
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MasterColors.mainColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Text(
                  'Add to cart',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Color.fromRGBO(254, 242, 0, 1),
                      ),
                )),
          )
        ],
      ),
    );
  }
}
