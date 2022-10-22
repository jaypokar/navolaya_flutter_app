import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/basicWidget/image_loader_widget.dart';
import 'package:navolaya_flutter/presentation/cubit/recentUsersCubit/recent_users_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/home/widget/user_item_widget.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../../resources/image_resources.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/no_data_widget.dart';

class RecentUsersWidget extends StatefulWidget {
  const RecentUsersWidget({Key? key}) : super(key: key);

  @override
  State<RecentUsersWidget> createState() => _RecentUsersWidgetState();
}

class _RecentUsersWidgetState extends State<RecentUsersWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadUsers();
    setupScrollController();
  }

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !context.read<RecentUsersCubit>().isListFetchingComplete) {
          context.read<RecentUsersCubit>().loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<RecentUsersCubit>().loadUsers(reset: true);
    /*if (context.read<RecentUsersCubit>().shouldLoadData) {
      context.read<RecentUsersCubit>().loadUsers();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecentUsersCubit, RecentUsersState>(
      listener: (_, state) {
        if (state is ErrorLoadingUsersState) {
          sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.message,
            bgColor: ColorConstants.messageErrorBgColor,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<RecentUsersCubit, RecentUsersState>(
              builder: (_, state) {
                if (state is LoadingUsersState && state.isFirstFetch) {
                  return const SizedBox.shrink();
                }
                List<UserDataModel> users = [];
                bool isLoading = false;
                if (state is LoadingUsersState) {
                  users = state.oldUsers;
                  isLoading = true;
                } else if (state is LoadUsersState) {
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
            BlocBuilder<RecentUsersCubit, RecentUsersState>(builder: (_, state) {
              if (state is LoadingUsersState) {
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
