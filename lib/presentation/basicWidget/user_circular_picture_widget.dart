import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../core/color_constants.dart';
import '../../resources/image_resources.dart';
import 'loading_widget.dart';

class UserCircularPictureWidget extends StatelessWidget {
  final String image;

  const UserCircularPictureWidget({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
          color: ColorConstants.colorPrimary.withOpacity(0.5),
          shape: BoxShape.circle,
          image: const DecorationImage(
              image: AssetImage(
            ImageResources.userAvatarImg,
          ))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(37.0),
        child: image.contains('http')
            ? Container(
                color: ColorConstants.appColor,
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
            : const SizedBox.shrink(),
      ),
    );
  }
}
