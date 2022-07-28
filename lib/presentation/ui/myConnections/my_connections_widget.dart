import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/presentation/cubit/myConnectionsCubit/my_connections_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/myConnections/widget/my_connections_item_widget.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../data/model/users_model.dart';
import '../../../injection_container.dart';
import '../../basicWidget/loading_widget.dart';

class MyConnectionsWidget extends StatefulWidget {
  const MyConnectionsWidget({Key? key}) : super(key: key);

  @override
  State<MyConnectionsWidget> createState() => _MyConnectionsWidgetState();
}

class _MyConnectionsWidgetState extends State<MyConnectionsWidget>
    with AutomaticKeepAliveClientMixin {
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
            !sl<MyConnectionsCubit>().isListFetchingComplete) {
          loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<MyConnectionsCubit>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<MyConnectionsCubit, MyConnectionsState>(
      listener: (_, state) {
        if (state is ErrorLoadingMyConnectionsState) {
          sl<CommonFunctions>().showFlushBar(
              context: context,
              message: state.message,
              bgColor: ColorConstants.red,
              textColor: Colors.white);
        } else if (state is RemoveMyConnectionState) {
          sl<CommonFunctions>().showFlushBar(
              context: context,
              message: state.createOrUpdateConnectionRequestResponse.message!,
              bgColor: Colors.green,
              textColor: Colors.white);
        }
      },
      child: BlocBuilder<MyConnectionsCubit, MyConnectionsState>(
        buildWhen: (_, state) {
          if (state is RemoveLoadingState || state is ErrorLoadingMyConnectionsState) {
            return false;
          }
          return true;
        },
        builder: (_, state) {
          if (state is LoadingMyConnectionsState && state.isFirstFetch) {
            return const LoadingWidget();
          }
          List<UserDataModel> users = [];
          bool isLoading = false;
          if (state is LoadingMyConnectionsState) {
            users = state.oldUsers;
            isLoading = true;
          } else if (state is LoadMyConnectionsState) {
            users = state.usersData;
          }
          return ListView.separated(
            itemCount: users.length + (isLoading ? 1 : 0),
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              if (index < users.length) {
                return MyConnectionsItemWidget(
                  key: ValueKey(users[index].id!),
                  connectionsType: ConnectionsType.myConnections,
                  user: users[index],
                );
              } else {
                Timer(const Duration(milliseconds: 30), () {
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                });

                return const LoadingWidget();
              }
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
