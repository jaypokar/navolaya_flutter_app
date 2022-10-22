import 'package:flutter/material.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';

import '../../../../resources/image_resources.dart';

class UserHomePersonalInfoWidget extends StatelessWidget {
  final UserDataModel user;
  final bool isNearBy;

  const UserHomePersonalInfoWidget({required this.user, this.isNearBy = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleJnv = user.relationWithJnv!;
    const iconJnv = ImageResources.jnvRelationIcon;

    final titleGender = user.gender!;
    const iconGender = ImageResources.genderIcon;

    final titleYear = '${user.fromYear}-${user.toYear}';
    const iconCalender = ImageResources.calenderIcon;
    return Row(
      children: [
        Image.asset(
          iconJnv,
          height: 13,
          width: 13,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          titleJnv,
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
        const SizedBox(
          width: 5,
        ),
        /*Image.asset(
          iconGender,
          height: 12,
          width: 11,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          titleGender,
          style: const TextStyle(color: Colors.white, fontSize: 10),
        ),
        const SizedBox(
          width: 4,
        ),*/

        Expanded(child: showNearByWidgetOrBatchYearWidget(iconCalender, titleYear))
      ],
    );
  }

  Widget showNearByWidgetOrBatchYearWidget(String iconCalender, String titleYear) {
    if (isNearBy) {
      return user.distance == null
          ? const SizedBox.shrink()
          : Row(
              children: [
                Image.asset(
                  ImageResources.locationIcon,
                  height: 13,
                  width: 13,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    '${(user.distance as double).toStringAsFixed(1)} km',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 11, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            );
    }

    return Row(
      children: [
        Image.asset(
          iconCalender,
          height: 13,
          width: 13,
          color: Colors.white,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            titleYear,
            style:
                const TextStyle(color: Colors.white, fontSize: 11, overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }
}
