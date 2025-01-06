import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/product/product_search_provider.dart';
import 'package:bandula/core/provider/serch_keyword/searh_keyword_provider.dart';
import 'package:bandula/core/repository/product_repository.dart';
import 'package:bandula/core/repository/search_keyword_repository.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../core/provider/product/feature_product_provider.dart';
import '../../../core/utils/utils.dart';
import '../widgets/filter_product/product_filter_bottom_sheet.dart';
import '../widgets/product_search/product_search_textfield.dart';
import '../widgets/product_vertical_list_item.dart';

class ProductsSearchScreen extends StatefulWidget {
  const ProductsSearchScreen({
    super.key,
  });
  @override
  State<ProductsSearchScreen> createState() => _ProductsSearchScreenState();
}

class _ProductsSearchScreenState extends State<ProductsSearchScreen> {
  TextEditingController searchController = TextEditingController();
  late ProductSearchProvider searchProvider;

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
        searchProvider.nextFilterProductList(
            min: min, max: max, generation: generationID, cpu: cpuID);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProductRepository repository =
        Provider.of<ProductRepository>(context);
    final SearchKeywordRepository searchKeywordRepository =
        Provider.of<SearchKeywordRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductSearchProvider>(
            lazy: false,
            create: (BuildContext context) {
              searchProvider = ProductSearchProvider(repo: repository);
              return searchProvider;
            }),
        ChangeNotifierProvider<FavouriteProductProvider>(
            lazy: false,
            create: (BuildContext context) {
              FavouriteProductProvider orderProvier =
                  FavouriteProductProvider(repo: repository);
              return orderProvier;
            }),
        ChangeNotifierProvider<SearchKeywordProvider>(
          lazy: false,
          create: (BuildContext context) {
            SearchKeywordProvider orderProvier =
                SearchKeywordProvider(repo: searchKeywordRepository);
            return orderProvier;
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: MasterColors.grey,
        appBar: AppBar(
          toolbarHeight: 60,
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
          title: const Text(
            'Search',
          ),
          iconTheme: IconThemeData(color: MasterColors.textColor2),
          titleTextStyle: TextStyle(
              color: Color.fromRGBO(254, 242, 0, 1),
              fontSize: 24,
              fontWeight: FontWeight.w600),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProductSearchTextFieldWidget(
                  searchController: searchController,
                ),
                Consumer2<ProductSearchProvider, FavouriteProductProvider>(
                  builder: (BuildContext context, ProductSearchProvider pro,
                      FavouriteProductProvider favProvider, Widget? child) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: Dimesion.height10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: Dimesion.height10),
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
                                              fontWeight: FontWeight.normal),
                                    )),
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
                                        dataFn: (double start,
                                            double end,
                                            String generation,
                                            String cpu) async {
                                          min = start.toString();
                                          max = end.toString();
                                          generationID = generation;
                                          cpuID = cpu;
                                          searchProvider.filterProductList(
                                            min: min,
                                            max: max,
                                            generation: generationID,
                                            cpu: cpuID,
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
                            height: Dimesion.height15,
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
                                        mainAxisExtent:
                                            Dimesion.height40 * 7.6),
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
                          SizedBox(
                            height: Dimesion.height10,
                          ),
                        ],
                      ),
                    );
                  },
                )
                // Expanded(
                //   child: Container(
                //     margin: EdgeInsets.symmetric(
                //         horizontal: Dimesion.height10,
                //         vertical: Dimesion.height10),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(Dimesion.height8)),
                //     child: MediaQuery.removePadding(
                //       context: context,
                //       removeTop: true,
                //       child: ListView.builder(
                //           physics: const BouncingScrollPhysics(),
                //           itemCount: 5,
                //           itemBuilder: (context, index) {
                //             return GestureDetector(
                //               onTap: () {},
                //               child: Container(
                //                 padding: EdgeInsets.symmetric(
                //                     vertical: Dimesion.height10,
                //                     horizontal: Dimesion.height20),
                //                 decoration: BoxDecoration(
                //                   color: MasterColors.appBackgroundColor,
                //                 ),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   children: [
                //                     Icon(
                //                       Icons.turn_sharp_right_rounded,
                //                       color: MasterColors.textColor4,
                //                     ),
                //                     Container(
                //                       width: Dimesion.height200,
                //                       padding: EdgeInsets.symmetric(
                //                           horizontal: Dimesion.height20),
                //                       child: Text(
                //                         "Nike",
                //                         maxLines: 1,
                //                         overflow: TextOverflow.ellipsis,
                //                         style: TextStyle(
                //                             fontSize: Dimesion.font12,
                //                             color: MasterColors.textColor4,
                //                             fontWeight: FontWeight.bold),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             );
                //           }),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
