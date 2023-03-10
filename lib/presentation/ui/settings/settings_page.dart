import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/basicWidget/loading_widget.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../resources/color_constants.dart';
import '../../../resources/string_resources.dart';
import '../../../resources/value_key_resources.dart';
import '../../basicWidget/divider_and_space_widget.dart';
import 'widget/privacy_settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _switchValue = false;
  final ExpandableController _generalSettingsExpandableController =
      ExpandableController(initialExpanded: true);
  final ExpandableController _privacySettingsExpandableController =
      ExpandableController(initialExpanded: true);

  @override
  void initState() {
    super.initState();
    final userDetails = sl<SessionManager>().getUserDetails();
    _switchValue = userDetails!.data!.allowNotifications == 1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) {
        if (state is ProfileErrorState) {
          sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.message,
            bgColor: ColorConstants.messageErrorBgColor,
          );
        } else if (state is UpdatePrivacySettingsState) {
          sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.response.message!,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.settings,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  iconSize: 28,
                  expandIcon: Icons.navigate_next,
                  iconPadding: EdgeInsets.symmetric(vertical: 5),
                ),
                header: const Text(
                  StringResources.generalSettings,
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                ),
                controller: _generalSettingsExpandableController,
                collapsed: const SizedBox.shrink(),
                expanded: Row(
                  children: [
                    const Text(
                      StringResources.allowNotifications,
                      style: TextStyle(
                        color: ColorConstants.textColor3,
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Transform.translate(
                      offset: const Offset(10, 0),
                      child: Transform.scale(
                        scale: 0.6,
                        child: CupertinoSwitch(
                          value: _switchValue,
                          onChanged: (bool value) {
                            setState(() {
                              _switchValue = value;
                              context.read<ProfileBloc>().add(
                                      UpdateProfileImageOrAllowNotificationEvent(reqData: {
                                    ValueKeyResources.allowNotificationsKey: _switchValue ? 1 : 0
                                  }));
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const DividerAndSpaceWidget(),
              ExpandablePanel(
                theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    iconSize: 28,
                    expandIcon: Icons.navigate_next,
                    iconPadding: EdgeInsets.symmetric(vertical: 5)),
                controller: _privacySettingsExpandableController,
                header: const Text(
                  StringResources.privacySettings,
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                ),
                collapsed: const SizedBox.shrink(),
                expanded: const PrivacySettingsWidget(),
              ),
              const DividerAndSpaceWidget(),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteGenerator.changePasswordPage);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      StringResources.changePassword,
                      style:
                          TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      color: ColorConstants.navigateIconColor,
                      size: 28,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const DividerAndSpaceWidget(),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteGenerator.blockedUserPage);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      StringResources.blockedUsers,
                      style:
                          TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      color: ColorConstants.navigateIconColor,
                      size: 28,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const DividerAndSpaceWidget(),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteGenerator.reportUserPage);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      StringResources.reportedUsers,
                      style:
                          TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Icon(
                      Icons.navigate_next,
                      color: ColorConstants.navigateIconColor,
                      size: 28,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const DividerAndSpaceWidget(),
              const SizedBox(
                height: 5,
              ),
              ExpandablePanel(
                theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    iconSize: 28,
                    expandIcon: Icons.navigate_next,
                    iconPlacement: ExpandablePanelIconPlacement.right,
                    iconPadding: EdgeInsets.symmetric(vertical: 5)),
                header: const Text(
                  StringResources.accountDeletion,
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                ),
                collapsed: const SizedBox.shrink(),
                expanded: BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (_, state) {
                    if (state is UpdatePrivacySettingsState) {
                      return false;
                    }
                    return true;
                  },
                  builder: (_, state) {
                    if (state is DeleteProfileLoadingState) {
                      return const LoadingWidget();
                    }
                    return InkWell(
                      onTap: () async {
                        final result = await sl<CommonFunctions>().showConfirmationDialog(
                          context: context,
                          title: StringResources.deleteAccount,
                          message: StringResources.deleteDescription,
                          buttonPositiveText: StringResources.confirm,
                          buttonNegativeText: StringResources.cancel,
                        );
                        if (result && mounted) {
                          context.read<ProfileBloc>().add(const DeleteProfileEvent());
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: ColorConstants.red),
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Text(
                          StringResources.deleteAccount,
                          style: TextStyle(
                              color: ColorConstants.red, fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const DividerAndSpaceWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
