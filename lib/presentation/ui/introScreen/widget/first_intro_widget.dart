import 'package:flutter/material.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';

class FirstIntroWidget extends StatelessWidget {
  final String image;
  final String title;
  final String desc;

  const FirstIntroWidget({required this.image, required this.title, required this.desc, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
            height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.80,
            /*fit: BoxFit.cover,*/
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w800, color: ColorConstants.textColor1),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorConstants.textColor2,
                height: 1.4),
          ),
        ),
      ],
    );
  }
}
