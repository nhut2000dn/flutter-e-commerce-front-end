import 'package:flutter/material.dart';
import 'package:my_novel/models/profile.dart';

import 'components/body.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  Profile profile;
  ProfileScreen({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        profile: widget.profile,
      ),
    );
  }
}
