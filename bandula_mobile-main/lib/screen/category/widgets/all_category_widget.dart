import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bandula/config/master_colors.dart';
import 'package:bandula/core/constant/dimesions.dart';
import 'package:bandula/core/utils/utils.dart';

import '../../../config/route/route_paths.dart';
import '../../../core/provider/category/category_provider.dart';
import '../../../core/repository/cateogry_repository.dart';
import '../../../core/viewobject/holder/intent_holder/category_detail_intent_holder.dart';

// ignore: must_be_immutable
class AllCategoryWidget extends StatelessWidget {
  AllCategoryWidget({super.key});
  late CategoryProvider categoryProvider;

  @override
  Widget build(BuildContext context) {
    final CategoryRepository categoryRepository =
        Provider.of<CategoryRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Category",
          style: TextStyle(
            color: Color.fromRGBO(254, 242, 0, 1),
          ),
        ),
        elevation: 0.2,
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<CategoryProvider>(
        lazy: false,
        create: (BuildContext context) {
          categoryProvider = CategoryProvider(repo: categoryRepository);
          categoryProvider.loadDataList();
          return categoryProvider;
        },
        child: Consumer<CategoryProvider>(
          builder: (BuildContext context, CategoryProvider pro, Widget? child) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: pro.dataLength,
              itemBuilder: (context, index) {
                return pro.hasData
                    ? GestureDetector(
                        onTap: () {
                          final CategoryDetailIntentHolder holder =
                              CategoryDetailIntentHolder(
                                  title: pro.getListIndexOf(index,false).name!,
                                  id: pro.getListIndexOf(index,false).id.toString());
                          Navigator.pushNamed(
                              context, RoutePaths.categoryDetails,
                              arguments: holder);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${pro.getListIndexOf(index,false).image}',
                                    height: Dimesion.height40 * 4,
                                    width: Dimesion.height80 * 2.0,
                                    errorWidget: (context, url, error) =>
                                        Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 40,
                                      ),
                                      child: Image.asset(
                                          'assets/images/noimg.png'),
                                    ),
                                    imageBuilder: (context, img) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: Dimesion.width20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimesion.radius15 / 2),
                                          image: DecorationImage(
                                            image: img,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: Dimesion.height30,
                                  bottom: Dimesion.height20,
                                  child: Align(
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: MasterColors.mainColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      width: Dimesion.height50 * 2,
                                      height: Dimesion.height30,
                                      child: Text(
                                        '${pro.getListIndexOf(index,false).name}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Color.fromRGBO(
                                                    254, 242, 0, 1)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimesion.height10),
                        width: Dimesion.height80 * 2.5,
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Utils.isLightMode(context)
                              ? Colors.white12
                              : Colors.black54,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: MasterColors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(Dimesion.height8),
                              ),
                            ),
                          ),
                        ),
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
