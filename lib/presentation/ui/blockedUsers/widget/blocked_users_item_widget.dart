import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/user_circular_picture_widget.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';

import '../../../../data/model/users_model../../../../resources/string_resources.dart';
import '../../../../data/model/users_model.dart';
import '../../../../resources/color_constants.dart';
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
          (user.displaySettings!.userImage == 'my_connections' && user.isConnected!)) {
        image = user.userImage != null ? user.userImage!.thumburl! : ImageResources.userAvatarImg;
      }
    }

    return InkWell(
      onTap: () {
        /*Navigator.of(context).pushNamed(RouteGenerator.userDetailPage, arguments: {
          ValueKeyResources.userDataKey: user,
          ValueKeyResources.nearByDistanceKey: false
        });*/
      },
      child: ListTile(
        key: ValueKey(user.id!),
        leading: UserCircularPictureWidget(image: image),
        title: Text(user.fullName!),
        trailing: BlocBuilder<BlockUsersCubit, BlockUsersState>(
          builder: (_, state) {
            if (state is UnBlockUserLoadingState && isLoading) {
              return const FittedBox(
                  alignment: Alignment.centerRight,
                  child: LoadingWidget(
                    size: 25,
                  ));
            }
            return InkWell(
              onTap: () {
                isLoading = true;
                context.read<BlockUsersCubit>().unBlockUser(user.id!);
              },
              child: Container(
                width: 74,
                height: 25,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: ColorConstants.textColor3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    StringResources.unBlockedUsers,
                    style: TextStyle(
                      color: ColorConstants.textColor3,
                      fontSize: 11,
                    ),
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
