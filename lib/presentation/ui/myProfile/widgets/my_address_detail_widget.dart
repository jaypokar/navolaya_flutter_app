import 'package:flutter/material.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

import '../../../../resources/string_resources.dart';

class MyAddressDetailWidget extends StatelessWidget {
  final String userCurrentAddress;
  final String userPermanentAddress;

  const MyAddressDetailWidget({
    required this.userCurrentAddress,
    required this.userPermanentAddress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            StringResources.addressDetails,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
          ),
          const SizedBox(
            height: 10,
          ),
          if (userCurrentAddress.isNotEmpty) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Image.asset(
                    ImageResources.locationIcon,
                    color: Colors.black,
                    height: 16,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    userCurrentAddress,
                    style: const TextStyle(color: ColorConstants.textColor2, fontSize: 13),
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  StringResources.current,
                  style: TextStyle(color: ColorConstants.appColor, fontSize: 13),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Image.asset(
                        ImageResources.locationIcon,
                        color: Colors.black,
                        height: 16,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        userPermanentAddress,
                        style: const TextStyle(color: ColorConstants.textColor2, fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      StringResources.permanent,
                      style: TextStyle(color: ColorConstants.appColor, fontSize: 13),
                    )
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
