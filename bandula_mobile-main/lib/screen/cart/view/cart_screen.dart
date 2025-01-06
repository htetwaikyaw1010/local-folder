import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/screen/common/dialog/warning_dialog2.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/provider/cart/cart_provider.dart';
import '../../../core/utils/utils.dart';
import '../../../core/viewobject/cart_product.dart';
import '../../../core/viewobject/common/master_value_holder.dart';
import '../../common/button_widgets.dart';
import '../../common/dialog/warning_dialog_view.dart';
import '../../common/rectangle_card.dart';
import '../widgets/cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, r});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool isFirst = false;

  var selectedPageNumber = 1;
  late CartProvider cartProvider;
  TextEditingController searchController = TextEditingController();
  MasterValueHolder? valueHolder;

  String buttonName = "Order";
  Map<String, List<CartProduct>> cartProductList = {};

  @override
  Widget build(BuildContext context) {
    valueHolder = Provider.of<MasterValueHolder>(context);

    cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: MasterColors.grey,
      appBar: AppBar(
        toolbarHeight: 60,
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
        title: Text(
          'cart'.tr,
          style: TextStyle(color: Color.fromRGBO(254, 242, 0, 1)),
        ),
        actions: [
          InkWell(
            onTap: () {
              cartProvider.clearAllFromDatabase();
            },
            child: Container(
              padding: EdgeInsets.only(
                  right: Dimesion.height20, top: Dimesion.height10),
              child: Text(
                'clear_all'.tr,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Color.fromRGBO(254, 242, 0, 1),
                    fontWeight: FontWeight.normal),
              ),
            ),
          )
        ],
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimesion.width20, vertical: Dimesion.width10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Consumer<CartProvider>(
                      builder: (BuildContext context, CartProvider pro,
                          Widget? child) {
                        return Column(
                          children: [
                            MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: pro.dataLength,
                                itemBuilder: (context, index) {
                                  return CartItemWidget(
                                    cartProduct: pro.getCartDataList()[index],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: Dimesion.height10,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Consumer<CartProvider>(
          builder: (BuildContext context, CartProvider pro, Widget? child) {
        List<CartProduct> cardProductList = pro.cardProductList;
        if (!isFirst) {
          if (cardProductList.isNotEmpty) {
            pro.totalCost = 0;
            for (CartProduct cart in cardProductList) {
              pro.totalCost += cart.cost!;
            }
          }
        }
        isFirst = true;
        return Container(
          margin: EdgeInsets.only(bottom: Dimesion.height40),
          padding: EdgeInsets.symmetric(
            horizontal: Dimesion.width20,
          ),
          height: Dimesion.height40 * 2,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "total".tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimesion.font16,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  '${NumberFormat("#,##0", "en_Us").format(pro.totalCost)} MMK',
                  style: TextStyle(
                    color: MasterColors.mainColor,
                    fontSize: Dimesion.font16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimesion.height15,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  if (!pro.hasData) {
                    callWarningDialog(
                        context, 'Warning Dialog no cart data'.tr);
                  } else if (!Utils.isLogined(valueHolder)) {
                    callWarningDialog2(context, 'Warning dialog no login'.tr);
                  } else if (pro.hasData && Utils.isLogined(valueHolder)) {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.selectRegion,
                    );
                  }
                },
                child: BigButton(
                  text: "checkout".tr,
                ),
              ),
            ),
          ]),
        );
      }),
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

  dynamic callWarningDialog2(BuildContext context, String text) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return WarningDialog2(
          message: text.tr,
          onPressed: () {},
        );
      },
    );
  }

  Widget orderButton(
      {required String text,
      required Color color,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: RectangleCard(
        widget: Container(
          alignment: Alignment.center,
          height: Dimesion.height40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(Dimesion.radius5),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimesion.font12,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ),
    );
  }
}
