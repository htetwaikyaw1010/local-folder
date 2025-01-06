import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import '../../../../../core/constant/dimesions.dart';
import '../../../config/master_colors.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({Key? key, required this.images}) : super(key: key);
  final List<dynamic> images;
  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: Dimesion.height40 * 7,
            child: CarouselSlider.builder(
              slideBuilder: ((index) {
                return Column(
                  children: [
                    SizedBox(
                      height: Dimesion.height40 * 6,
                      width: Dimesion.height80 * 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                            imageUrl: widget.images[index],
                            height: Dimesion.height60 * 2,
                            width: double.infinity,
                            placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: MasterColors.mainColor,
                                  ),
                                ),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/noimg.png'),
                            imageBuilder: (context, img) {
                              return GestureDetector(
                                onTap: () {
                                  print('image url is....${widget.images[index]}');
                                  final imageProvider = Image.network(widget.images[index]).image;
                                         
                                      showImageViewer(context, imageProvider,
                                          doubleTapZoomable: true,
                                          swipeDismissible: true,
                                          useSafeArea: false,
                                          closeButtonColor: Colors.black,
                                          backgroundColor: Colors.white,
                                          onViewerDismissed: () {});
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Dimesion.width20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimesion.radius15 / 2),
                                      image: DecorationImage(
                                          image: img, fit: BoxFit.cover)),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                );
              }),
              itemCount: widget.images.length,
              unlimitedMode: true,
              enableAutoSlider: false,
              viewportFraction: 1,
              autoSliderDelay: const Duration(seconds: 4),
              autoSliderTransitionCurve: Curves.fastOutSlowIn,
              autoSliderTransitionTime: const Duration(seconds: 2),
              slideIndicator: CircularSlideIndicator(
                  currentIndicatorColor: MasterColors.mainColor!,
                  indicatorBackgroundColor: Colors.grey),
            )),
      ],
    );
  }
}
