import 'package:flutter/material.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

class ImageLoaderWidget extends StatelessWidget {
  final Color color;

  const ImageLoaderWidget({this.color = Colors.white, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(10),
        child: Image.asset(ImageResources.appLogoLoader),
      ),
    );
  }
}
