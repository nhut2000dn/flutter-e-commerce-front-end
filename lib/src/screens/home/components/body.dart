import 'package:flutter/material.dart';
import 'package:my_novel/models/category.dart';
import 'package:my_novel/models/product.dart';

import '../../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  List<Product> popularProducts;
  List<Category> categories;
  Body({
    Key? key,
    required this.popularProducts,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(),
            Categories(
              categories: categories,
            ),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(
              products: popularProducts,
            ),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
