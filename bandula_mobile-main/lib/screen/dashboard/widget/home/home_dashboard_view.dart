import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/repository/cateogry_repository.dart';
import 'package:bandula/core/repository/product_repository.dart';
import 'package:bandula/core/viewobject/holder/item_entry_parameter_holder.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/provider/banner/banner_provider.dart';
import '../../../../core/provider/cart/cart_provider.dart';
import '../../../../core/provider/category/category_provider.dart';
import '../../../../core/provider/product/feature_product_provider.dart';
import '../../../../core/provider/product/product_provider.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../../core/provider/brand/brand_provider.dart';
import '../../../../core/repository/banner_repository.dart';
import '../../../product/widgets/product_vertical_list.dart';
import 'widgets/banner_widget.dart';
import '../../../category/widgets/category_widgets.dart';
import 'widgets/home_search_header.dart';

class HomeDashboardViewWidget extends StatefulWidget {
  const HomeDashboardViewWidget({super.key});

  @override
  State<HomeDashboardViewWidget> createState() =>
      _HomeDashboardViewWidgetState();
}

class _HomeDashboardViewWidgetState extends State<HomeDashboardViewWidget> {
  late ScrollController scrollController;
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        productProvider.loadNextDataList(
            requestBodyHolder: ProductParameterHolder(productID: '1'));
      }
    });
  }

  var selectedPageNumber = 1;
  int counter = 1;
  late BannerProvider bannerProvider;
  late BrandProvier brandProvier;
  late CategoryProvider categoryProvider;
  late FavouriteProductProvider favouriteProductProvider;
  TextEditingController searchController = TextEditingController();

  late CartProvider cartProvider;
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BannerRepository bannerRepository =
        Provider.of<BannerRepository>(context);
    final CategoryRepository categoryRepository =
        Provider.of<CategoryRepository>(context);
    final ProductRepository productRepository =
        Provider.of<ProductRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
            lazy: false,
            create: (BuildContext context) {
              categoryProvider = CategoryProvider(repo: categoryRepository);
              categoryProvider.loadDataList();
              return categoryProvider;
            }),
        ChangeNotifierProvider<BannerProvider>(
            lazy: false,
            create: (BuildContext context) {
              bannerProvider = BannerProvider(repo: bannerRepository);
              bannerProvider.loadDataList();
              return bannerProvider;
            }),
        ChangeNotifierProvider<ProductProvider>(
            lazy: false,
            create: (BuildContext context) {
              productProvider = ProductProvider(repo: productRepository);
              productProvider.loadDataList();
              return productProvider;
            }),
        ChangeNotifierProvider<FavouriteProductProvider>(
            lazy: false,
            create: (BuildContext context) {
              favouriteProductProvider =
                  FavouriteProductProvider(repo: productRepository);
              favouriteProductProvider.loadDataListFromDatabase();
              return favouriteProductProvider;
            }),
      ],
      child: Scaffold(
        backgroundColor: MasterColors.grey,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
          child: RefreshIndicator(
            onRefresh: () async {
              await categoryProvider.loadDataList(reset: true);
              await bannerProvider.loadDataList(reset: true);
              await productProvider.loadDataList(reset: true);
              return await favouriteProductProvider.loadDataListFromDatabase(
                  reset: true);
            },
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: HomeSearchHeaderWidget(
                    searchController: searchController,
                  ),
                ),
                const SliverToBoxAdapter(child: BannerImages()),
                const SliverToBoxAdapter(child: CategoryWidgets()),
                const SliverToBoxAdapter(child: LatestProducts()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
