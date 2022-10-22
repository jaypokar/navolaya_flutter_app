import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/image_loader_widget.dart';
import 'package:navolaya_flutter/presentation/cubit/connectionReceivedCubit/connection_received_cubit.dart';

import '../../../../data/model/users_model.dart';
import '../../../../injection_container.dart';
import '../../../../resources/image_resources.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/no_data_widget.dart';
import '../../myConnections/widget/my_connections_item_widget.dart';

class ConnectionReceivedRequestWidget extends StatefulWidget {
  const ConnectionReceivedRequestWidget({Key? key}) : super(key: key);

  @override
  State<ConnectionReceivedRequestWidget> createState() => _ConnectionReceivedRequestWidgetState();
}

class _ConnectionReceivedRequestWidgetState extends State<ConnectionReceivedRequestWidget>
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
            !sl<ConnectionReceivedCubit>().isListFetchingComplete) {
          context.read<ConnectionReceivedCubit>().loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<ConnectionReceivedCubit>().loadUsers(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<ConnectionReceivedCubit, ConnectionReceivedState>(
      buildWhen: (_, state) {
        if (state is UpdateConnectionLoadingState || state is ErrorLoadingConnectionReceivedState) {
          return false;
        }
        return true;
      },
      builder: (_, state) {
        if (state is LoadingConnectionReceivedState && state.isFirstFetch) {
          return const ImageLoaderWidget();
        }
        List<UserDataModel> users = [];
        bool isLoading = false;
        if (state is LoadingConnectionReceivedState) {
          users = state.oldUsers;
          isLoading = true;
        } else if (state is LoadConnectionReceivedState) {
          users = state.usersData;
        }

        if (users.isEmpty && !isLoading) {
          return const NoDataWidget(
            message: StringResources.noDataAvailableMessage,
            icon: ImageResources.connectionsIcon,
          );
        }

        return ListView.separated(
          itemCount: users.length + (isLoading ? 1 : 0),
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            if (index < users.length) {
              /*return MyConnectionsItemWidget(
                key: ValueKey(users[index].id!),
                connectionsType: ConnectionsType.connectionsReceived,
                user: users[index],
              );*/
              return index == users.length - 1
                  ? Column(
                      children: [
                        MyConnectionsItemWidget(
                          key: ValueKey(users[index].id!),
                          connectionsType: ConnectionsType.connectionsReceived,
                          user: users[index],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(height: 1, color: Colors.grey),
                        )
                      ],
                    )
                  : MyConnectionsItemWidget(
                      key: ValueKey(users[index].id!),
                      connectionsType: ConnectionsType.connectionsReceived,
                      user: users[index],
                    );
            } else {
              Timer(const Duration(milliseconds: 30), () {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              });

              return const ImageLoaderWidget();
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
