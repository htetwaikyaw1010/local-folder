import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/provider/product/feature_product_provider.dart';
import 'package:bandula/core/provider/product/product_provider.dart';
import '../../../../../core/constant/dimesions.dart';
import '../../../config/master_colors.dart';
import '../../../core/utils/utils.dart';
import 'product_vertical_list_item.dart';

class LatestProducts extends StatefulWidget {
  const LatestProducts({Key? key}) : super(key: key);

  @override
  State<LatestProducts> createState() => _LatestProductsState();
}

class _LatestProductsState extends State<LatestProducts> {
  var selectedPageNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, FavouriteProductProvider>(
      builder: (BuildContext context, ProductProvider pro,
          FavouriteProductProvider favProvider, Widget? child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: Dimesion.height10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: Dimesion.height10),
                child: Text(
                  "product".tr,
                  style: Theme.of(context).textTheme.titleLarge!,
                ),
              ),
              if (pro.hasData)
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: Dimesion.height20,
                        mainAxisSpacing: Dimesion.height10,
                        mainAxisExtent: Dimesion.height40 * 7.6),
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: pro.dataLength,
                    itemBuilder: (context, index) {
                      bool isFav = Utils.isFavouritedProduct(
                          pro.getListIndexOf(index,false),
                          favProvider.productList.data ?? []);
                      return ProductVarticalListItem(
                        product: pro.getListIndexOf(index,false),
                        isFav: isFav,
                      );
                    },
                  ),
                ),
              if (pro.isLoading)
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: Dimesion.height20,
                      mainAxisSpacing: Dimesion.height10,
                      mainAxisExtent: Dimesion.height60 * 2,
                    ),
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Utils.isLightMode(context)
                            ? Colors.white12
                            : Colors.black54,
                        child: Container(
                          decoration: BoxDecoration(
                            color: MasterColors.black,
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimesion.height8)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              SizedBox(
                height: Dimesion.height10,
              ),
            ],
          ),
        );
      },
    );
  }
}
