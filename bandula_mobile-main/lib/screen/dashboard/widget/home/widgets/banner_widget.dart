import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../config/master_colors.dart';
import '../../../../../core/constant/dimesions.dart';
import '../../../../../core/provider/banner/banner_provider.dart';
import '../../../../../core/utils/utils.dart';

class BannerImages extends StatefulWidget {
  const BannerImages({Key? key}) : super(key: key);

  @override
  State<BannerImages> createState() => _BannerImagesState();
}

class _BannerImagesState extends State<BannerImages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BannerProvider>(
        builder: (BuildContext context, BannerProvider pro, Widget? child) {
      if (pro.hasData) {
        return SizedBox(
            height: Dimesion.height40 * 4.7,
            child: CarouselSlider.builder(
              slideBuilder: ((index) {
                return Column(
                  children: [
                    CachedNetworkImage(
                        imageUrl: '${pro.bannerList.data![index].image}',
                        height: Dimesion.height40 * 4,
                        width: Dimesion.height80 * 4,
                        placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: MasterColors.mainColor,
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/noimg.png'),
                        imageBuilder: (context, img) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimesion.width20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimesion.radius15 / 2),
                                image: DecorationImage(
                                    image: img, fit: BoxFit.cover)),
                          );
                        }),
                  ],
                );
              }),
              itemCount: pro.dataLength,
              unlimitedMode: true,
              enableAutoSlider: true,
              viewportFraction: 1,
              autoSliderDelay: const Duration(seconds: 4),
              autoSliderTransitionCurve: Curves.fastOutSlowIn,
              autoSliderTransitionTime: const Duration(seconds: 2),
            ));
      }
      if (pro.isLoading) {
        {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: Dimesion.height10),
              height: Dimesion.height40 * 4,
              width: Dimesion.height80 * 4,
              child: Shimmer.fromColors(
                  baseColor: Colors.black12,
                  highlightColor: Utils.isLightMode(context)
                      ? Colors.white12
                      : Colors.black54,
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      color: MasterColors.black,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimesion.height8)),
                    ),
                    child: Text(
                      'Test',
                      style: TextStyle(color: MasterColors.mainColor),
                    ),
                  )));
        }
      } else {
        return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: Dimesion.height10),
            height: Dimesion.height40 * 4,
            width: Dimesion.height80 * 4,
            child: const Text('No Data'));
      }
    });
  }
}
