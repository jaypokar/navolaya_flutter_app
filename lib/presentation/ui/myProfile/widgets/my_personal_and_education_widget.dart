import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';

import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';
import '../../../../util/common_functions.dart';
import '../../user/widget/user_qualification_item_widget.dart';

class MyPersonalAndEducationWidget extends StatelessWidget {
  final Data user;

  const MyPersonalAndEducationWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconQualification = ImageResources.qualificationCapIcon;
    late final String titleQualification;
    if (user.qualification!.title != null) {
      titleQualification = user.qualification!.title!;
    } else {
      titleQualification = '';
    }

    String titleBirthDay = "";
    if (user.birthDate != null) {
      if (user.birthDate!.isNotEmpty) {
        titleBirthDay =
            '${sl<CommonFunctions>().getBirthMonth(user.birthDate ?? DateTime.now().toIso8601String())}, ${sl<CommonFunctions>().getBirthYear(user.birthDate ?? DateTime.now().toIso8601String())}';
      }
    }

    final titleGender = user.gender ?? '';

    String titlePhone = '${user.countryCode}-${user.phone}';

    String email = sl<SessionManager>().getUserDetails()!.data!.email ?? '';

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
              UserQualificationItemWidget(
                title: '${user.fromYear!} - ${user.toYear!}',
                icon: ImageResources.calenderDetailIcon,
                iconWidth: 15,
                iconHeight: 15,
              ),
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
                  height: 21,
                  width: 21,
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
          UserQualificationItemWidget(
            title: user.occupation!.area!,
            icon: ImageResources.workingSectorIcon,
            iconHeight: 18,
            iconWidth: 18,
          ),
          const SizedBox(height: 6),
          UserQualificationItemWidget(
            title: user.occupation!.title!,
            icon: ImageResources.jobIcon,
            iconHeight: 16,
            iconWidth: 16,
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              if (user.house!.isNotEmpty) ...[
                UserQualificationItemWidget(
                  title: user.house!,
                  icon: ImageResources.homeDetailIcon,
                  iconHeight: 17,
                  iconWidth: 17,
                ),
              ],
              titleBirthDay.isNotEmpty
                  ? UserQualificationItemWidget(
                      title: titleBirthDay,
                      icon: ImageResources.cakeIcon,
                      iconHeight: 18,
                      iconWidth: 18,
                    )
                  : const SizedBox.shrink(),
              titlePhone.isNotEmpty
                  ? UserQualificationItemWidget(
                      title: titlePhone,
                      icon: ImageResources.callIcon,
                      iconHeight: 15,
                      iconWidth: 15,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 6),
          email.isNotEmpty
              ? UserQualificationItemWidget(
                  title: email,
                  icon: ImageResources.emailIcon,
                  iconHeight: 16,
                  iconWidth: 16,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class JNVItemWidget extends StatelessWidget {
  final Data user;

  const JNVItemWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          ImageResources.schoolIcon,
          color: ColorConstants.userDetailIconsColor,
          height: 16,
          width: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'JNV ${user.school!.district!}',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: ColorConstants.textColor2,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Image.asset(
          ImageResources.jnvRelationIcon,
          color: ColorConstants.userDetailIconsColor,
          height: 16,
          width: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          user.relationWithJnv ?? '-',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: ColorConstants.textColor2,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Image.asset(
          ImageResources.calenderDetailIcon,
          color: ColorConstants.userDetailIconsColor,
          height: 16,
          width: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            '${user.fromYear!} - ${user.toYear!}',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: ColorConstants.textColor2,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

///Old View
/*
Padding
(
padding: const EdgeInsets.symmetric(horizontal: 15
,
vertical: 10
)
,
child: Column
(
crossAxisAlignment: CrossAxisAlignment.start,children: [
const SizedBox(height: 5
)
,
Text
(
user.fullName!,
style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24
)
,
)
,
const SizedBox(height: 10
)
,
JNVItemWidget
(
user: user,)
,
Row
(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: List<Widget>.generate
(3,
(
i) {
late final String iconData;
late final String title;
if (i == 0) {
iconData = ImageResources.schoolIcon;
title = '${user.school!.city!} ${user.school!.state!}';
} else if (i == 1) {
title = user.relationWithJnv ?? '-';
iconData = ImageResources.jnvRelationIcon;
} else {
title = '${user.fromYear!} - ${user.toYear!}';
iconData = ImageResources.calenderDetailIcon;
}
return (i == 2 || i==1)
? Expanded(child: UserQualificationItemWidget(
title: title, icon: iconData, shouldItemExpanded: true,))
    : UserQualificationItemWidget(title: title, icon: iconData);
})
,
)
,
const SizedBox(height: 10
)
,
Row
(
children: List<Widget>.generate
(2,
(
i) {
late final String iconData;
late final String title;
if (i == 0) {
iconData = ImageResources.homeDetailIcon;
title = user.house ?? '-';
} else {
iconData = ImageResources.qualificationCapIcon;
title = user.qualification!.title ?? '';
}
return i == 1
? title.isEmpty
? const SizedBox.shrink()
    : Expanded(
child: UserQualificationItemWidget(
title: title,
icon: iconData,
shouldItemExpanded: true,
))
    : UserQualificationItemWidget(title: title, icon: iconData);
})
,
)
,
const SizedBox(height: 10
)
,
Row
(
children: List<Widget>.generate
(2,
(
i) {
late final String iconData;
late final String title;
if (i == 0) {
iconData = ImageResources.workingSectorIcon;
title = user.occupation!.area ?? '-';
} else {
iconData = ImageResources.jobIcon;
title = user.occupation!.title ?? '-';
}
return i == 1
? Expanded(
child: UserQualificationItemWidget(
title: title,
icon: iconData,
shouldItemExpanded: true,
))
    : UserQualificationItemWidget(title: title, icon: iconData);
})
,
)
,
const SizedBox(height: 10
)
,
SizedBox
(
height: 20
,
child: ListView.builder(itemBuilder: (
context, i) {
late final String iconData;
String title = '';
if (i == 0) {
iconData = ImageResources.cakeIcon;
title =
'${sl<CommonFunctions>().getBirthMonth(user.birthDate ?? DateTime.now().toIso8601String())},${sl<CommonFunctions>().getBirthYear(user.birthDate ?? DateTime.now().toIso8601String())}';
} else if (i == 1) {
iconData = ImageResources.genderIcon;
title = user.gender ?? '-';
} else {
iconData = ImageResources.callIcon;
title = '${user.countryCode}-${user.phone}';
}
return title.isEmpty
? const SizedBox.shrink()
    : InkWell(
onTap: () async {
if (i == 2) {
final Uri launchUri = Uri(
scheme: 'tel',
path: title,
);
canLaunchUrl(launchUri).then((bool result) async {
await launchUrl(launchUri);
}, onError: (_) {
logger.i('Could not launch $launchUri');
sl<CommonFunctions>().showFlushBar(
context: context,
message: 'Could not launch $launchUri',
bgColor: Colors.red,
textColor: Colors.white,
);
});
}
},
child: UserQualificationItemWidget(title: title, icon: iconData));
},
itemCount: 3
,
physics: const ClampingScrollPhysics()
,
scrollDirection: Axis.horizontal,)
,
)
,
const SizedBox(height: 10
)
,
if
(
email.isNotEmpty) ...
[
Row
(
children: [
Image.asset(ImageResources.emailIcon,color: ColorConstants.userDetailIconsColor,height: 16
,
width: 16
,
)
,
const SizedBox(width: 5
,
)
,
Text
(
sl<SessionManager>
(
).getUserDetails
(
)!.
data!.
email ?? '
'
,
overflow: TextOverflow.ellipsis,style: const TextStyle(color: ColorConstants
    .textColor2,fontSize: 12,
),
),
],
)
]
]
,
)
,
);
*/
