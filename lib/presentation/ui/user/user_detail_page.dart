import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_about_me_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_address_details_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_personal_and_education_widget.dart';

import '../../../data/model/users_model.dart';
import '../../basicWidget/loading_widget.dart';
import 'widget/user_social_media_widget.dart';

class UserDetailPage extends StatelessWidget {
  final UserDataModel user;

  const UserDetailPage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = user.userImage != null ? user.userImage!.filepath! : 'assets/1.jpg';
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: false,
            expandedHeight: 360.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(''),
              background: image.contains('http')
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) {
                        return const LoadingWidget();
                      },
                      progressIndicatorBuilder: (_, __, ___) {
                        return const LoadingWidget();
                      },
                    )
                  : Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              UserPersonalAndEducationWidget(user: user),
              const SizedBox(height: 5),
              const Divider(color: Colors.grey),
              const SizedBox(height: 5),
              if (user.currentAddress == null && user.permanentAddress == null) ...[
                const SizedBox.shrink()
              ] else ...[
                UserAddressDetailsWidget(user: user),
                const SizedBox(height: 5),
                const Divider(color: Colors.grey),
                const SizedBox(height: 5),
              ],
              UserAboutMeWidget(user: user),
              const SizedBox(height: 5),
              const Divider(color: Colors.grey),
              user.socialProfileLinks == null
                  ? const SizedBox.shrink()
                  : UserSocialMediaWidget(user: user),
            ]),
          ),
        ],
      ),
    );
  }
}
