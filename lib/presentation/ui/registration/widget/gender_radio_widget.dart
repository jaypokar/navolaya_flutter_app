import 'package:flutter/material.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

// ignore: must_be_immutable
class GenderRadioWidget extends StatefulWidget {
  String? gender;
  final Function? onValueSelect;

  GenderRadioWidget({this.gender, this.onValueSelect, Key? key}) : super(key: key);

  @override
  State<GenderRadioWidget> createState() => _GenderRadioWidgetState();
}

class _GenderRadioWidgetState extends State<GenderRadioWidget> {
  String? genderValue;

  @override
  void initState() {
    super.initState();
    genderValue = widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Radio<String>(
          value: StringResources.male,
          groupValue: genderValue!,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            if (widget.onValueSelect != null) {
              widget.onValueSelect!(value);
            }
            setState(() {
              genderValue = value!;
            });
          },
        ),
        const Text(StringResources.male),
        const Spacer(),
        Radio<String>(
          value: StringResources.female,
          groupValue: genderValue!,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            genderValue = value!;
            if (widget.onValueSelect != null) {
              widget.onValueSelect!(value);
            }
            setState(() {});
          },
        ),
        const Text(StringResources.female),
        const Spacer(),
        Radio<String>(
          value: StringResources.other,
          groupValue: genderValue!,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (value) {
            genderValue = value!;
            if (widget.onValueSelect != null) {
              widget.onValueSelect!(value);
            }
            setState(() {});
          },
        ),
        const Text(StringResources.other),
      ],
    );
  }
}
