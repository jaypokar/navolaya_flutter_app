import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/popularUsersCubit/popular_users_cubit.dart';

import '../../../../data/model/users_model.dart';
import '../../../../injection_container.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/loading_widget.dart';
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
    setupScrollController();
    loadUsers();
  }

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !sl<PopularUsersCubit>().isListFetchingComplete) {
          loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<PopularUsersCubit>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopularUsersCubit, PopularUsersState>(
      listener: (_, state) {
        if (state is ErrorLoadingPopularUsersState) {
          sl<CommonFunctions>().showFlushBar(
              context: context,
              message: state.message,
              bgColor: Colors.red,
              textColor: Colors.white);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PopularUsersCubit, PopularUsersState>(
          builder: (_, state) {
            if (state is LoadingPopularUsersState && state.isFirstFetch) {
              return const LoadingWidget();
            }
            List<UserDataModel> users = [];
            bool isLoading = false;
            if (state is LoadingPopularUsersState) {
              users = state.oldUsers;
              isLoading = true;
            } else if (state is LoadPopularUsersState) {
              users = state.usersData;
            }
            return GridView.builder(
              itemCount: users.length + (isLoading ? 1 : 0),
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                if (index < users.length) {
                  return UserItemWidget(
                    key: ValueKey(users[index].id!),
                    user: users[index],
                  );
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  });

                  return const Align(
                      alignment: Alignment.bottomCenter, child: Center(child: LoadingWidget()));
                }
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 0,
                mainAxisSpacing: 2,
              ),
            );
          },
        ),
      ),
    );
  }
}
