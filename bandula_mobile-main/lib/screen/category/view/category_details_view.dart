import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/viewobject/holder/request_path_holder.dart';
import '../../../../config/master_colors.dart';
import '../../../../core/constant/dimesions.dart';
import '../../../../core/provider/brand/brand_provider.dart';
import '../../../config/master_config.dart';
import '../../../core/repository/brand_repository.dart';
import '../../../core/utils/utils.dart';
import '../../brand/widgets/brand_vertical_list_item.dart';

class CategoryDetailsView extends StatefulWidget {
  const CategoryDetailsView({super.key, required this.title, required this.id});
  final String title;
  final String id;

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  var selectedPageNumber = 1;
  int counter = 1;
  late BrandProvier brandProvier;

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BrandRepository brandRepository =
        Provider.of<BrandRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BrandProvier>(
            lazy: false,
            create: (BuildContext context) {
              brandProvier = BrandProvier(repo: brandRepository);
              brandProvier.loadDataList(
                  requestPathHolder: RequestPathHolder(itemId: widget.id));
              return brandProvier;
            }),
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
            widget.title,
          ),
          titleTextStyle: const TextStyle(
              fontFamily: MasterConfig.default_font_family,
              fontWeight: FontWeight.w600,
              fontSize: 24),
          iconTheme: IconThemeData(color: MasterColors.textColor2),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimesion.height10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(vertical: Dimesion.height10),
                        child: Text(
                          "choose_brand".tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: MasterColors.black),
                        ),
                      ),
                      Consumer<BrandProvier>(
                        builder: (BuildContext context, BrandProvier pro,
                            Widget? child) {
                          return pro.isLoading
                              ? MediaQuery.removePadding(
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
                                                Dimesion.height40 * 4),
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.black12,
                                        highlightColor:
                                            Utils.isLightMode(context)
                                                ? Colors.white12
                                                : Colors.black54,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: MasterColors.black,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                Dimesion.height8,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : pro.hasData
                                  ? MediaQuery.removePadding(
                                      removeTop: true,
                                      context: context,
                                      child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.9,
                                          crossAxisSpacing: Dimesion.height20,
                                          mainAxisSpacing: Dimesion.height5,
                                          mainAxisExtent: Dimesion.height40 * 4,
                                        ),
                                        scrollDirection: Axis.vertical,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: pro.dataLength,
                                        itemBuilder: (context, index) {
                                          return BrandVarticalListItem(
                                            brand: pro.getListIndexOf(index,false),
                                            catID: pro
                                                .getListIndexOf(index,false)
                                                .id
                                                .toString(),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3),
                                      child: const Text("There is no brand !"),
                                    );
                        },
                      ),
                      SizedBox(
                        height: Dimesion.height10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
