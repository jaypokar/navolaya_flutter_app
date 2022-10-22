import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

// ignore: must_be_immutable
class CustomSliderWidget extends StatefulWidget {
  double sliderValue;
  final Function onValueChange;

  CustomSliderWidget({required this.sliderValue, required this.onValueChange, Key? key})
      : super(key: key);

  @override
  State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  @override
  void initState() {
    super.initState();
    logger.i('the sliderValue : ${widget.sliderValue}');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: const Offset(0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '0',
                    style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    '100',
                    style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2.0,
                  trackShape: CustomTrackShape(),
                  activeTrackColor: ColorConstants.appColor,
                  inactiveTrackColor: ColorConstants.sliderTrackColor,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 12.0,
                    pressedElevation: 10.0,
                  ),
                  thumbColor: ColorConstants.appColor,
                  overlayColor: ColorConstants.appColor.withOpacity(0.2),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 22.0),
                  tickMarkShape: const RoundSliderTickMarkShape(),
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent,
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: ColorConstants.appColor,
                  valueIndicatorTextStyle: const TextStyle(
                      color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                child: Slider(
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  value: widget.sliderValue,
                  label: '${widget.sliderValue.round()} Km',
                  onChanged: (value) {
                    widget.onValueChange(value);
                    setState(() {
                      widget.sliderValue = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Positioned(
            left: 0,
            bottom: 12,
            child: Image.asset(
              ImageResources.rangeBarIcon,
              height: 22,
            )),
        Positioned(
            right: 0,
            bottom: 12,
            child: Image.asset(
              ImageResources.rangeBarIcon,
              height: 22,
            )),
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = true,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
