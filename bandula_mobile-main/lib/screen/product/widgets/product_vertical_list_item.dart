import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/viewobject/cart_product.dart';
import 'package:bandula/core/viewobject/product.dart';
import '../../../config/master_colors.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/constant/dimesions.dart';
import '../../../core/provider/cart/cart_provider.dart';
import '../../../core/provider/product/feature_product_provider.dart';
import '../../../core/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../cart/widgets/cart_bottom_sheet.dart';

class ProductVarticalListItem extends StatelessWidget {
  const ProductVarticalListItem({
    Key? key,
    required this.product,
    this.isFav = false,
  }) : super(key: key);
  final Product product;
  final bool isFav;
  @override
  Widget build(BuildContext context) {
    final FavouriteProductProvider favouriteProductProvider =
        Provider.of<FavouriteProductProvider>(context);
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return InkWell(
      onTap: () {
        final ProductDetailsIntentHolder holder =
            ProductDetailsIntentHolder(product: Product(id: product.id));
        Navigator.pushNamed(context, RoutePaths.productDetails,
            arguments: holder);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              if (product.photos!.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                      color: MasterColors.grey,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    child: CachedNetworkImage(
                        imageUrl: product.photos![0],
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
                right: Dimesion.height10,
                child: Container(
                  decoration: BoxDecoration(
                    color: product.stock != 0
                        ? MasterColors.successColor
                        : MasterColors.mainColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimesion.height10,
                      vertical: Dimesion.height2),
                  child: Text(
                    product.stock != 0 ? 'Instock' : 'Out of Stock',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Color.fromRGBO(254, 242, 0, 1)),
                  ),
                ),
              ),
            ],
          ),
          // Expanded(
          //     child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: Dimesion.height10, left: Dimesion.height5),
                width: Dimesion.height100,
                height: Dimesion.height50,
                child: Text(
                  product.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: MasterColors.black,
                      ),
                ),
              ),
              InkWell(
                  onTap: () async {
                    if (isFav) {
                      await favouriteProductProvider
                          .deleteFromDatabase(product);
                    } else {
                      await favouriteProductProvider.addToDatabase(product);
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: Dimesion.height10),
                      alignment: Alignment.center,
                      child: isFav
                          ? Icon(
                              Icons.favorite,
                              color: MasterColors.black,
                            )
                          : Icon(
                              Icons.favorite_outline,
                              color: MasterColors.buttonColor,
                            ))),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                vertical: Dimesion.height6, horizontal: Dimesion.height5),
            child: Text(
                '${NumberFormat("#,##0", "en_Us").format(int.parse(product.price!))} MMK',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall!),
          ),
          Container(
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MasterColors.mainColor,
              border: Border.all(color: MasterColors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(
                vertical: Dimesion.height10, horizontal: Dimesion.height5),
            child: Text(
              product.brandName!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color.fromRGBO(254, 242, 0, 1),
                fontSize: 11,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (product.stock! > 0) {
                showModalBottomSheet<Widget>(
                  enableDrag: true,
                  // isDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AddToCardBottomShetWiget(
                      cartProvider: cartProvider,
                      cartProduct: CartProduct(
                          product: product,
                          quantity: 1,
                          cost: double.parse(product.price.toString()))),
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
                color: product.stock != 0
                    ? MasterColors.mainColor
                    : Colors.black38,
                border: Border.all(color: MasterColors.grey),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Text(
                'add_to_cart'.tr,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Color.fromRGBO(254, 242, 0, 1),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
