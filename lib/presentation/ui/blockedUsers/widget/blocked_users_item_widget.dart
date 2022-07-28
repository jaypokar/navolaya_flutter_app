import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/user_circular_picture_widget.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';

import '../../../../core/color_constants.dart';
import '../../../../core/route_generator.dart';
import '../../../../data/model/users_model../../../../resources/string_resources.dart';
import '../../../../data/model/users_model.dart';
import '../../../../resources/image_resources.dart';
import '../../../basicWidget/loading_widget.dart';

class BlockedUsersItemWidget extends StatelessWidget {
  final UserDataModel user;

  const BlockedUsersItemWidget({required this.user, Key? key}) : super(key: key);

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
      child: ListTile(
        key: ValueKey(user.id!),
        leading: UserCircularPictureWidget(image: image),
        title: Text(user.fullName!),
        trailing: BlocBuilder<BlockUsersCubit, BlockUsersState>(
          builder: (_, state) {
            if (state is UnBlockUserLoadingState && isLoading) {
              return const LoadingWidget();
            }
            return InkWell(
              onTap: () {
                isLoading = true;
                context.read<BlockUsersCubit>().unBlockUser(user.id!);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorConstants.appColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Text(
                  StringResources.unBlockedUsers.toUpperCase(),
                  style: const TextStyle(
                    color: ColorConstants.appColor,
                    fontSize: 10,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
