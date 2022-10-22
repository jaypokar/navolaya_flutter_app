import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:navolaya_flutter/data/model/reported_user_model.dart';

import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';
import '../../../basicWidget/user_circular_picture_widget.dart';

class ReportedUsersItemWidget extends StatefulWidget {
  final ReportedUserData user;

  const ReportedUsersItemWidget({required this.user, Key? key}) : super(key: key);

  @override
  State<ReportedUsersItemWidget> createState() => _ReportedUsersItemWidgetState();
}

class _ReportedUsersItemWidgetState extends State<ReportedUsersItemWidget> {
  String image = ImageResources.userAvatarImg;
  late ReportedUserData user;

  @override
  void initState() {
    super.initState();
    user = widget.user;

    /*if ((user.displaySettings!.userImage! == 'my_connections' && user.isConnected!) ||
        user.displaySettings!.userImage == 'all') {
      image = user.user![0].userImage != null ? user.user![0].userImage!.thumburl! : ImageResources.userAvatarImg;
    }*/
    image = user.user!.userImage != null
        ? user.user!.userImage!.thumburl!
        : ImageResources.userAvatarImg;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserCircularPictureWidget(image: image),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.user.user!.fullName!,
                      softWrap: true,
                      maxLines: 1,
                      minFontSize: 15,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Image.asset(
                          ImageResources.schoolIcon,
                          color: ColorConstants.textColor3,
                          height: 13,
                          width: 13,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: AutoSizeText(
                            'JNV ${widget.user.user!.school!.district}',
                            softWrap: true,
                            maxLines: 1,
                            minFontSize: 13,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: ColorConstants.textColor3,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*const SizedBox(height: 2),
                  Row(
                    children: [
                      Image.asset(
                        ImageResources.jnvRelationIcon,
                        color: ColorConstants.textColor3,
                        height: 13,
                        width: 13,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        */ /*'widget.user.user![0].relationWithJnv!'*/ /*'',
                        style:  TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),*/
                  ],
                ),
              ),
              const SizedBox(width: 15),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user.reason!,
            style: const TextStyle(color: ColorConstants.textColor2, fontSize: 13),
          )
        ],
      ),
    );
  }
}
