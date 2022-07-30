import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/blockedUsers/widget/blocked_users_item_widget.dart';

import '../../../data/model/users_model.dart';
import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/loading_widget.dart';

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
            !sl<BlockUsersCubit>().isListFetchingComplete) {
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
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.message,
            bgColor: ColorConstants.red,
            textColor: Colors.white,
          );
        } else if (state is UnBlockUserState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.response.message!,
            bgColor: Colors.green,
            textColor: Colors.white,
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
              return const LoadingWidget();
            }
            List<UserDataModel> users = [];
            bool isLoading = false;
            if (state is LoadingBlockedUsersState) {
              users = state.oldUsers;
              isLoading = true;
            } else if (state is LoadBlockUsersState) {
              users = state.usersData;
            }
            return ListView.separated(
              itemCount: users.length + (isLoading ? 1 : 0),
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                if (index < users.length) {
                  return BlockedUsersItemWidget(
                    key: ValueKey(users[index].id!),
                    user: users[index],
                  );
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  });

                  return const LoadingWidget();
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
