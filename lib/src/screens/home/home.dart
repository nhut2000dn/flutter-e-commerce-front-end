import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_novel/models/category.dart';
import 'package:my_novel/models/product.dart';
import 'package:my_novel/models/slideshow.dart';
import 'components/body.dart';
import '../../../../size_config.dart';

class HomeWidget extends StatelessWidget {
  final List<Product> popularProducts;
  final List<Category> categories;
  final List<SlideshowModel> slideshows;
  const HomeWidget({
    Key? key,
    required this.popularProducts,
    required this.categories,
    required this.slideshows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    slideshows.sort((a, b) {
      return a.index!.compareTo(b.index!);
    });

    return Scaffold(
      body: Body(
        categories: categories,
        popularProducts: popularProducts,
      ),
    );
  }
}
