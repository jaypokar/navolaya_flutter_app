import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/cubit/usersVerificationsCubit/users_verifications_cubit.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../core/route_generator.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';
import '../../../basicWidget/loading_widget.dart';

class UserVerificationItemWidget extends StatelessWidget {
  final UserDataModel user;
  const UserVerificationItemWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    String image = ImageResources.userAvatarImg;
    if (user.displaySettings != null) {
      if (user.displaySettings!.userImage == 'all' ||
          (user.isConnected! && user.displaySettings!.userImage == 'my_connections')) {
        image = user.userImage != null ? user.userImage!.filepath! : ImageResources.userAvatarImg;
      }
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteGenerator.userDetailPage, arguments: user);
      },
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
                        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.school,
                        color: ColorConstants.textColor3,
                        size: 12,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        user.school!.city!,
                        style: const TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        FontAwesomeIcons.link,
                        color: ColorConstants.textColor3,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        user.relationWithJnv!,
                        style: const TextStyle(
                          color: ColorConstants.textColor3,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      BlocBuilder<UsersVerificationsCubit, UsersVerificationsState>(
                        builder: (_, state) {
                          if (state is ConfirmLoadingState && isLoading) {
                            return const LoadingWidget();
                          }
                          isLoading = false;
                          return InkWell(
                            onTap: () {
                              isLoading = true;
                              sl<UsersVerificationsCubit>()
                                  .updateUserVerificationRequest('confirm', user.id!);
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: ColorConstants.appColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Text(
                                  StringResources.confirm,
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                )),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      BlocBuilder<UsersVerificationsCubit, UsersVerificationsState>(
                        builder: (_, state) {
                          if (state is DeclineLoadingState && isLoading) {
                            return const LoadingWidget();
                          }
                          isLoading = false;
                          return InkWell(
                            onTap: () {
                              isLoading = true;
                              sl<UsersVerificationsCubit>()
                                  .updateUserVerificationRequest('decline', user.id!);
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: ColorConstants.red),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Text(
                                  StringResources.decline,
                                  style: TextStyle(color: ColorConstants.red, fontSize: 12),
                                )),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
