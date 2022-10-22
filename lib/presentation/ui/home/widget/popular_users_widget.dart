import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/popularUsersCubit/popular_users_cubit.dart';

import '../../../../data/model/users_model.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';
import '../../../../resources/string_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/image_loader_widget.dart';
import '../../../basicWidget/no_data_widget.dart';
import 'user_item_widget.dart';

class PopularUsersWidget extends StatefulWidget {
  const PopularUsersWidget({Key? key}) : super(key: key);

  @override
  State<PopularUsersWidget> createState() => _PopularUsersWidgetState();
}

class _PopularUsersWidgetState extends State<PopularUsersWidget> {
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
            !context.read<PopularUsersCubit>().isListFetchingComplete) {
          context.read<PopularUsersCubit>().loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<PopularUsersCubit>().loadUsers(reset: true);
    /*if (context.read<PopularUsersCubit>().hasDataLoaded) {
      context.read<PopularUsersCubit>().loadUsers();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopularUsersCubit, PopularUsersState>(
      listener: (_, state) {
        if (state is ErrorLoadingPopularUsersState) {
          sl<CommonFunctions>().showFlushBar(
              context: context,
              message: state.message,
              bgColor: ColorConstants.messageErrorBgColor);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<PopularUsersCubit, PopularUsersState>(
              builder: (_, state) {
                if (state is LoadingPopularUsersState && state.isFirstFetch) {
                  return const SizedBox.shrink();
                }
                List<UserDataModel> users = [];
                bool isLoading = false;
                if (state is LoadingPopularUsersState) {
                  users = state.oldUsers;
                  isLoading = true;
                } else if (state is LoadPopularUsersState) {
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
            BlocBuilder<PopularUsersCubit, PopularUsersState>(builder: (_, state) {
              if (state is LoadingPopularUsersState) {
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
