import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/users_model.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';
import '../../../../resources/string_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/image_loader_widget.dart';
import '../../../basicWidget/no_data_widget.dart';
import '../../../cubit/nearByUsersCubit/near_by_users_cubit.dart';
import 'user_item_widget.dart';

class NearByUsersWidget extends StatefulWidget {
  const NearByUsersWidget({Key? key}) : super(key: key);

  @override
  State<NearByUsersWidget> createState() => _NearByUsersWidgetState();
}

class _NearByUsersWidgetState extends State<NearByUsersWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    handleLocationService();
  }

  void handleLocationService() async {
    final shouldLoadData = await context.read<NearByUsersCubit>().handleUserLocation();
    if (!mounted) return;
    if (shouldLoadData) {
      loadUsers();
      setupScrollController();
    }
  }

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !context.read<NearByUsersCubit>().isListFetchingComplete) {
          context.read<NearByUsersCubit>().loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<NearByUsersCubit>().loadUsers(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NearByUsersCubit, NearByUsersState>(
      listener: (_, state) {
        if (state is ErrorLoadingNearByUsersState) {
          if (state.message != StringResources.nearByLocationFetchTitle) {
            sl<CommonFunctions>().showFlushBar(
                context: context,
                message: state.message,
                bgColor: ColorConstants.messageErrorBgColor,
                duration: 2);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<NearByUsersCubit, NearByUsersState>(
              builder: (_, state) {
                if (state is NearByUsersInitial ||
                    (state is LoadingNearByUsersState && state.isFirstFetch)) {
                  return const SizedBox.shrink();
                }

                List<UserDataModel> users = [];
                bool isLoading = false;
                if (state is LoadingNearByUsersState) {
                  users = state.oldUsers;
                  isLoading = true;
                } else if (state is LoadNearByUsersState) {
                  users = state.usersData;
                }
                if (users.isEmpty && !isLoading) {
                  return const NoDataWidget(
                    message: StringResources.noDataAvailableMessage,
                    icon: ImageResources.userIcon,
                  );
                }

                return Expanded(
                  child: GridView.builder(
                    itemCount: users.length,
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) => UserItemWidget(
                      key: ValueKey(users[index].id!),
                      isNearBy: true,
                      user: users[index],
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 2,
                    ),
                  ),
                );
              },
            ),
            BlocBuilder<NearByUsersCubit, NearByUsersState>(builder: (_, state) {
              if (state is LoadingNearByUsersState || state is NearByUsersInitial) {
                return const ImageLoaderWidget();
              }
              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
