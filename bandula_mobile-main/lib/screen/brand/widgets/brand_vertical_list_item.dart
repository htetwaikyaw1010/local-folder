import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bandula/core/viewobject/brand.dart';
import 'package:bandula/core/viewobject/holder/intent_holder/products_by_brand_intent_holder.dart';
import '../../../config/master_colors.dart';
import '../../../config/route/route_paths.dart';
import '../../../core/constant/dimesions.dart';

class BrandVarticalListItem extends StatelessWidget {
  const BrandVarticalListItem({
    Key? key,
    required this.brand,
    required this.catID,
  }) : super(key: key);
  final Brand brand;
  final String catID;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final ProductsByBrandIntentHolder holder = ProductsByBrandIntentHolder(
            title: brand.name!, id: brand.name.toString(), catID: catID);
        Navigator.pushNamed(context, RoutePaths.productsByBrand,
            arguments: holder);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: Dimesion.height60 * 1.8,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: CachedNetworkImage(
                  imageUrl: brand.photo!,
                  height: Dimesion.height60 * 1.8,
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
                      margin:
                          EdgeInsets.symmetric(horizontal: Dimesion.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimesion.radius15 / 2),
                          image:
                              DecorationImage(image: img, fit: BoxFit.cover)),
                    );
                  }),
            ),
          ),
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: MasterColors.mainColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: Dimesion.height10, horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      brand.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Color.fromRGBO(254, 242, 0, 1)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
