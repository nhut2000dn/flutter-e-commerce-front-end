import 'package:flutter/material.dart';
import 'package:my_novel/components/rounded_icon_btn.dart';
import 'package:my_novel/models/product.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
    required this.onValueChanged,
  }) : super(key: key);

  final Product product;
  final Function(int quantily, String color) onValueChanged;

  @override
  State<StatefulWidget> createState() => _ColorDotsState();
}

late int selectedColorIndex;
late int quantily;

class _ColorDotsState extends State<ColorDots> {
  @override
  void initState() {
    selectedColorIndex = 0;
    quantily = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> colors = widget.product.colors.split(';');
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            colors.length,
            (index) => InkWell(
              child: ColorDot(
                colorString: colors[index],
                index: index,
              ),
              onTap: () {
                setState(() {
                  selectedColorIndex = index;
                  widget.onValueChanged(quantily, colors[selectedColorIndex]);
                });
              },
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {
              setState(() {
                quantily--;
                widget.onValueChanged(quantily, colors[selectedColorIndex]);
              });
            },
          ),
          SizedBox(width: getProportionateScreenWidth(15)),
          Text(quantily.toString()),
          SizedBox(width: getProportionateScreenWidth(15)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              setState(() {
                quantily++;
                widget.onValueChanged(quantily, colors[selectedColorIndex]);
              });
            },
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.colorString,
    required this.index,
  }) : super(key: key);

  final String colorString;
  final int index;

  @override
  Widget build(BuildContext context) {
    late Color color;
    switch (colorString) {
      case 'red':
        color = Color(0xFFF6625E);
        break;
      case 'white':
        color = Colors.white;
        break;
      case 'black':
        color = Colors.black45;
        break;
      case 'silver':
        color = Color(0xFFe6e6e6);
        break;
      default:
    }
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
            color: selectedColorIndex == index
                ? kPrimaryColor
                : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
