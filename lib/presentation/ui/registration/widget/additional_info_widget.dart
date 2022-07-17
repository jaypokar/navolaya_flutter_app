import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/profileImageWidget/profile_image_widget.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/widget/additional_profile_info_widget.dart';

class AdditionalInfoWidget extends StatefulWidget {
  const AdditionalInfoWidget({Key? key}) : super(key: key);

  @override
  State<AdditionalInfoWidget> createState() => _AdditionalInfoWidgetState();
}

class _AdditionalInfoWidgetState extends State<AdditionalInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: const [
          SizedBox(height: 20),
          ProfileImageWidget(),
          AdditionalProfileInfoWidget(),
        ],
      ),
    );
  }
}
