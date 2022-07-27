import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../core/color_constants.dart';
import '../../../basicWidget/loading_widget.dart';

enum ConnectionsType { myConnections, connectionsReceived, connectionsSent }

class MyConnectionsItemWidget extends StatelessWidget {
  final ConnectionsType connectionsType;
  final UserDataModel user;

  const MyConnectionsItemWidget({required this.user, required this.connectionsType, Key? key})
      : super(key: key);

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
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: image.contains('http')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) {
                            return Image.asset(ImageResources.userAvatarImg);
                          },
                          progressIndicatorBuilder: (_, __, ___) {
                            return const LoadingWidget();
                          }),
                    )
                  : ClipRRect(borderRadius: BorderRadius.circular(40), child: Image.asset(image)),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    user.fullName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.school,
                        color: ColorConstants.textColor3,
                        size: 14,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        user.school!.city!,
                        style: const TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.link,
                        color: ColorConstants.textColor3,
                        size: 14,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        user.relationWithJnv!,
                        style: const TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            getActionWidget(),
          ],
        ),
      ),
    );
  }

  Widget getActionWidget() {
    if (connectionsType == ConnectionsType.myConnections) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorConstants.red),
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: const Text(
          StringResources.remove,
          style: TextStyle(color: ColorConstants.red, fontSize: 12),
        ),
      );
    } else if (connectionsType == ConnectionsType.connectionsReceived) {
      return Row(
        children: [
          Image.asset(
            ImageResources.cancelIcon,
            height: 25,
            width: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Image.asset(
            ImageResources.acceptIcon,
            height: 25,
            width: 25,
          ),
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: ColorConstants.red),
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: const Text(
          StringResources.cancel,
          style: TextStyle(color: ColorConstants.red, fontSize: 12),
        ),
      );
    }
  }
}
