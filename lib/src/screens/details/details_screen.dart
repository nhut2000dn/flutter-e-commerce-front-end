import 'package:flutter/material.dart';
import 'package:my_novel/models/route_argument.dart';

import '../../../models/product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";
  final RouteArgument routeArgument;
  late Product product;
  DetailsScreen({Key? key, required this.routeArgument}) : super(key: key) {
    product = routeArgument.argumentsList![0] as Product;
  }
  @override
  State<StatefulWidget> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(rating: 2.1),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: _isLoading ? 0.5 : 1,
            child: AbsorbPointer(
              absorbing: _isLoading,
              child: Body(
                product: widget.product,
                isLoading: () => {
                  setState(() {
                    _isLoading = !_isLoading;
                  })
                },
              ),
            ),
          ),
          Opacity(
            opacity: _isLoading ? 1.0 : 0,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
