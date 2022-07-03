import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_about_me_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_address_details_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_personal_and_education_widget.dart';

import 'widget/user_social_media_widget.dart';

class UserDetailPage extends StatefulWidget {
  final String image;

  const UserDetailPage({required this.image, Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = false;

  //ScrollController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 360.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(''),
              background: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const UserPersonalAndEducationWidget(),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 5,
              ),
              const UserAddressDetailsWidget(),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 5,
              ),
              const UserAboutMeWidget(),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const UserSocialMediaWidget(),
            ]),
          ),
        ],
      ),
    );
  }
}
