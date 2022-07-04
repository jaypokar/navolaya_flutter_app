import 'package:flutter/material.dart';

import '../../../../core/string_file.dart';
import '../../../../injection_container.dart';
import '../../../basicWidget/custom_button.dart';

class BasicInfoWidget extends StatefulWidget {
  final PageController pageController;

  const BasicInfoWidget({required this.pageController, Key? key}) : super(key: key);

  @override
  State<BasicInfoWidget> createState() => _BasicInfoWidgetState();
}

class _BasicInfoWidgetState extends State<BasicInfoWidget> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                fontSize: 14,
              ),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: sl<StringFile>().enterNameHint,
                  counterText: "",
                  isDense: true,
                  contentPadding: const EdgeInsets.all(10)),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
                buttonText: sl<StringFile>().submit.toUpperCase(),
                padding: 0,
                onPressButton: () {
                  //widget.pageController.jumpToPage(1);
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
