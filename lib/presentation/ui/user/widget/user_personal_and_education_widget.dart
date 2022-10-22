import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_qualification_item_widget.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';

class UserPersonalAndEducationWidget extends StatelessWidget {
  final UserDataModel user;
  final bool isNearBy;

  const UserPersonalAndEducationWidget({required this.user, required this.isNearBy, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displaySettings = user.displaySettings!;
    const iconQualification = ImageResources.qualificationCapIcon;
    String titleQualification = '';
    if (user.qualification != null) {
      if (user.qualification!.title != null) {
        titleQualification = user.qualification!.title!;
      }
    }

    String titleOccupationArea = '';
    if (user.occupation != null) {
      titleOccupationArea = user.occupation!.area!;
    }

    String titleOccupationTitle = '';
    if (user.occupation != null) {
      titleOccupationTitle = user.occupation!.title!;
    }

    String titleBirthDay = '';

    if (user.birthDate != null) {
      if (user.birthDate!.isNotEmpty) {
        if (displaySettings.birthDayMonth == 'all' ||
            (user.isConnected! && displaySettings.birthDayMonth == 'my_connections')) {
          titleBirthDay = sl<CommonFunctions>()
              .getBirthMonth(user.birthDate ?? DateTime.now().toIso8601String());
        }
        if (displaySettings.birthYear == 'all' ||
            (user.isConnected! && displaySettings.birthYear == 'my_connections')) {
          if (titleBirthDay.isEmpty) {
            titleBirthDay = sl<CommonFunctions>()
                .getBirthYear(user.birthDate ?? DateTime.now().toIso8601String());
          } else {
            titleBirthDay =
                '$titleBirthDay,${sl<CommonFunctions>().getBirthYear(user.birthDate ?? DateTime.now().toIso8601String())}';
          }
        }
      }
    }

    final titleGender = user.gender ?? '';

    String titlePhone = '';
    logger.i('the user phone is :${user.phone}');

    if (displaySettings.phone == 'all' ||
        (user.isConnected! && displaySettings.phone == 'my_connections')) {
      if (user.phone!.isNotEmpty) {
        titlePhone = '${user.countryCode}-${user.phone}';
      }
    }

    String batchYears = '';
    if (user.fromYear != null) {
      batchYears = '${user.fromYear!} - ${user.toYear!}';
    }

    String titleHouse = '';
    if (user.house != null) {
      titleHouse = user.house!;
    }
    String email = '';
    if (displaySettings.email == 'all' ||
        (user.isConnected! && displaySettings.email == 'my_connections')) {
      if (user.email!.isNotEmpty) {
        email = user.email!;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            user.fullName!,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
          ),
          const SizedBox(height: 10),
          UserQualificationItemWidget(
            title: 'JNV ${user.school!.city!}, ${user.school!.district!} (${user.school!.state!})',
            icon: ImageResources.schoolIcon,
            shouldItemExpanded: true,
            iconWidth: 16,
            iconHeight: 16,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              UserQualificationItemWidget(
                title: user.relationWithJnv!,
                icon: ImageResources.jnvRelationIcon,
                iconWidth: 16,
                iconHeight: 16,
              ),
              batchYears.isNotEmpty
                  ? UserQualificationItemWidget(
                      title: batchYears,
                      icon: ImageResources.calenderDetailIcon,
                      iconWidth: 15,
                      iconHeight: 15,
                    )
                  : const SizedBox.shrink(),
              titleGender.isNotEmpty
                  ? UserQualificationItemWidget(
                      title: user.gender!,
                      icon: ImageResources.genderIcon,
                      iconWidth: 16,
                      iconHeight: 16,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 4),
          if (titleQualification.isNotEmpty) ...[
            Row(
              children: [
                Image.asset(
                  iconQualification,
                  color: ColorConstants.userDetailIconsColor,
                  height: 22,
                  width: 22,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: AutoSizeText(
                    user.qualification!.title!,
                    softWrap: true,
                    wrapWords: true,
                    maxLines: 1,
                    minFontSize: 12,
                    style: const TextStyle(
                        color: ColorConstants.textColor3,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(height: 5),
          ] else
            const SizedBox.shrink(),
          titleOccupationArea.isNotEmpty
              ? UserQualificationItemWidget(
                  title: user.occupation!.area!,
                  icon: ImageResources.workingSectorIcon,
                  iconHeight: 18,
                  iconWidth: 18,
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 6),
          titleOccupationTitle.isNotEmpty
              ? UserQualificationItemWidget(
                  title: user.occupation!.title!,
                  icon: ImageResources.jobIcon,
                  iconHeight: 17,
                  iconWidth: 17,
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 7),
          Row(
            children: [
              if (titleHouse.isNotEmpty) ...[
                UserQualificationItemWidget(
                  title: user.house!,
                  icon: ImageResources.homeDetailIcon,
                  iconHeight: 18,
                  iconWidth: 18,
                ),
              ],
              titleBirthDay.isNotEmpty
                  ? UserQualificationItemWidget(
                      title: titleBirthDay,
                      icon: ImageResources.cakeIcon,
                      iconHeight: 19,
                      iconWidth: 19,
                    )
                  : const SizedBox.shrink(),
              titlePhone.isNotEmpty
                  ? InkWell(
                      onTap: () async {
                        if (!await launchUrlString('tel:$titlePhone')) {
                          sl<CommonFunctions>().showFlushBar(
                              context: context,
                              message: 'Could not launch $titlePhone',
                              bgColor: ColorConstants.messageErrorBgColor);
                        }
                      },
                      child: UserQualificationItemWidget(
                        title: titlePhone,
                        icon: ImageResources.callIcon,
                        iconHeight: 15,
                        iconWidth: 15,
                      ),
                    )
                  : const SizedBox.shrink(),
              Expanded(child: showNearByWidgetOrBatchYearWidget())
            ],
          ),
          const SizedBox(height: 7),
          email.isNotEmpty
              ? UserQualificationItemWidget(
                  title: email,
                  icon: ImageResources.emailIcon,
                  iconHeight: 16,
                  iconWidth: 16,
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget showNearByWidgetOrBatchYearWidget() {
    logger.i('the distance is ${user.distance}');
    if (isNearBy) {
      return user.distance == null
          ? const SizedBox.shrink()
          : Row(
              children: [
                Image.asset(
                  ImageResources.locationDetailIcon,
                  height: 18,
                  width: 18,
                  color: ColorConstants.userDetailIconsColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    '${(user.distance as double).toStringAsFixed(1)} km',
                    style: const TextStyle(
                        color: ColorConstants.textColor2,
                        fontSize: 13,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            );
    }

    return const SizedBox.shrink();
  }
}
