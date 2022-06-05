import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_novel/models/cart.dart';
import 'package:my_novel/models/item.dart';
import 'package:my_novel/models/product.dart';
import 'package:my_novel/providers/cart_provider.dart';

import '../../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  List<Product> productsfavourited = [];
  Body({Key? key, required this.productsfavourited}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: widget.productsfavourited.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.productsfavourited[index].id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                widget.productsfavourited.removeAt(index);
              });
            },
            background: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(product: widget.productsfavourited[index]),
          ),
        ),
      ),
    );
  }
}
