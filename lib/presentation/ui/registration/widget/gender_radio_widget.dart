import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenderRadioWidget extends StatefulWidget {
  String? gender;
  final Function? onValueSelect;

  GenderRadioWidget({this.gender, this.onValueSelect, Key? key}) : super(key: key);

  @override
  State<GenderRadioWidget> createState() => _GenderRadioWidgetState();
}

class _GenderRadioWidgetState extends State<GenderRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Radio<String>(
          value: "Male",
          groupValue: widget.gender,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            setState(() {
              widget.gender = value!;
            });
          },
        ),
        const Text("Male"),
        Radio<String>(
          value: "Female",
          groupValue: widget.gender,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            widget.gender = value!;
            if (widget.onValueSelect != null) {
              widget.onValueSelect!(value);
            }
            setState(() {});
          },
        ),
        const Text("Female"),
        Radio<String>(
          value: "Other",
          groupValue: widget.gender,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            setState(() {
              widget.gender = value!;
            });
          },
        ),
        const Text("Other"),
      ],
    );
  }
}