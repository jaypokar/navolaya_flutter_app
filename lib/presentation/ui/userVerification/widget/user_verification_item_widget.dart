import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../../core/route_generator.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';
import '../../../../resources/value_key_resources.dart';
import '../../../basicWidget/image_loader_widget.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../cubit/usersVerificationsCubit/users_verifications_cubit.dart';

class UserVerificationItemWidget extends StatefulWidget {
  final UserDataModel user;

  const UserVerificationItemWidget({required this.user, Key? key}) : super(key: key);

  @override
  State<UserVerificationItemWidget> createState() => _UserVerificationItemWidgetState();
}

class _UserVerificationItemWidgetState extends State<UserVerificationItemWidget> {
  String image = ImageResources.userAvatarImg;

  @override
  void initState() {
    super.initState();
    if (widget.user.displaySettings != null) {
      if (widget.user.displaySettings!.userImage == 'all' ||
          (widget.user.displaySettings!.userImage == 'my_connections' &&
              widget.user.isConnected!)) {
        image = widget.user.userImage != null
            ? widget.user.userImage!.thumburl!
            : ImageResources.userAvatarImg;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteGenerator.userDetailPage, arguments: {
          ValueKeyResources.userDataKey: widget.user,
          ValueKeyResources.nearByDistanceKey: false
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: ColorConstants.appColor.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: image.contains('http')
                    ? CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => Image.asset(ImageResources.userAvatarImg),
                        progressIndicatorBuilder: (_, __, ___) => const ImageLoaderWidget())
                    : Image.asset(image),
              ),
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
                    widget.user.fullName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Image.asset(
                        ImageResources.jnvRelationIcon,
                        color: ColorConstants.textColor3,
                        height: 12,
                        width: 12,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.user.relationWithJnv!,
                        style: const TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Image.asset(
                        ImageResources.schoolIcon,
                        color: ColorConstants.textColor3,
                        height: 12,
                        width: 12,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'JNV ${widget.user.school!.district!}',
                        style: const TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  actionWidget(context)
                ],
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }

  Widget actionWidget(BuildContext ctx) {
    bool isAcceptLoading = false;
    bool isDeclineLoading = false;
    return BlocBuilder<UsersVerificationsCubit, UsersVerificationsState>(
      builder: (_, state) {
        return Row(
          children: [
            isAcceptLoading
                ? const LoadingWidget(
                    size: 30,
                    margin: 0,
                  )
                : InkWell(
                    onTap: () async {
                      final result = await sl<CommonFunctions>().showConfirmationDialog(
                        context: context,
                        title: StringResources.verifyJNVIdentity,
                        message: StringResources.verifyUserConfirmationDescription,
                        buttonPositiveText: StringResources.confirm,
                        buttonNegativeText: StringResources.cancel,
                      );

                      if (result) {
                        isAcceptLoading = true;
                        if (!mounted) return;
                        context
                            .read<UsersVerificationsCubit>()
                            .updateUserVerificationRequest('confirm', widget.user.id!);
                      }
                    },
                    child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: ColorConstants.appColor, borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          StringResources.confirm,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        )),
                  ),
            const SizedBox(
              width: 10,
            ),
            isDeclineLoading
                ? const LoadingWidget(
                    size: 30,
                    margin: 0,
                  )
                : InkWell(
                    onTap: () {
                      isDeclineLoading = true;
                      context
                          .read<UsersVerificationsCubit>()
                          .updateUserVerificationRequest('decline', widget.user.id!);
                    },
                    child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorConstants.red),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          StringResources.decline,
                          style: TextStyle(
                              color: ColorConstants.red, fontWeight: FontWeight.bold, fontSize: 12),
                        )),
                  ),
          ],
        );
      },
    );
  }
}
