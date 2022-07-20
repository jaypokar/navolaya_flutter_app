import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/presentation/basicWidget/custom_button.dart';
import 'package:navolaya_flutter/presentation/cubit/pageIndicatorCubit/page_indicator_page_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/introScreen/widget/indicator_widget.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import 'widget/first_intro_widget.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: PageView(
              onPageChanged: (int page) => context.read<PageIndicatorPageCubit>().changePage(page),
              controller: _controller,
              children: const [
                FirstIntroWidget(),
                FirstIntroWidget(),
                FirstIntroWidget(),
              ],
            ),
          ),
          const IndicatorWidget(),
          Padding(
              padding: const EdgeInsets.all(20),
              child: ButtonWidget(
                  buttonText: StringResources.getStarted,
                  onPressButton: () {
                    Navigator.of(context).pushReplacementNamed(RouteGenerator.authenticationPage);
                  })),
        ],
      ),
    );
  }

}
