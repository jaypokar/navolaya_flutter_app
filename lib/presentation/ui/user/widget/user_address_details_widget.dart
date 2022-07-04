import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/color_constants.dart';

class UserAddressDetailsWidget extends StatelessWidget {
  const UserAddressDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,children: [
        const Text(
          'Address Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: const [
            Icon(FontAwesomeIcons.locationArrow,color : Colors.grey,size: 15,),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                'LBS College Marg, Raja Park, Jaipur',
                  style: TextStyle(color: ColorConstants.textColor2, fontSize: 12),
                ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Current',
              style: TextStyle(color: ColorConstants.appColor, fontSize: 12),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(FontAwesomeIcons.locationArrow,color : Colors.grey,size: 15,),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                'Unnati Tower, Vidyadharnagar, Jaipur There are many variations of passages',
                  style: TextStyle(color: ColorConstants.textColor2, fontSize: 12),
                ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Permanent',
              style: TextStyle(color: ColorConstants.appColor, fontSize: 12),
            )
          ],
        ),

      ],),
    );
  }
}
