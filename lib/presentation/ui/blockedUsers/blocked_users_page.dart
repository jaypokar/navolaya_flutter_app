import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/image_loader_widget.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/blockedUsers/widget/blocked_users_item_widget.dart';

import '../../../data/model/users_model.dart';
import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/image_resources.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/no_data_widget.dart';

class BlockedUsersPage extends StatefulWidget {
  const BlockedUsersPage({Key? key}) : super(key: key);

  @override
  State<BlockedUsersPage> createState() => _BlockedUsersPageState();
}

class _BlockedUsersPageState extends State<BlockedUsersPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setupScrollController();
    loadUsers();
  }

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !context.read<BlockUsersCubit>().isListFetchingComplete) {
          loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<BlockUsersCubit>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlockUsersCubit, BlockUsersState>(
      listener: (_, state) {
        if (state is ErrorLoadingBlockUsersState) {
          sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.message,
            bgColor: ColorConstants.messageErrorBgColor,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.blockedUsers,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<BlockUsersCubit, BlockUsersState>(
          buildWhen: (_, state) {
            if (state is UnBlockUserLoadingState ||
                state is ErrorLoadingBlockUsersState ||
                state is UnBlockUserState) {
              return false;
            }
            return true;
          },
          builder: (_, state) {
            if (state is LoadingBlockedUsersState && state.isFirstFetch) {
              return const ImageLoaderWidget();
            }
            List<UserDataModel> users = [];
            bool isLoading = false;
            if (state is LoadingBlockedUsersState) {
              users = state.oldUsers;
              isLoading = true;
            } else if (state is LoadBlockUsersState) {
              users = state.usersData;
            }

            if (users.isEmpty) {
              return const NoDataWidget(
                message: StringResources.noDataAvailableMessage,
                icon: ImageResources.userIcon,
              );
            }

            return ListView.separated(
              itemCount: users.length + (isLoading ? 1 : 0),
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                if (index < users.length) {
                  return index == users.length - 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BlockedUsersItemWidget(
                              key: ValueKey(users[index].id!),
                              user: users[index],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        )
                      : BlockedUsersItemWidget(
                          key: ValueKey(users[index].id!),
                          user: users[index],
                        );
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  });

                  return const ImageLoaderWidget();
                }
              },
              separatorBuilder: (_, i) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                );
              },
              padding: const EdgeInsets.symmetric(vertical: 15),
            );
          },
        ),
      ),
    );
  }
}
