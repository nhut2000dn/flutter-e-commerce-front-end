import 'package:flutter/material.dart';
import 'package:my_novel/src/screens/cart/cart_screen.dart';

import '../../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              debugPrint('Click');
              Navigator.of(context).pushNamed(
                '/Search',
              );
            },
            child: const SearchField(),
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.of(context).pushNamed(
              '/Cart',
            ),
          ),
        ],
      ),
    );
  }
}
