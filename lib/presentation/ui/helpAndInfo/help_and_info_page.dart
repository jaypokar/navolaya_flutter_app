import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../core/color_constants.dart';
import '../../basicWidget/divider_and_space_widget.dart';

class HelpAndInfoPage extends StatelessWidget {
  const HelpAndInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          StringResources.helpAndInfo,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Image.asset(
              ImageResources.helpAndInfoImg,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          StringResources.aboutUs,
                          style: TextStyle(
                              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
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
                  const DividerAndSpaceWidget(),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          StringResources.privacyPolicy,
                          style: TextStyle(
                              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
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
                  const DividerAndSpaceWidget(),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          StringResources.termsAndCondition,
                          style: TextStyle(
                              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
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
                  const DividerAndSpaceWidget(),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          StringResources.faq,
                          style: TextStyle(
                              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
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
                  const DividerAndSpaceWidget(),
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        iconPadding: EdgeInsets.symmetric(vertical: 5)),
                    header: const Text(
                      StringResources.contactUs,
                      style:
                          TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    collapsed: const SizedBox.shrink(),
                    expanded: const ContactUsWidget(),
                  ),
                  const DividerAndSpaceWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          StringResources.phoneNumbers,
          style: TextStyle(
            color: ColorConstants.appColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          '+91 8744555555',
          style: TextStyle(
            color: ColorConstants.textColor2,
            fontSize: 13,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          StringResources.emailAddress,
          style: TextStyle(
            color: ColorConstants.appColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'business.navolaya@gmail.com',
          style: TextStyle(
            color: ColorConstants.textColor2,
            fontSize: 13,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          StringResources.socialMedia,
          style: TextStyle(
            color: ColorConstants.appColor,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Image.asset(
              ImageResources.fbIcon,
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              ImageResources.twitterIcon,
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              ImageResources.linkedinIcon,
              height: 24,
              width: 24,
            ),
          ],
        )
      ],
    );
  }
}
