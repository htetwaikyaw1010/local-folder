import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../config/master_config.dart';
import '../../../core/provider/product/feature_product_provider.dart';
import '../../../core/provider/product/product_by_brand_provider.dart';
import '../../../core/repository/product_repository.dart';
import '../../../core/utils/utils.dart';
import '../../../core/viewobject/holder/item_entry_parameter_holder.dart';
import '../widgets/filter_product/product_filter_bottom_sheet.dart';
import '../widgets/product_vertical_list_item.dart';

class ProductsByBrandView extends StatefulWidget {
  const ProductsByBrandView(
      {super.key,
      required this.title,
      required this.id,
      required this.catID,
      required this.name});
  final String title;
  final String id;
  final String catID;
  final String name;

  @override
  State<ProductsByBrandView> createState() => _ProductsByBrandViewState();
}

class _ProductsByBrandViewState extends State<ProductsByBrandView> {
  var selectedPageNumber = 1;
  int counter = 1;

  late ProductByBrandProvider provider;
  TextEditingController searchController = TextEditingController();

  late ScrollController scrollController;

  String cpuID = 'CPU';
  String generationID = 'Generation';

  String min = '';
  String max = '';
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        provider.loadNextProductListByBrand(
            brandID: widget.name,
            catID: widget.catID,
            reset: true,
            requestBodyHolder: ProductParameterHolder(productID: '1'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProductRepository productRepository =
        Provider.of<ProductRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductByBrandProvider>(
          lazy: false,
          create: (BuildContext context) {
            provider = ProductByBrandProvider(repo: productRepository);
            provider.loadProductListByBrand(
              brandID: widget.id,
              catID: widget.catID,
            );
            return provider;
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
          centerTitle: false,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(254, 242, 0, 1),
              size: Dimesion.height24,
            ),
          ),
          elevation: 0,
          backgroundColor: MasterColors.mainColor,
          title: Text(
            '${widget.title} Products',
          ),
          iconTheme: IconThemeData(color: MasterColors.textColor2),
          titleTextStyle: const TextStyle(
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.w600,
              fontSize: 24),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
            child: Consumer2<ProductByBrandProvider, FavouriteProductProvider>(
              builder: (BuildContext context, ProductByBrandProvider pro,
                  FavouriteProductProvider favProvider, Widget? child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: Dimesion.height20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Dimesion.height150,
                            child: Text(
                              '${pro.hasData ? pro.dataLength : 0} products found',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Colors.black26,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                          InkWell(
                            child: SizedBox(
                              width: Dimesion.height20,
                              height: Dimesion.height10,
                              child: SvgPicture.asset(
                                "assets/images/icons/filter_icon.svg",
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet<Widget>(
                                enableDrag: true,
                                // isDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    ProductFilterBottomShetWiget(
                                  dataFn: (double start, double end,
                                      String generation, String cpu) {
                                    min = start.toString();
                                    max = end.toString();
                                    generationID = generation;
                                    cpuID = cpu;
                                    provider.filterProductListByBrand(
                                      min: min,
                                      max: max,
                                      generation: generationID,
                                      cpu: cpuID,
                                      brandID: widget.id,
                                      catID: widget.catID,
                                    );
                                    Navigator.pop(context);
                                  },
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
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimesion.height20,
                    ),
                    if (pro.hasData)
                      MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.9,
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                    Radius.circular(Dimesion.height8),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
