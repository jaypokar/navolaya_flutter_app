import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';

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
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '0',
          style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4.0,
              trackShape: CustomTrackShape(),
              activeTrackColor: ColorConstants.sliderTrackColor,
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
              valueIndicatorTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
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
        const SizedBox(
          width: 10,
        ),
        const Text(
          '100',
          style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
