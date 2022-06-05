import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_novel/components/custom_surfix_icon.dart';
import 'package:my_novel/components/default_button.dart';
import 'package:my_novel/helper/keyboard.dart';
import 'package:my_novel/models/item.dart';
import 'package:my_novel/providers/cart_provider.dart';
import 'package:my_novel/services/order_detail_service.dart';
import 'package:my_novel/services/order_service.dart';
import 'package:my_novel/services/user_service.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  final CartProvider cartProvider;
  const CheckoutCard({
    Key? key,
    required this.cartProvider,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  String address = '';
  String phonenumber = '';
  String email = '';
  final List<String?> errors = [];
  final _formKey = GlobalKey<FormState>();
  final OrderService _orderService = OrderService();
  final UserService _userService = UserService();
  final OrderDetailService _orderDetailService = OrderDetailService();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                const Text("Add voucher code"),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$" +
                            widget.cartProvider.getTotalAmount().toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Scaffold(
                              appBar: buildAppBar(context),
                              body: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(30),
                                        ),
                                        buildAddressFormField(),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(30),
                                        ),
                                        buildEmailFormField(),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(30),
                                        ),
                                        buildPhonenumberFormField(),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(20),
                                        ),
                                        DefaultButton(
                                          text: "Continue",
                                          press: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              // if all are valid then go to success screen
                                              KeyboardUtil.hideKeyboard(
                                                  context);
                                              debugPrint(address);
                                              onPressCheckOut();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onPressCheckOut() async {
    String placeholderUserId = await _userService.getUserId();
    String orderId = await _orderService.createOrder(DateTime.now().toString(),
        address, email, phonenumber, placeholderUserId);
    if (orderId != '') {
      for (CartItem item in widget.cartProvider.getCartItems()) {
        await _orderDetailService.createOrderDetail(item.unitPrice,
            item.quantity, item.uniqueCheck, item.productId, orderId);
      }
      Fluttertoast.showToast(
        msg: "Order Succesfull",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pop(context, true);
      widget.cartProvider.deleteAllCartProvider();
      Navigator.pop(context, true);
    }
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPhonenumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => phonenumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      decoration: const InputDecoration(
        labelText: "Phone number",
        hintText: "Enter your Phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/phone-1.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => address = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      decoration: const InputDecoration(
        labelText: "Delivery address",
        hintText: "Enter your delivery address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/location-38.svg"),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: const [
          Text(
            "Checkout",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }
}
