import 'package:flutter/material.dart';
import 'package:bandula/core/provider/language/app_localization_provider.dart';
import '../../../../../config/master_colors.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/constant/dimesions.dart';

class HomeSearchHeaderWidget extends StatelessWidget {
  const HomeSearchHeaderWidget({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimesion.height8)),
      margin: EdgeInsets.symmetric(
          horizontal: Dimesion.height10, vertical: Dimesion.height10),
      child: TextField(
        readOnly: false,
        autofocus: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        maxLines: null,
        controller: searchController,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: MasterColors.black),
        decoration: InputDecoration(
          fillColor: Color.fromRGBO(254, 242, 0, 1),
          contentPadding: EdgeInsets.all(Dimesion.height10),
          border: InputBorder.none,
          hintText: 'search_product'.tr,
          hintStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.black38),
          suffixIcon: InkWell(
              child: Icon(
                Icons.search,
                color: MasterColors.mainColor,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutePaths.productSearch,
                );
              }),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            RoutePaths.productSearch,
          );
        },
      ),
    );
  }
}
