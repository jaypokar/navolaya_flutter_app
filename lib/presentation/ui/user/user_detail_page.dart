import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/bloc/createChatBloc/create_chat_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/userConnectionsBloc/user_connections_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/reportUsersCubit/report_users_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_about_me_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_address_details_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_personal_and_education_widget.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/value_key_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../data/model/users_model.dart';
import 'widget/user_connect_message_and_option_widget.dart';
import 'widget/user_social_media_widget.dart';

// ignore: must_be_immutable
class UserDetailPage extends StatelessWidget {
  UserDataModel user;
  final bool isNearBy;

  UserDetailPage({required this.user, required this.isNearBy, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isUserBlocked = false;

    String image = ImageResources.userAvatarImg;
    String userCurrentAddress = '';
    String userPermanentAddress = '';
    bool showSocialMediaProfiles = false;

    final displaySettings = user.displaySettings;

    if (((user.displaySettings!.userImage! == 'my_connections' && user.isConnected!) ||
            displaySettings!.userImage == 'all') &&
        user.userImage != null) {
      if (user.userImage!.fileurl!.contains('http')) {
        image = user.userImage!.fileurl!;
      }
    }

    if (displaySettings!.currentAddress == 'all' ||
        (user.isConnected! && displaySettings.currentAddress == 'my_connections')) {
      userCurrentAddress = user.currentAddress ?? '';
    }

    if (displaySettings.permanentAddress == 'all' ||
        (user.isConnected! && displaySettings.permanentAddress == 'my_connections')) {
      userPermanentAddress = user.permanentAddress ?? '';
    }

    showSocialMediaProfiles = displaySettings.socialProfileLinks == 'all' ||
        (user.isConnected! && displaySettings.socialProfileLinks == 'my_connections');

    if (user.isViewed != null) {
      if (!user.isViewed!) {
        context.read<UserConnectionsBloc>().add(UpdateUserViewedEvent(userID: user.id!));
      }
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<CreateChatBloc, CreateChatState>(
          listener: (_, state) {
            if (state is CreateChatErrorState) {
              sl<CommonFunctions>().showFlushBar(
                  context: context,
                  message: state.message,
                  bgColor: ColorConstants.messageErrorBgColor);
            } else if (state is HandleCreateChatState) {
              Navigator.of(context).pushNamed(RouteGenerator.chatDetailPage, arguments: {
                ValueKeyResources.chatDetailDataKey: state.response.data!,
                ValueKeyResources.chatStatusKey: 1
              });
            }
          },
        ),
        BlocListener<UserConnectionsBloc, UserConnectionsState>(
          listener: (_, state) {
            if (state is UserConnectionErrorState) {
              sl<CommonFunctions>().showFlushBar(
                  context: context,
                  message: state.error,
                  bgColor: ColorConstants.messageErrorBgColor);
            } else if (state is CreateConnectionsState) {
              user.isRequestSent = true;
            } else if (state is UpdateConnectionsState) {
              user.isConnected = state.isRequestAccepted;
              user.isRequestSent = false;
              user.isRequestReceived = false;
            } else if (state is RemoveConnectionsState) {
              user.isConnected = false;
            } else if (state is UpdateUserViewedState) {
              user.isViewed = true;
            }
          },
        ),
        BlocListener<BlockUsersCubit, BlockUsersState>(
          listener: (_, state) async {
            if (state is ErrorLoadingBlockUsersState) {
              sl<CommonFunctions>().showFlushBar(
                  context: context,
                  message: state.message,
                  bgColor: ColorConstants.messageErrorBgColor);
            } else if (state is BlockUserResponseState) {
              isUserBlocked = true;
              Navigator.of(context).pop();
              await sl<CommonFunctions>().showFlushBar(
                context: context,
                message: state.response.message!,
                duration: 1,
              );

              // ignore: use_build_context_synchronously
              navigateBackToPreviousScreen(context, isUserBlocked);
            }
          },
        ),
        BlocListener<ReportUsersCubit, ReportUsersState>(
          listener: (_, state) async {
            if (state is ErrorLoadingReportedUsersState) {
              sl<CommonFunctions>().showFlushBar(
                  context: context,
                  message: state.message,
                  bgColor: ColorConstants.messageErrorBgColor);
            } else if (state is ReportUserResponseState) {
              isUserBlocked = true;
              Navigator.of(context).pop();
              await sl<CommonFunctions>().showFlushBar(
                context: context,
                message: state.response.message!,
                duration: 1,
              );
              // ignore: use_build_context_synchronously
              navigateBackToPreviousScreen(context, false);
            }
          },
        ),
      ],
      child: WillPopScope(
        onWillPop: () {
          navigateBackToPreviousScreen(context, isUserBlocked);
          return Future(() => true);
        },
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: InkWell(
                  onTap: () {
                    navigateBackToPreviousScreen(context, isUserBlocked);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                    child: Container(
                      margin: const EdgeInsets.only(left: 6),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                pinned: false,
                snap: false,
                floating: false,
                expandedHeight: 460.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(''),
                  background: image.contains('http')
                      ? Container(
                          decoration: const BoxDecoration(color: Colors.black),
                          /*padding: const EdgeInsets.only(top: 40),*/
                          child: ImageNetwork(
                            image: image,
                            imageCache: CachedNetworkImageProvider(image),
                            /*fitAndroidIos: BoxFit.cover,*/
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            onError: Padding(
                                padding: const EdgeInsets.all(60), child: Image.asset(image)),
                            onLoading: Padding(
                                padding: const EdgeInsets.all(60), child: Image.asset(image)),
                          ),
                        )
                      : Padding(padding: const EdgeInsets.all(60), child: Image.asset(image)),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  UserPersonalAndEducationWidget(
                    user: user,
                    isNearBy: isNearBy,
                  ),
                  UserConnectMessageAndOptionWidget(user: user),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 5),
                  if (userCurrentAddress.isNotEmpty || userPermanentAddress.isNotEmpty) ...[
                    UserAddressDetailsWidget(
                      userCurrentAddress: userCurrentAddress,
                      userPermanentAddress: userPermanentAddress,
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 5),
                  ],
                  if (user.aboutMe != null) ...[
                    if (user.aboutMe!.isEmpty) ...[
                      const SizedBox.shrink()
                    ] else ...[
                      UserAboutMeWidget(user: user),
                      const SizedBox(height: 5),
                      const Divider(color: Colors.grey),
                    ]
                  ],
                  user.socialProfileLinks == null
                      ? const SizedBox.shrink()
                      : showSocialMediaProfiles
                          ? UserSocialMediaWidget(user: user)
                          : const SizedBox.shrink(),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateBackToPreviousScreen(BuildContext context, bool isUserBlocked) {
    Navigator.of(context)
        .pop({ValueKeyResources.userDataKey: user, ValueKeyResources.userIsBlocked: isUserBlocked});
  }
}
