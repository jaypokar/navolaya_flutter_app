import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/social_media_links_request_model.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';

import '../../../core/color_constants.dart';
import '../../../injection_container.dart';
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
      listener: (_, state) {
        if (state is ProfileErrorState) {
          showMessage(isError: true, message: state.message);
        } else if (state is LoadUpdateSocialMediaLinksState) {
          showMessage(isError: false, message: state.socialMediaProfiles.message!);
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
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: _fbController,
                hint: StringResources.facebook,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: _instaController,
                hint: StringResources.instagram,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: _linkedInController,
                hint: StringResources.linkedIn,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: _youTubeController,
                hint: StringResources.youTube,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: _twitterController,
                hint: StringResources.twitter,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              getButton()
            ],
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

  void showMessage({required bool isError, required String message}) {
    if (mounted) {
      sl<CommonFunctions>().showSnackBar(
        context: context,
        message: message,
        bgColor: isError ? Colors.red : ColorConstants.appColor,
        textColor: Colors.white,
      );
    }
  }
}
