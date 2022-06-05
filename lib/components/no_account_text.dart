import 'package:flutter/material.dart';
import 'package:my_novel/src/screens/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_novel/services/user_service.dart';
import 'package:my_novel/src/screens/register.dart';
import 'package:my_novel/blocs/register_bloc.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  final UserService _userService;

  const NoAccountText({Key? key, required UserService userRepository})
      : _userService = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return BlocProvider<RegisterBloc>(
                  create: (context) =>
                      RegisterBloc(userRepository: _userService),
                  child: RegisterWidget(userService: _userService));
            }),
          ),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
