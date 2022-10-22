import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/social_media_links_request_model.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';

import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/custom_button.dart';
import '../../basicWidget/loading_widget.dart';
import '../../basicWidget/text_field_widget.dart';

class UpdateSocialProfilesPage extends StatefulWidget {
  const UpdateSocialProfilesPage({Key? key}) : super(key: key);

  @override
  State<UpdateSocialProfilesPage> createState() => _UpdateSocialProfilesPageState();
}

class _UpdateSocialProfilesPageState extends State<UpdateSocialProfilesPage> {
  final TextEditingController _fbController = TextEditingController();
  final TextEditingController _instaController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _youTubeController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const FetchPersonalDetails());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) async {
        if (state is ProfileErrorState) {
          showMessage(isError: true, message: state.message);
        } else if (state is LoadUpdateSocialMediaLinksState) {
          await showMessage(isError: false, message: state.socialMediaProfiles.message!);
          if (!mounted) return;
          Navigator.of(context).pop();
        } else if (state is LoadPersonalDetailsState) {
          loadSocialLinks(state.loginAndBasicInfoData);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.socialProfiles,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controller: _fbController,
                  hint: StringResources.facebook,
                  textInputType: TextInputType.text,
                  max: 250,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controller: _instaController,
                  hint: StringResources.instagram,
                  textInputType: TextInputType.text,
                  max: 250,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controller: _linkedInController,
                  hint: StringResources.linkedIn,
                  textInputType: TextInputType.text,
                  max: 250,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controller: _youTubeController,
                  hint: StringResources.youTube,
                  textInputType: TextInputType.text,
                  max: 250,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controller: _twitterController,
                  hint: StringResources.twitter,
                  textInputType: TextInputType.text,
                  max: 250,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  StringResources.socialProfileDesc,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: ColorConstants.messageErrorBgColor, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                getButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (_, state) {
      if (state is ProfileLoadingState) {
        return const LoadingWidget();
      } else {
        return ButtonWidget(
          buttonText: StringResources.save.toUpperCase(),
          padding: 0,
          onPressButton: () {
            if (_fbController.text.isNotEmpty ||
                _instaController.text.isNotEmpty ||
                _linkedInController.text.isNotEmpty ||
                _twitterController.text.isNotEmpty ||
                _youTubeController.text.isNotEmpty) {
              if (!sl<CommonFunctions>().isValidUrl(_fbController.text) &&
                  _fbController.text.isNotEmpty) {
                showMessage(
                    isError: true, message: '${StringResources.enterValidURL} for facebook');
                return;
              } else if (!sl<CommonFunctions>().isValidUrl(_instaController.text) &&
                  _instaController.text.isNotEmpty &&
                  !_instaController.text.startsWith('http')) {
                showMessage(
                    isError: true, message: '${StringResources.enterValidURL} for instagram');
                return;
              } else if (!sl<CommonFunctions>().isValidUrl(_linkedInController.text) &&
                  _linkedInController.text.isNotEmpty &&
                  !_linkedInController.text.startsWith('http')) {
                showMessage(
                    isError: true, message: '${StringResources.enterValidURL} for linkedin');
                return;
              } else if (!sl<CommonFunctions>().isValidUrl(_twitterController.text) &&
                  _twitterController.text.isNotEmpty &&
                  !_twitterController.text.startsWith('http')) {
                showMessage(isError: true, message: '${StringResources.enterValidURL} for twitter');
                return;
              } else if (!sl<CommonFunctions>().isValidUrl(_youTubeController.text) &&
                  _youTubeController.text.isNotEmpty &&
                  !_youTubeController.text.startsWith('http')) {
                showMessage(isError: true, message: '${StringResources.enterValidURL} for youtube');
                return;
              }

              final socialLinks = SocialMediaLinksRequestModel(
                  instagram: _instaController.text,
                  twitter: _twitterController.text,
                  facebook: _fbController.text,
                  linkedIn: _linkedInController.text,
                  youTube: _youTubeController.text);

              context.read<ProfileBloc>().add(
                  UpdateSocialMediaProfileLinksEvent(socialMediaLinksRequestData: socialLinks));
            }
          },
        );
      }
    });
  }

  void loadSocialLinks(LoginAndBasicInfoModel data) {
    if (data.data!.socialProfileLinks != null) {
      _fbController.text = data.data!.socialProfileLinks!.facebook!;
      _instaController.text = data.data!.socialProfileLinks!.instagram!;
      _youTubeController.text = data.data!.socialProfileLinks!.youtube!;
      _twitterController.text = data.data!.socialProfileLinks!.twitter!;
      _linkedInController.text = data.data!.socialProfileLinks!.linkedin!;
    }
  }

  Future<void> showMessage({required bool isError, required String message}) async {
    if (mounted) {
      await sl<CommonFunctions>().showFlushBar(
        context: context,
        message: message,
        bgColor: isError ? ColorConstants.messageErrorBgColor : ColorConstants.messageBgColor,
      );
    }
  }
}
