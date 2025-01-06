import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bandula/core/provider/product/product_search_provider.dart';
import '../../../../../config/master_colors.dart';
import '../../../../../core/constant/dimesions.dart';

class ProductSearchTextFieldWidget extends StatelessWidget {
  const ProductSearchTextFieldWidget(
      {super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final ProductSearchProvider provider =
        Provider.of<ProductSearchProvider>(context);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimesion.height8)),
      margin: EdgeInsets.symmetric(
          horizontal: Dimesion.height10, vertical: Dimesion.height10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        maxLines: 1,
        controller: searchController,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(Dimesion.height10),
          border: InputBorder.none,
          hintText: 'Search Product Name',
          hintStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.black38),
          suffixIcon: InkWell(
              child: Icon(
                Icons.search,
                color: MasterColors.black,
              ),
              onTap: () {
                if (searchController.text != '') {
                  provider.loadSearchProductList(
                      reset: true, keyword: searchController.text);
                }
              }),
        ),
      ),
    );
  }
}
