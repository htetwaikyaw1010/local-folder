import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bandula/config/master_colors.dart';
import 'package:bandula/core/constant/dimesions.dart';
import 'package:bandula/core/viewobject/blog.dart';
import 'package:bandula/screen/news/view/news_detail_screen.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    super.key,
    required this.blog,
    required this.isFav,
  });

  final Blog blog;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(
              blog: blog,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        //height: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromRGBO(254, 242, 0, 1),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 189,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
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
                          margin: const EdgeInsets.only(right: 15),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimesion.radius15 / 2),
                            image:
                                DecorationImage(image: img, fit: BoxFit.cover),
                          ),
                        );
                      }),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      blog.description ?? "",
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MasterColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
