import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bandula/config/master_colors.dart';
import 'package:bandula/core/constant/dimesions.dart';
import 'package:bandula/core/viewobject/blog.dart';

class NewsDetailScreen extends StatelessWidget {
  final Blog blog;
  const NewsDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: CachedNetworkImage(
                  imageUrl: blog.photo ?? "",
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
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: img, fit: BoxFit.cover),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 12,
              ),
              child: Text(
                blog.title ?? "",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: MasterColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Subtitle :",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 10,
              ),
              child: Text(
                blog.subTitle ?? "",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: MasterColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                blog.description ?? "",
                style: TextStyle(
                    color: MasterColors.black, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
