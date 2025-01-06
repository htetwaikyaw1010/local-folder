import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import '../../../config/master_colors.dart';
import '../../../core/constant/dimesions.dart';
import '../../../core/provider/product/feature_product_provider.dart';
import '../../../core/repository/product_repository.dart';
import '../widgets/product_vertical_list_item.dart';

class WishListProductScreen extends StatefulWidget {
  const WishListProductScreen({Key? key}) : super(key: key);

  @override
  State<WishListProductScreen> createState() => _WishListProductScreenState();
}

class _WishListProductScreenState extends State<WishListProductScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductRepository productRepository =
        Provider.of<ProductRepository>(context);
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<FavouriteProductProvider>(
            lazy: false,
            create: (BuildContext context) {
              FavouriteProductProvider provider =
                  FavouriteProductProvider(repo: productRepository);
              provider.loadDataListFromDatabase();
              return provider;
            }),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<FavouriteProductProvider>(builder: (BuildContext context,
            FavouriteProductProvider pro, Widget? child) {
          return pro.hasData
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimesion.width10,
                        vertical: Dimesion.height10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.9,
                                        crossAxisSpacing: Dimesion.height20,
                                        mainAxisSpacing: Dimesion.height5,
                                        mainAxisExtent:
                                            Dimesion.height40 * 7.6),
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: pro.dataLength,
                                itemBuilder: (context, index) {
                                  return ProductVarticalListItem(
                                    product: pro.getListIndexOf(index,false),
                                    isFav: true,
                                  );
                                })),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text('no_wishlist'.tr,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: MasterColors.black,
                          )),
                );
        }),
      ),
    );
  }
}
