import 'package:flutter/material.dart';
import 'package:my_novel/models/cart.dart';
import 'package:my_novel/models/product.dart';
import 'package:my_novel/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class favouriteScreen extends StatefulWidget {
  static String routeName = "/cart";
  List<Product> productsfavourited = [];

  favouriteScreen({
    Key? key,
    required this.productsfavourited,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _favouriteScreenState();
}

class _favouriteScreenState extends State<favouriteScreen> {
  late CartProvider _cartProvider;
  @override
  void initState() {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(
        productsfavourited: widget.productsfavourited,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          const Text(
            "Your Favourite Product",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${_cartProvider.getTotalAmount()} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
