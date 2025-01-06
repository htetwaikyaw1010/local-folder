import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/cart/cart_provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/provider/product/product_details_provider.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/db/common/master_shared_preferences.dart';
import '../../../core/provider/product/feature_product_provider.dart';
import '../../../core/repository/product_repository.dart';
import '../../../core/utils/utils.dart';
import '../../../core/viewobject/cart_product.dart';
import '../../../core/viewobject/holder/request_path_holder.dart';
import '../../../core/viewobject/product.dart';
import '../../cart/widgets/cart_bottom_sheet.dart';
import '../widgets/banner.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productID});
  final String productID;
  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  void initState() {
    super.initState();
    checkFCM();
  }

  checkFCM() async {
    print(await MasterSharedPreferences.instance.getLoginFcmToken());
  }

  var selectedPageNumber = 1;
  int counter = 1;
  late ProductDetailProvider productProvider;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ProductRepository productRepository =
        Provider.of<ProductRepository>(context);
    final CartProvider cartProvider = Provider.of<CartProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductDetailProvider>(
          lazy: false,
          create: (BuildContext context) {
            productProvider = ProductDetailProvider(repo: productRepository);
            productProvider.loadData(
                requestPathHolder: RequestPathHolder(itemId: widget.productID));

            return productProvider;
          },
        ),
        ChangeNotifierProvider<FavouriteProductProvider>(
          lazy: false,
          create: (BuildContext context) {
            FavouriteProductProvider favouriteProductProvider =
                FavouriteProductProvider(repo: productRepository);
            favouriteProductProvider.loadDataListFromDatabase();
            return favouriteProductProvider;
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: MasterColors.grey,
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: false,
          elevation: 0,
          backgroundColor: MasterColors.mainColor,
          title: Text(
            'product_detail'.tr,
            style: TextStyle(
              color: Color.fromRGBO(254, 242, 0, 1),
            ),
          ),
          actions: [
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
                    width: Dimesion.height40,
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
                              cartItemCount > 9
                                  ? '9+'
                                  : cartItemCount.toString(),
                              // textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Color.fromRGBO(254, 242, 0, 1),
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
        body: Consumer2<ProductDetailProvider, FavouriteProductProvider>(
            builder: (BuildContext context, ProductDetailProvider pro,
                FavouriteProductProvider favProvider, Widget? child) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: pro.hasData
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimesion.width20,
                              vertical: Dimesion.width10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ProductImages(
                                images: pro.data.data!.photos!,
                              ),
                              Text(
                                pro.data.data!.brandName ?? '',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      color: MasterColors.mainColor,
                                    ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: Dimesion.height10),
                                      width: Dimesion.height200,
                                      child: Text(
                                        pro.data.data!.name ?? '',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              color: MasterColors.black,
                                            ),
                                      )),
                                  InkWell(
                                    onTap: () async {
                                      if (Utils.isFavouritedProduct(
                                          pro.data.data!,
                                          favProvider.productList.data ?? [])) {
                                        await favProvider
                                            .deleteFromDatabase(pro.data.data!);
                                      } else {
                                        await favProvider
                                            .addToDatabase(pro.data.data!);
                                      }
                                      // await favProvider.loadDataListFromDatabase();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: Dimesion.height10),
                                      alignment: Alignment.center,
                                      child: Utils.isFavouritedProduct(
                                              pro.data.data!,
                                              favProvider.productList.data ??
                                                  [])
                                          ? Icon(
                                              Icons.favorite,
                                              color: MasterColors.black,
                                            )
                                          : Icon(
                                              Icons.favorite_outline,
                                              color: MasterColors.buttonColor,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                width: 250,
                                child: Text(
                                  "${pro.data.data!.color ?? ''} Color",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.redAccent),
                                ),
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin:
                                      EdgeInsets.only(top: Dimesion.height4),
                                  child: Text(
                                    '${NumberFormat("#,##0", "en_Us").format(int.parse(pro.data.data!.price!))} MMK',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          color: MasterColors.mainColor,
                                        ),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: Dimesion.height5),
                                    decoration: BoxDecoration(
                                      color: MasterColors.mainColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimesion.height10,
                                        vertical: Dimesion.height2),
                                    child: Text(
                                      pro.data.data!.categoryName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color:
                                                Color.fromRGBO(254, 242, 0, 1),
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimesion.height10,
                              ),
                              SizedBox(
                                height: Dimesion.height10,
                              ),
                              Text("Stock: ${pro.data.data!.stock}"),
                              SizedBox(
                                height: Dimesion.height10,
                              ),
                              SizedBox(
                                height: Dimesion.height10,
                              ),
                              const Divider(
                                color: Colors.black26,
                                height: 1,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: Dimesion.height10),
                                width: Dimesion.height100,
                                child: Text(
                                  'description'.tr,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        color: MasterColors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimesion.height10),
                                child: Text(
                                  pro.data.data!.detail ?? '',
                                  softWrap: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        color: MasterColors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              )
                            ],
                          ),
                        )
                      : Container(),
                ),
              ),
              pro.data.data == null
                  ? Container()
                  : Container(
                      height: 80,
                      color: Color.fromRGBO(254, 242, 0, 1),
                      child: InkWell(
                        onTap: pro.data.data == null
                            ? () {}
                            : () {
                                Product product = pro.data.data!;
                                if (product.stock! > 0) {
                                  showModalBottomSheet<Widget>(
                                    enableDrag: true,
                                    // isDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AddToCardBottomShetWiget(
                                      cartProvider: cartProvider,
                                      cartProduct: CartProduct(
                                        product: product,
                                        quantity: 1,
                                        cost: double.parse(
                                          product.price.toString(),
                                        ),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    shape: const RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0),
                                      ),
                                    ),
                                  );
                                }
                              },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: pro.data.data!.stock != 0
                                ? Colors.green
                                : Colors.black38,
                            border: Border.all(color: MasterColors.grey),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: Dimesion.height10,
                            horizontal: Dimesion.height15,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            'add_to_cart'.tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: Color.fromRGBO(254, 242, 0, 1),
                                ),
                          ),
                        ),
                      ),
                    )
            ],
          );
        }),
      ),
    );
  }
}
