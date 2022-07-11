import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/basicWidget/custom_button.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../core/color_constants.dart';
import '../../../resources/image_resources.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

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
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 116,
              width: 116,
              child: Stack(
                children: [
                  SizedBox(
                    height: 114,
                    width: 114,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/1.jpg',
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 4,
                      right: 8,
                      child: SizedBox(
                        height: 28,
                        width: 28,
                        child: RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: ColorConstants.darkRed,
                          padding: const EdgeInsets.all(0),
                          shape: const CircleBorder(),
                          child: Image.asset(
                            ImageResources.cameraIcon,
                            height: 16,
                            width: 16,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Jeneva Eberhardt',
              style: TextStyle(
                color: ColorConstants.textColor7,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const EditProfileOptionsItemWidget(title: StringResources.updatePersonalDetails),
            const EditProfileOptionsItemWidget(title: StringResources.updateAdditionalDetails),
            const EditProfileOptionsItemWidget(title: StringResources.updateSocialProfiles),
            const EditProfileOptionsItemWidget(title: StringResources.updatePhone),
            const EditProfileOptionsItemWidget(title: StringResources.updateEmail),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(buttonText: StringResources.save.toUpperCase(), onPressButton: () {})
          ],
        ),
      ),
    );
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
