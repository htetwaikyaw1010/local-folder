import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:bandula/config/master_colors.dart';
import 'package:bandula/core/constant/dimesions.dart';
import 'package:bandula/core/provider/blog/blog_provider.dart';
import 'package:bandula/core/repository/blog_repository.dart';
import 'package:bandula/core/utils/utils.dart';
import 'package:bandula/core/viewobject/common/master_value_holder.dart';
import 'package:bandula/core/viewobject/holder/request_path_holder.dart';
import 'package:bandula/screen/news/widget/news_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final MasterValueHolder valueHolder =
        Provider.of<MasterValueHolder>(context);
    final BlogReposistory reposistory = Provider.of<BlogReposistory>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BlogProvider>(
          create: (context) {
            BlogProvider blogProvider = BlogProvider(repo: reposistory);
            blogProvider.loadDataList(
                requestPathHolder:
                    RequestPathHolder(headerToken: valueHolder.loginUserToken));
            return blogProvider;
          },
        )
      ],
      child: Builder(builder: (context) {
        return Consumer<BlogProvider>(
            builder: (_, BlogProvider pro, Widget? child) {
          if (pro.hasData) {
            return ListView.builder(
              itemCount: pro.dataLength,
              itemBuilder: (context, index) {
                return NewsWidget(
                  blog: pro.getListIndexOf(index,true),
                  isFav: true,
                );
              },
            );
          }
          if (pro.isLoading) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.black12,
                  highlightColor: Utils.isLightMode(context)
                      ? Colors.white12
                      : Colors.black54,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          height: 170,
                          decoration: BoxDecoration(
                            color: MasterColors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimesion.height8),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              height: 10,
                              decoration: BoxDecoration(
                                color: MasterColors.black,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Dimesion.height8),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              height: 120,
                              decoration: BoxDecoration(
                                color: MasterColors.black,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Dimesion.height8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimesion.height10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(child: Text('No Data')),
            );
          }
        });
      }),
    );
  }
}
