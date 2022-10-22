import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';

import '../../../../resources/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/loading_widget.dart';
import 'privacy_settings_item_widget.dart';

class PrivacySettingsWidget extends StatelessWidget {
  const PrivacySettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(const FetchPrivacySettingEvent());
    return Column(
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (_, state) => state is LoadPrivacySettingsState,
          builder: (_, state) {
            if (state is LoadPrivacySettingsState) {
              if (state.displaySettings != null) {
                final displaySettings = state.displaySettings!;
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (_, i) {
                    String value = StringResources.all;
                    late final String title;
                    if (i == 0) {
                      title = StringResources.phoneNumber;
                      if (displaySettings.phone! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.phone! == 'none') {
                        value = StringResources.none;
                      }
                    } else if (i == 1) {
                      title = StringResources.emailAddress;
                      if (displaySettings.email! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.email! == 'none') {
                        value = StringResources.none;
                      }
                    } else if (i == 2) {
                      title = StringResources.profileImage;
                      if (displaySettings.userImage! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.userImage! == 'none') {
                        value = StringResources.none;
                      }
                    } else if (i == 3) {
                      title = StringResources.birthDayAndMonth;
                      if (displaySettings.birthDayMonth! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.birthDayMonth! == 'none') {
                        value = StringResources.none;
                      }
                    } else if (i == 4) {
                      title = StringResources.birthYear;
                      if (displaySettings.birthYear! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.birthYear! == 'none') {
                        value = StringResources.none;
                      }
                    } else if (i == 5) {
                      title = StringResources.currentAddress;
                      if (displaySettings.currentAddress! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.currentAddress! == 'none') {
                        value = StringResources.none;
                      }
                    } else if (i == 6) {
                      title = StringResources.permanentAddress;
                      if (displaySettings.permanentAddress! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.permanentAddress! == 'none') {
                        value = StringResources.none;
                      }
                    } else if (i == 7) {
                      title = StringResources.socialProfiles;
                      if (displaySettings.socialProfileLinks! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.socialProfileLinks! == 'none') {
                        value = StringResources.none;
                      }
                    } else if (i == 8) {
                      title = StringResources.findMeNearBy;
                      if (displaySettings.findMeNearby! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.findMeNearby! == 'none') {
                        value = StringResources.none;
                      }
                    } else {
                      title = StringResources.sendMessages;
                      if (displaySettings.sendMessages! == 'my_connections') {
                        value = StringResources.myConnections;
                      } else if (displaySettings.sendMessages! == 'none') {
                        value = StringResources.none;
                      }
                    }
                    return PrivacySettingsItemWidget(
                      key: ValueKey(title),
                      title: title,
                      value: value,
                    );
                  },
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                );
              }
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          StringResources.privacySettingsToolTip,
          style: TextStyle(fontSize: 11, color: ColorConstants.messageErrorBgColor),
        ),
        const SizedBox(
          height: 5,
        ),
        BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (_, state) {
            if (state is DeleteProfileResponseState) {
              return false;
            }
            return true;
          },
          builder: (_, state) {
            if (state is ProfileLoadingState) {
              return const LoadingWidget();
            }

            return ButtonWidget(
              buttonText: StringResources.update,
              padding: 0,
              onPressButton: () {
                context.read<ProfileBloc>().add(const UpdatePrivacySettingEvent());
              },
            );
          },
        ),
      ],
    );
  }
}
