import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../core/color_constants.dart';
import '../../profileImageWidget/profile_image_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          StringResources.editProfile,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const ProfileImageWidget(),
            const SizedBox(height: 20),
            BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previousState, state) => state is LoadPersonalDetailsState,
              builder: (_, state) {
                if (state is LoadPersonalDetailsState) {
                  return Text(
                    state.loginAndBasicInfoData.data!.fullName!,
                    style: const TextStyle(
                      color: ColorConstants.textColor7,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 40),
            InkWell(
                onTap: () => Navigator.of(context).pushNamed(RouteGenerator.updateBasicInfoPage),
                child: const EditProfileOptionsItemWidget(
                  title: StringResources.updatePersonalDetails,
                )),
            InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(RouteGenerator.updateAdditionalInfoPage),
                child: const EditProfileOptionsItemWidget(
                    title: StringResources.updateAdditionalDetails)),
            InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(RouteGenerator.updateSocialProfileLinksPage),
                child: const EditProfileOptionsItemWidget(
                    title: StringResources.updateSocialProfiles)),
            const EditProfileOptionsItemWidget(title: StringResources.updatePhone),
            const EditProfileOptionsItemWidget(title: StringResources.updateEmail),
            //const SizedBox(height: 10),
            //ButtonWidget(buttonText: StringResources.save.toUpperCase(), onPressButton: () {})
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const FetchPersonalDetails());
  }
}

class EditProfileOptionsItemWidget extends StatelessWidget {
  final String title;

  const EditProfileOptionsItemWidget({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.inputBorderColor),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ColorConstants.textColor3,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.navigate_next,
            color: ColorConstants.navigateIconColor,
            size: 28,
          )
        ],
      ),
    );
  }
}
