import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/reportUsersCubit/report_users_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/reportedUsers/widget/reported_users_item_widget.dart';

import '../../../data/model/reported_user_model.dart';
import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/image_resources.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/image_loader_widget.dart';
import '../../basicWidget/no_data_widget.dart';

class ReportedUsersPage extends StatefulWidget {
  const ReportedUsersPage({Key? key}) : super(key: key);

  @override
  State<ReportedUsersPage> createState() => _ReportedUsersPageState();
}

class _ReportedUsersPageState extends State<ReportedUsersPage> {
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
            !context.read<ReportUsersCubit>().isListFetchingComplete) {
          loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<ReportUsersCubit>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReportUsersCubit, ReportUsersState>(
      listener: (_, state) {
        if (state is ErrorLoadingReportedUsersState) {
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
            StringResources.reportedUsers,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<ReportUsersCubit, ReportUsersState>(
          buildWhen: (_, state) {
            if (state is UnReportUserLoadingState ||
                state is ErrorLoadingReportedUsersState ||
                state is UnReportUserState) {
              return false;
            }
            return true;
          },
          builder: (_, state) {
            if (state is LoadingReportedUsersState && state.isFirstFetch) {
              return const ImageLoaderWidget();
            }
            List<ReportedUserData> users = [];
            bool isLoading = false;
            if (state is LoadingReportedUsersState) {
              users = state.oldUsers;
              isLoading = true;
            } else if (state is LoadReportedUsersState) {
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
                            ReportedUsersItemWidget(
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
                      : ReportedUsersItemWidget(
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
