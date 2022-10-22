import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/image_loader_widget.dart';

import '../../../../data/model/users_model.dart';
import '../../../../resources/image_resources.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/no_data_widget.dart';
import '../../../cubit/connectionSentCubit/connection_sent_cubit.dart';
import '../../myConnections/widget/my_connections_item_widget.dart';

class ConnectionSentRequestWidget extends StatefulWidget {
  const ConnectionSentRequestWidget({Key? key}) : super(key: key);

  @override
  State<ConnectionSentRequestWidget> createState() => _ConnectionSentRequestWidgetState();
}

class _ConnectionSentRequestWidgetState extends State<ConnectionSentRequestWidget>
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
            !context.read<ConnectionSentCubit>().isListFetchingComplete) {
          context.read<ConnectionSentCubit>().loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<ConnectionSentCubit>().loadUsers(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ConnectionSentCubit, ConnectionSentState>(
      buildWhen: (_, state) {
        if (state is UpdateConnectionSentLoadingState || state is ErrorLoadingConnectionSentState) {
          return false;
        }
        return true;
      },
      builder: (_, state) {
        if (state is LoadingConnectionSentState && state.isFirstFetch) {
          return const ImageLoaderWidget();
        }
        List<UserDataModel> users = [];
        bool isLoading = false;
        if (state is LoadingConnectionSentState) {
          users = state.oldUsers;
          isLoading = true;
        } else if (state is LoadConnectionSentState) {
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
              return index == users.length - 1
                  ? Column(
                      children: [
                        MyConnectionsItemWidget(
                          key: ValueKey(users[index].id!),
                          connectionsType: ConnectionsType.connectionsSent,
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
                      connectionsType: ConnectionsType.connectionsSent,
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
              child: Divider(height: 1, color: Colors.grey),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
