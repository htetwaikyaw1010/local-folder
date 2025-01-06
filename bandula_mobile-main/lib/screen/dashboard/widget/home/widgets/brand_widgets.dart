import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../../config/master_colors.dart';
import '../../../../../core/constant/dimesions.dart';
import '../../../../../core/provider/brand/brand_provider.dart';

class BrandWidgets extends StatefulWidget {
  const BrandWidgets({Key? key}) : super(key: key);

  @override
  State<BrandWidgets> createState() => _BrandWidgetsState();
}

class _BrandWidgetsState extends State<BrandWidgets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BrandProvier>(
        builder: (BuildContext context, BrandProvier pro, Widget? child) {
      return Column(
        children: [
          SizedBox(
              height: Dimesion.height40 * 2,
              child: pro.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: MasterColors.mainColor),
                    )
                  : pro.hasData
                      ? MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: pro.dataLength,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      // Get.to(
                                      //   () => ProductScreen(
                                      //         id: controller.brands[index].id,
                                      //         isCat: false,
                                      //       ),
                                      //   transition: Transition.rightToLeftWithFade,
                                      //   duration: Duration(milliseconds: 200))
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Card(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: Dimesion.width10),
                                          // shape: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.circular(100)),
                                          color: Colors.white,
                                          borderOnForeground: true,
                                          // shadowColor: shadow,
                                          elevation: 3,
                                          child: Container(
                                            height: Dimesion.height40 * 1.2,
                                            width: Dimesion.height40 * 1.2,
                                            padding: const EdgeInsets.all(2),
                                            child: CachedNetworkImage(
                                                imageUrl:
                                                    '${pro.getListIndexOf(index,false).photo}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: MasterColors
                                                            .mainColor,
                                                      ),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                            'assets/noimg.png'),
                                                imageBuilder: (context, img) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: img,
                                                            fit: BoxFit
                                                                .contain)),
                                                  );
                                                }),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimesion.height10,
                                        ),
                                        SizedBox(
                                          width: Dimesion.height40 * 1.3,
                                          child: Text(
                                              pro.getListIndexOf(index,false).name!,
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!),
                                        )
                                      ],
                                    ));
                              }))
                      : Container(
                          alignment: Alignment.center,
                          height: Dimesion.height40 * 2,
                          child: const Text(
                            'There is No Brand',
                            // style: normalText,
                          ),
                        )),
        ],
      );
    });
  }
}
