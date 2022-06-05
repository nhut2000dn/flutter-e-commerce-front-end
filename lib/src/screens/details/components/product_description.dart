import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_novel/blocs/authentication_bloc.dart';
import 'package:my_novel/events/authentication_event.dart';
import 'package:my_novel/models/product.dart';
import 'package:my_novel/services/product_service.dart';
import 'package:my_novel/services/user_service.dart';
import 'package:my_novel/services/users_products_service.dart';
import 'package:my_novel/states/authentication_state.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription(
      {Key? key,
      required this.product,
      this.pressOnSeeMore,
      required this.isLoading})
      : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;
  final VoidCallback isLoading;
  @override
  State<StatefulWidget> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  final UserService _userService = UserService();
  final UsersProductsService _usersProductsService = UsersProductsService();
  final ProductService _productService = ProductService();
  late String userId;
  late bool isFollowed = false;

  checkFollowed() async {
    String placeholderUserId = await _userService.getUserId();
    if (await _usersProductsService.checkIsFavourite(
        placeholderUserId, widget.product.id)) {
      setState(() {
        isFollowed = true;
        userId = placeholderUserId;
      });
    }
    setState(() {
      userId = placeholderUserId;
    });
  }

  followProduct() async {
    widget.isLoading();
    String status = await _usersProductsService.createUserProduct(
      userId,
      widget.product.id,
    );

    debugPrint(status.toString());

    if (status == 'created') {
      Fluttertoast.showToast(
        msg: "Follow Succesfull",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      bool checkUpadte =
          await _productService.updateFavouriteIncrement(widget.product.id);
      if (checkUpadte) {
        setState(() {
          isFollowed = true;
        });
        widget.isLoading();
      }
    } else if (status == 'deleted') {
      Fluttertoast.showToast(
        msg: "UnFollow Succesfull",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      bool checkUpadte =
          await _productService.updateFavouriteDecrement(widget.product.id);
      if (checkUpadte) {
        setState(() {
          isFollowed = false;
        });
        widget.isLoading();
      }
    } else {
      Fluttertoast.showToast(
        msg: "Fail",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    BlocProvider.of<AuthenticationBloc>(context).add(
      AuthenticationEventFetchData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            widget.product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authenticationState) {
            if (authenticationState is AuthenticationStateSuccess) {
              checkFollowed();
              return InkWell(
                onTap: () {
                  followProduct();
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    width: getProportionateScreenWidth(64),
                    decoration: BoxDecoration(
                      color: isFollowed
                          ? const Color(0xFFFFE6E6)
                          : const Color(0xFFF5F6F9),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: isFollowed
                          ? const Color(0xFFFF4848)
                          : const Color(0xFFDBDEE4),
                      height: getProportionateScreenWidth(16),
                    ),
                  ),
                ),
              );
            } else if (authenticationState is AuthenticationStateFailure) {
              return Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Login');
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                      width: getProportionateScreenWidth(64),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: const Color(0xFFDBDEE4),
                        height: getProportionateScreenWidth(16),
                      ),
                    ),
                  ),
                ),
                // child: TextButton(
                //   onPressed: () {
                //     Navigator.of(context)
                //         .pushNamed('/Login');
                //   },
                //   child: const Text('Login'),
                // ),
              );
            }
            return Center();
          },
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            widget.product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: const [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
