import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_novel/services/profile_service.dart';
import 'package:my_novel/services/user_service.dart';
import 'package:my_novel/src/screens/cart/cart_screen.dart';
import 'package:my_novel/src/screens/details/details_screen.dart';
import 'package:my_novel/states/authentication_state.dart';

import 'blocs/authentication_bloc.dart';
import 'blocs/login_bloc.dart';
import 'events/authentication_event.dart';
import 'models/route_argument.dart';
import 'src/screens/edit_profile.dart';
import 'src/screens/login.dart';
import 'src/screens/register.dart';
import 'src/screens/search.dart';
import 'src/screens/tabs.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final UserService _userService = UserService();
    final ProfileService _profileService = ProfileService();

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const TabsWidget(indexTab: 0));
      case '/Login':
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(userService: _userService),
            child: LoginWidget(
              userRepository: _userService,
            ), //LoginPage,
          ),
        );
      case '/Register':
        return MaterialPageRoute(
            builder: (_) => RegisterWidget(userService: _userService));
      case '/ProductDetail':
        return MaterialPageRoute(
            builder: (_) =>
                DetailsScreen(routeArgument: args as RouteArgument));
      case '/Cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case '/EditProfile':
        return MaterialPageRoute(builder: (_) => const EditProfileWidget());
      case '/Search':
        return MaterialPageRoute(builder: (_) => const SearchWidget());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
