import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/users_model.dart';
import '../../../../injection_container.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/loading_widget.dart';
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
    if (!mounted) return;
    final shouldLoadData = await context.read<NearByUsersCubit>().handleUserLocation();
    if (shouldLoadData) {
      setupScrollController();
      loadUsers();
    }
  }

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !sl<NearByUsersCubit>().isListFetchingComplete) {
          loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<NearByUsersCubit>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NearByUsersCubit, NearByUsersState>(
      listener: (_, state) {
        if (state is ErrorLoadingNearByUsersState) {
          sl<CommonFunctions>().showFlushBar(
              context: context,
              message: state.message,
              bgColor: Colors.red,
              textColor: Colors.white,
              duration: 8);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<NearByUsersCubit, NearByUsersState>(
          builder: (_, state) {
            if (state is NearByUsersInitial) {
              return const LoadingWidget();
            }
            if (state is LoadingNearByUsersState && state.isFirstFetch) {
              return const LoadingWidget();
            }
            List<UserDataModel> users = [];
            bool isLoading = false;
            if (state is LoadingNearByUsersState) {
              users = state.oldUsers;
              isLoading = true;
            } else if (state is LoadNearByUsersState) {
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
