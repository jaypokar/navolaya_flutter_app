import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/loading_widget.dart';
import 'package:navolaya_flutter/resources/value_key_resources.dart';

import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';

// ignore: must_be_immutable
class UserItemWidget extends StatelessWidget {
  UserDataModel user;

  UserItemWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = ImageResources.userAvatarImg;
    if (user.displaySettings != null) {
      if (user.displaySettings!.userImage == 'all' ||
          (user.isConnected! && user.displaySettings!.userImage == 'my_connections')) {
        image = user.userImage != null ? user.userImage!.filepath! : ImageResources.userAvatarImg;
      }
    }

    return InkWell(
      onTap: () async {
        final userDetail = await Navigator.of(context)
            .pushNamed(RouteGenerator.userDetailPage, arguments: user) as Map<String, dynamic>;
        user = userDetail[ValueKeyResources.userDataKey];
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              image.contains('http')
                  ? CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) {
                        return Container(color: ColorConstants.appColor, child: Image.asset(image));
                      },
                      progressIndicatorBuilder: (_, __, ___) {
                        return const LoadingWidget();
                      },
                    )
                  : Container(color: ColorConstants.appColor, child: Image.asset(image)),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: Colors.black45.withOpacity(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName!,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${user.school!.city} ${user.school!.state}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.shirt,
                              color: ColorConstants.appColor, size: 8),
                          const SizedBox(width: 4),
                          Text(
                            user.relationWithJnv!,
                            style: const TextStyle(color: Colors.white, fontSize: 8),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.person, color: Colors.white, size: 8),
                          const SizedBox(width: 2),
                          Text(
                            user.gender!,
                            style: const TextStyle(color: Colors.white, fontSize: 8),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 8),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              '${user.fromYear}-${user.toYear}',
                              style: const TextStyle(color: Colors.white, fontSize: 8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
