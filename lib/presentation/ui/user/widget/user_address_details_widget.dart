import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../resources/color_constants.dart';

class UserAddressDetailsWidget extends StatelessWidget {
  final String userCurrentAddress;
  final String userPermanentAddress;

  const UserAddressDetailsWidget(
      {required this.userCurrentAddress, required this.userPermanentAddress, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Address Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          if (userCurrentAddress.isNotEmpty) ...[
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.locationArrow,
                  color: Colors.grey,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    userCurrentAddress,
                    style: const TextStyle(color: ColorConstants.textColor2, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'Current',
                  style: TextStyle(color: ColorConstants.appColor, fontSize: 12),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
          userPermanentAddress.isNotEmpty
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationArrow,
                      color: Colors.grey,
                      size: 15,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        userPermanentAddress,
                        style: const TextStyle(color: ColorConstants.textColor2, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Permanent',
                      style: TextStyle(color: ColorConstants.appColor, fontSize: 12),
                    )
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
