import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_network/image_network.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/cubit/nearByUsersCubit/near_by_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/recentUsersCubit/recent_users_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/home/widget/user_home_personal_info_widget.dart';
import 'package:navolaya_flutter/resources/value_key_resources.dart';

import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';
import '../../../cubit/homeTabsNotifierCubit/home_tabs_notifier_cubit.dart';
import '../../../cubit/popularUsersCubit/popular_users_cubit.dart';

// ignore: must_be_immutable
class UserItemWidget extends StatefulWidget {
  UserDataModel user;
  final bool isNearBy;

  UserItemWidget({required this.user, this.isNearBy = false, Key? key}) : super(key: key);

  @override
  State<UserItemWidget> createState() => _UserItemWidgetState();
}

class _UserItemWidgetState extends State<UserItemWidget> {
  String image = ImageResources.userAvatarImg;
  late UserDataModel user;

  @override
  void initState() {
    super.initState();
    user = widget.user;

    if (user.userImage != null) {
      final userImageFilePath = user.userImage!.fileurl;
      final displaySettings = user.displaySettings;
      final isUserConnected = user.isConnected;

      if (((displaySettings!.userImage == 'my_connections' && isUserConnected!) ||
          displaySettings.userImage == 'all')) {
        if (userImageFilePath!.contains('http')) {
          image = userImageFilePath;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      padding: EdgeInsets.zero,
      onPressed: () => callUserDetail(context),
      style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
          depth: 0,
          lightSource: LightSource.topLeft,
          intensity: 0.9),
      margin: const EdgeInsets.all(5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          image.contains('http')
              ? ImageNetwork(
                  image: image,
                  onTap: () => callUserDetail(context),
                  imageCache: CachedNetworkImageProvider(image),
                  fitAndroidIos: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  onError: Container(color: ColorConstants.appColor, child: Image.asset(image)),
                  onLoading: Container(color: ColorConstants.appColor, child: Image.asset(image)),
                )
              /*Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(color: ColorConstants.appColor, child: Image.asset(image)),
                )*/
              : Container(color: ColorConstants.appColor, child: Image.asset(image)),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              color: Colors.black45.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    user.fullName!,
                    maxLines: 1,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  AutoSizeText(
                    'JNV ${user.school!.district}',
                    maxLines: 2,
                    minFontSize: 8,
                    wrapWords: true,
                    softWrap: true,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  UserHomePersonalInfoWidget(user: user, isNearBy: widget.isNearBy),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void callUserDetail(BuildContext context) async {
    final userDetail = await Navigator.of(context).pushNamed(RouteGenerator.userDetailPage,
        arguments: {
          ValueKeyResources.userDataKey: user,
          ValueKeyResources.nearByDistanceKey: widget.isNearBy
        }) as Map<String, dynamic>?;

    if (userDetail != null) {
      if (userDetail.containsKey(ValueKeyResources.userDataKey)) {
        user = userDetail[ValueKeyResources.userDataKey];

        if (userDetail[ValueKeyResources.userIsBlocked]) {
          if (!mounted) return;
          if (context.read<HomeTabsNotifierCubit>().state == 0) {
            context.read<RecentUsersCubit>().updateUsersAfterBlockingUser(widget.user);
          } else if (context.read<HomeTabsNotifierCubit>().state == 1) {
            context.read<NearByUsersCubit>().updateUsersAfterBlockingUser(widget.user);
          } else {
            context.read<PopularUsersCubit>().updateUsersAfterBlockingUser(widget.user);
          }
        }
      }
    }
  }
}
