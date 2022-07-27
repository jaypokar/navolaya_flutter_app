import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/userVerification/widget/user_verification_item_widget.dart';

import '../../../data/model/users_model.dart';
import '../../../injection_container.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/loading_widget.dart';
import '../../cubit/usersVerificationsCubit/users_verifications_cubit.dart';

class UserVerificationPage extends StatefulWidget {
  const UserVerificationPage({Key? key}) : super(key: key);

  @override
  State<UserVerificationPage> createState() => _UserVerificationPageState();
}

class _UserVerificationPageState extends State<UserVerificationPage> {
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
            !sl<UsersVerificationsCubit>().isListFetchingComplete) {
          loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<UsersVerificationsCubit>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersVerificationsCubit, UsersVerificationsState>(
      listener: (_, state) {
        if (state is ErrorLoadingUsersVerificationsState) {
          sl<CommonFunctions>().showSnackBar(
              context: context,
              message: state.message,
              bgColor: Colors.red,
              textColor: Colors.white);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.userVerificationRequests,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<UsersVerificationsCubit, UsersVerificationsState>(
          buildWhen: (_, state) {
            if (state is ConfirmLoadingState && state is DeclineLoadingState) {
              return false;
            }
            return true;
          },
          builder: (_, state) {
            if (state is LoadingUsersVerificationsState && state.isFirstFetch) {
              return const LoadingWidget();
            }
            List<UserDataModel> users = [];
            bool isLoading = false;
            if (state is LoadingUsersVerificationsState) {
              users = state.oldUsers;
              isLoading = true;
            } else if (state is LoadUsersVerificationsState) {
              users = state.usersData;
            }
            return ListView.separated(
              itemCount: users.length + (isLoading ? 1 : 0),
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                if (index < users.length) {
                  return UserVerificationItemWidget(
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
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey[400],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
