import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/bloc/userConnectionsBloc/user_connections_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_about_me_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_address_details_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_personal_and_education_widget.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../data/model/users_model.dart';
import '../../basicWidget/loading_widget.dart';
import 'widget/user_social_media_widget.dart';

class UserDetailPage extends StatelessWidget {
  final UserDataModel user;

  const UserDetailPage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = ImageResources.userAvatarImg;
    if (user.displaySettings != null) {
      if (user.displaySettings!.userImage == 'all' ||
          (user.isConnected! && user.displaySettings!.userImage == 'my_connections')) {
        image = user.userImage != null ? user.userImage!.filepath! : ImageResources.userAvatarImg;
      }
    }

    String userCurrentAddress = '';
    if (user.displaySettings != null) {
      if (user.displaySettings!.currentAddress == 'all' ||
          (user.isConnected! && user.displaySettings!.currentAddress == 'my_connections')) {
        userCurrentAddress = user.currentAddress ?? '';
      }
    }

    String userPermanentAddress = '';
    if (user.displaySettings != null) {
      if (user.displaySettings!.permanentAddress == 'all' ||
          (user.isConnected! && user.displaySettings!.permanentAddress == 'my_connections')) {
        userPermanentAddress = user.permanentAddress ?? '';
      }
    }

    bool showSocialMediaProfiles = false;
    if (user.displaySettings != null) {
      showSocialMediaProfiles = user.displaySettings!.socialProfileLinks == 'all' ||
          (user.isConnected! && user.displaySettings!.socialProfileLinks == 'my_connections');
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<UserConnectionsBloc, UserConnectionsState>(
          listener: (_, state) {
            if (state is UserConnectionErrorState) {
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: state.error,
                  bgColor: ColorConstants.red,
                  textColor: Colors.white);
            }
          },
        ),
        BlocListener<BlockUsersCubit, BlockUsersState>(
          listener: (_, state) {
            if (state is ErrorLoadingBlockUsersState) {
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: state.message,
                  bgColor: ColorConstants.red,
                  textColor: Colors.white);
            } else if (state is BlockUserResponseState) {
              Navigator.of(context).pop();
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: state.response.message!,
                  bgColor: Colors.green,
                  textColor: Colors.white);
            }
          },
        ),
      ],
      child: Scaffold(
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
                          return Padding(
                              padding: const EdgeInsets.all(60),
                              child: Image.asset(ImageResources.userAvatarImg));
                        },
                        progressIndicatorBuilder: (_, __, ___) {
                          return const LoadingWidget();
                        })
                    : Padding(padding: const EdgeInsets.all(60), child: Image.asset(image)),
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
                  if (userCurrentAddress.isNotEmpty || userPermanentAddress.isNotEmpty) ...[
                    UserAddressDetailsWidget(
                      userCurrentAddress: userCurrentAddress,
                      userPermanentAddress: userPermanentAddress,
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 5),
                  ]
                ],
                UserAboutMeWidget(user: user),
                const SizedBox(height: 5),
                const Divider(color: Colors.grey),
                user.socialProfileLinks == null
                    ? const SizedBox.shrink()
                    : showSocialMediaProfiles
                        ? UserSocialMediaWidget(user: user)
                        : const SizedBox.shrink(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
