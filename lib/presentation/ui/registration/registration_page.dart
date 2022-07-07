import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/additional_info_widget.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/basic_info_widget.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/step_indicator_widget.dart';

import '../../../core/color_constants.dart';
import '../../../resources/image_resources.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final PageController _controller = PageController();
  final indicatorNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(
                    ImageResources.imgBg,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Image.asset(
                ImageResources.textLogo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              const Center(
                  child: SizedBox(
                      width: 50,
                      child: Divider(
                        color: ColorConstants.greyColor,
                        thickness: 5,
                      ))),
              StepIndicatorWidget(indicatorNotifier: indicatorNotifier),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 7,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) {
                indicatorNotifier.value = page;
              },
              controller: _controller,
              children: [
                BasicInfoWidget(pageController: _controller),
                const AdditionalInfoWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
