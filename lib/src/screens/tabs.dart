import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_novel/blocs/authentication_bloc.dart';
import 'package:my_novel/models/category.dart';
import 'package:my_novel/models/product.dart';
import 'package:my_novel/models/profile.dart';
import 'package:my_novel/models/slideshow.dart';
import 'package:my_novel/services/category_service.dart';
import 'package:my_novel/services/product_service.dart';
import 'package:my_novel/services/slideshow_service.dart';
import 'package:my_novel/src/screens/cart/cart_screen.dart';
import 'package:my_novel/src/screens/favourite/favourite_screen.dart';
import 'package:my_novel/src/screens/profile/profile_screen.dart';
import 'package:my_novel/states/authentication_state.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'home/home.dart';

class TabsWidget extends StatefulWidget {
  final int indexTab;

  const TabsWidget({
    Key? key,
    required this.indexTab,
  }) : super(key: key);

  @override
  _TabsWidgetState createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  late final PageController _pageController = PageController();
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();
  late List<Category> categories = [];
  late List<Product> popularProducts = [];

  final SlideshowService _slideshowService = SlideshowService();
  late List<SlideshowModel> slideshows = [
    SlideshowModel(
        id: '', image: 'https://i.imgur.com/tj3Dbsw.gif', novelId: '')
  ];
  late Profile profile = Profile(email: '', avatar: '');

  setData() async {
    var holderCategories = await _categoryService.getCategoryss();
    var holderPopularProducts = await _productService.getTop5ProductView();

    var holderSlideshows = await _slideshowService.getSlideshows();
    setState(() {
      categories = holderCategories;
      popularProducts = holderPopularProducts;
      inspect(popularProducts);
      slideshows = holderSlideshows;
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2, color: Colors.grey[300]!),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[300]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite_outline,
                    text: 'Favourite',
                  ),
                  GButton(
                    icon: IconData(0xf37f, fontFamily: 'MaterialIcons'),
                    text: 'Cart',
                  ),
                  GButton(
                    icon: Icons.person_outlined,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: 0,
                onTabChange: (index) {
                  setState(() {
                    _pageController.jumpToPage(index);
                  });
                },
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomeWidget(
            popularProducts: popularProducts,
            categories: categories,
            slideshows: slideshows,
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authenticationState) {
              if (authenticationState is AuthenticationStateSuccess) {
                inspect(authenticationState.productsfavourited);
                return favouriteScreen(
                  productsfavourited:
                      authenticationState.productsfavourited ?? [],
                );
              } else if (authenticationState is AuthenticationStateFailure) {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Login');
                    },
                    child: const Text('Login'),
                  ),
                );
              }
              return const Center();
            },
          ),
          const CartScreen(),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authenticationState) {
              if (authenticationState is AuthenticationStateSuccess) {
                return ProfileScreen(
                  profile: authenticationState.profile!,
                );
              } else if (authenticationState is AuthenticationStateFailure) {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Login');
                    },
                    child: const Text('Login'),
                  ),
                );
              }
              return const Center();
            },
          ),
        ],
        onPageChanged: (int index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
