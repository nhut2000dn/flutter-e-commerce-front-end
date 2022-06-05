import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:my_novel/components/default_button.dart';
import 'package:my_novel/models/item.dart';
import 'package:my_novel/models/product.dart';
import 'package:my_novel/providers/cart_provider.dart';
import 'package:my_novel/size_config.dart';
import 'package:provider/provider.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Product product;
  final VoidCallback isLoading;

  const Body({Key? key, required this.product, required this.isLoading})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late CartProvider _cartProvider;
  late CartItem? _cartItem;
  late int _isInCart;
  late String color;
  late int quantily;

  @override
  void initState() {
    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    color = widget.product.colors.split(';')[0];
    quantily = 1;
    super.initState();
  }

  int _checkItemisInCart() {
    _cartItem =
        _cartProvider.getSpecificItemFromCartProvider(widget.product.id);
    return _cartItem?.quantity ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    _isInCart = _checkItemisInCart();
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
                isLoading: () => widget.isLoading(),
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(
                      product: widget.product,
                      onValueChanged: (int quantilyVal, String colorVal) {
                        setState(() {
                          quantily = quantilyVal;
                          color = colorVal;
                        });
                      },
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: _isInCart != 0
                              ? null
                              : () {
                                  debugPrint('quantily: ' +
                                      quantily.toString() +
                                      ' color: ' +
                                      color);
                                  _cartProvider.addToCart(Item(
                                      widget.product.id,
                                      widget.product.title,
                                      color,
                                      widget.product.price,
                                      quantily,
                                      widget.product));
                                  _cartProvider.printCartValue();
                                },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
