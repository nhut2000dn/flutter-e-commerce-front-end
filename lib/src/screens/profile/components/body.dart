import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_novel/blocs/authentication_bloc.dart';
import 'package:my_novel/events/authentication_event.dart';
import 'package:my_novel/models/profile.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  Profile profile;
  Body({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> with AutomaticKeepAliveClientMixin<Body> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          ProfilePic(
            imagePath: ((widget.profile.avatar == '')
                ? 'https://cdn.tricera.net/images/no-avatar.jpg'
                : widget.profile.avatar!),
            onClicked: () async {
              Navigator.of(context).pushNamed(
                '/EditProfile',
              );
            },
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.of(context).pushNamed(
                '/EditProfile',
              )
            },
          ),
          ProfileMenu(
            text: "My Orders",
            icon: "assets/icons/orders.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationEventLoggedOut(),
              );
            },
          ),
        ],
      ),
    );
  }
}
