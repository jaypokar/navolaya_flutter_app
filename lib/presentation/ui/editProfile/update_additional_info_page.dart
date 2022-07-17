import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/widget/additional_profile_info_widget.dart';

import '../../../resources/string_resources.dart';

class UpdateAdditionalInfoPage extends StatelessWidget {
  const UpdateAdditionalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          StringResources.additionalDetail,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Padding(
          padding: EdgeInsets.all(20),
          child: AdditionalProfileInfoWidget(
            isEdit: true,
          )),
    );
  }
}
