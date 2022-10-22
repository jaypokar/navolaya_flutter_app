import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/data/model/app_contact_details_model.dart';
import 'package:navolaya_flutter/presentation/cubit/helpAndInfoCubit/help_and_info_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/helpAndInfo/about_us_page.dart';
import 'package:navolaya_flutter/presentation/ui/helpAndInfo/faqs_page.dart';
import 'package:navolaya_flutter/presentation/ui/helpAndInfo/privacy_policy_page.dart';
import 'package:navolaya_flutter/presentation/ui/helpAndInfo/terms_and_condition_page.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../resources/color_constants.dart';
import '../../basicWidget/divider_and_space_widget.dart';

enum SocialType { fb, insta, youtube, linkedin, twitter }

class HelpAndInfoPage extends StatelessWidget {
  const HelpAndInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HelpAndInfoCubit>().fetchAppContactDetails();
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<HelpAndInfoCubit>(context),
                                child: const AboutUsPage(),
                              )));
                    },
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<HelpAndInfoCubit>(context),
                                child: const PrivacyPolicyPage(),
                              )));
                    },
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<HelpAndInfoCubit>(context),
                                child: const TermsAndConditionPage(),
                              )));
                    },
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<HelpAndInfoCubit>(context),
                                child: const FaqsPage(),
                              )));
                    },
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
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteGenerator.supportChatPage);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          StringResources.chatWithSupport,
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringResources.contactUs,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const ContactUsWidget(),
                  /*ExpandablePanel(
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
                  ),*/
                  const SizedBox(height: 15),
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
    return BlocBuilder<HelpAndInfoCubit, HelpAndInfoState>(
      buildWhen: (_, state) => state is LoadAppContactDetailsState,
      builder: (_, state) {
        if (state is LoadAppContactDetailsState) {
          logger.i('the address : ${state.appContactDetails.officialAddress}');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.appContactDetails.officialPhone!.isNotEmpty) ...[
                const Text(
                  StringResources.phoneNumbers,
                  style: TextStyle(color: ColorConstants.appColor, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  state.appContactDetails.officialPhone ?? '-',
                  style: const TextStyle(color: ColorConstants.textColor2, fontSize: 13),
                ),
                const SizedBox(height: 15),
              ],
              if (state.appContactDetails.officialEmail!.isNotEmpty) ...[
                const Text(
                  StringResources.email,
                  style: TextStyle(color: ColorConstants.appColor, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.appContactDetails.officialEmail ?? '-',
                  style: const TextStyle(color: ColorConstants.textColor2, fontSize: 13),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
              if (state.appContactDetails.officialAddress!.isNotEmpty) ...[
                const Text(
                  StringResources.address,
                  style: TextStyle(color: ColorConstants.appColor, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.appContactDetails.officialAddress ?? '-',
                  style: const TextStyle(color: ColorConstants.textColor2, fontSize: 13),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
              const Text(
                StringResources.followUsOn,
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
                  manageSocialWidget(state.appContactDetails, SocialType.fb),
                  const SizedBox(width: 15),
                  manageSocialWidget(state.appContactDetails, SocialType.linkedin),
                  const SizedBox(width: 15),
                  manageSocialWidget(state.appContactDetails, SocialType.youtube),
                  const SizedBox(width: 15),
                  manageSocialWidget(state.appContactDetails, SocialType.insta),
                  const SizedBox(width: 15),
                  manageSocialWidget(state.appContactDetails, SocialType.twitter),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget manageSocialWidget(AppContactDetails details, SocialType socialType) {
    if (details.socialMediaLinks != null) {
      if (socialType == SocialType.fb) {
        if (details.socialMediaLinks!.facebook!.isNotEmpty) {
          return InkWell(
            onTap: () {
              launchUrlString(details.socialMediaLinks!.facebook.toString());
            },
            child: Image.asset(
              ImageResources.fbIcon,
              height: 32,
              width: 32,
            ),
          );
        }
      } else if (socialType == SocialType.insta) {
        if (details.socialMediaLinks!.instagram!.isNotEmpty) {
          return InkWell(
            onTap: () {
              launchUrlString(details.socialMediaLinks!.instagram.toString());
            },
            child: Image.asset(
              ImageResources.instaIcon,
              height: 32,
              width: 32,
            ),
          );
        }
      } else if (socialType == SocialType.linkedin) {
        if (details.socialMediaLinks!.linkedin!.isNotEmpty) {
          return InkWell(
            onTap: () {
              launchUrlString(details.socialMediaLinks!.linkedin.toString());
            },
            child: Image.asset(
              ImageResources.linkedinIcon,
              height: 32,
              width: 32,
            ),
          );
        }
      } else if (socialType == SocialType.youtube) {
        if (details.socialMediaLinks!.youtube!.isNotEmpty) {
          return InkWell(
            onTap: () {
              launchUrlString(details.socialMediaLinks!.youtube.toString());
            },
            child: Image.asset(
              ImageResources.youtubeIcon,
              height: 32,
              width: 32,
            ),
          );
        }
      } else if (socialType == SocialType.twitter) {
        if (details.socialMediaLinks!.twitter!.isNotEmpty) {
          return InkWell(
            onTap: () {
              launchUrlString(details.socialMediaLinks!.twitter.toString());
            },
            child: Image.asset(
              ImageResources.twitterIcon,
              height: 32,
              width: 32,
            ),
          );
        }
      }
    }

    return const SizedBox.shrink();
  }
}
