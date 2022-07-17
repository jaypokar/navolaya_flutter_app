import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/basic_info_widget.dart';

import '../../../resources/string_resources.dart';

class UpdateBasicInfoPage extends StatelessWidget {
  const UpdateBasicInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          StringResources.personalDetails,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const BasicInfoWidget(
        countryCode: '',
        mobileNumber: '',
        isEdit: true,
      ),
    );
  }
}
