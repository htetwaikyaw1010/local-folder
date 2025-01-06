import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bandula/core/provider/category/category_provider.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import 'package:bandula/core/viewobject/holder/intent_holder/category_detail_intent_holder.dart';
import 'package:bandula/screen/category/widgets/all_category_widget.dart';
import '../../../config/master_colors.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/constant/dimesions.dart';
import '../../../core/utils/utils.dart';

class CategoryWidgets extends StatefulWidget {
  const CategoryWidgets({Key? key}) : super(key: key);

  @override
  State<CategoryWidgets> createState() => _CategoryWidgetsState();
}

class _CategoryWidgetsState extends State<CategoryWidgets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
        builder: (BuildContext context, CategoryProvider pro, Widget? child) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(
                    horizontal: Dimesion.height10, vertical: Dimesion.height5),
                child: Text(
                  "category".tr,
                  style: Theme.of(context).textTheme.titleLarge!,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AllCategoryWidget();
                      },
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "see_all".tr,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black.withOpacity(0.5),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimesion.height5),
            height: Dimesion.height40 * 2,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: pro.hasData
                    ? List.generate(
                        pro.isLoading ? 4 : pro.dataLength,
                        (index) => index < 5
                            ? CategoryButton(
                                ontap: () {
                                  final CategoryDetailIntentHolder holder =
                                      CategoryDetailIntentHolder(
                                          title:
                                              pro.getListIndexOf(index,false).name!,
                                          id: pro
                                              .getListIndexOf(index,false)
                                              .id
                                              .toString());
                                  Navigator.pushNamed(
                                      context, RoutePaths.categoryDetails,
                                      arguments: holder);
                                },
                                name: '${pro.getListIndexOf(index,false).name}',
                                iconString:
                                    pro.getListIndexOf(index,false).image ?? '',
                              )
                            : const SizedBox(),
                      )
                    : List.generate(
                        4,
                        (index) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimesion.height10),
                          width: Dimesion.height80 * 0.9,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Utils.isLightMode(context)
                                ? Colors.white12
                                : Colors.black54,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: MasterColors.black,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Dimesion.height8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      );
    });
  }
}

class CategoryButton extends StatelessWidget {
  final VoidCallback ontap;
  final String name;
  final String iconString;
  const CategoryButton(
      {super.key,
      required this.ontap,
      required this.name,
      required this.iconString});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
               color: Color.fromRGBO(254, 242, 0, 1),
               border: Border.all(color: Colors.yellow,width: 5)
            ),
            child: SizedBox(
              width: 30,
              height: 30,
              child: CachedNetworkImage(
                // memCacheWidth: 100,
                imageUrl: iconString,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Image.asset(
                  'assets/images/noimg.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(
            top: 3,
          ),
          child: SizedBox(
            child: Text(
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MasterColors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        )
      ],
    );
  }
}
