import 'package:flutter/material.dart';

import '../../../../resources/string_resources.dart';

// ignore: must_be_immutable
class VerifyIdentityRadioWidget extends StatefulWidget {
  String? verificationOption;
  final Function? onValueSelect;
  final ValueNotifier<String> jnvNoteNotifier;

  VerifyIdentityRadioWidget({
    required this.verificationOption,
    required this.onValueSelect,
    required this.jnvNoteNotifier,
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyIdentityRadioWidget> createState() => _VerifyIdentityRadioWidgetState();
}

class _VerifyIdentityRadioWidgetState extends State<VerifyIdentityRadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Radio<String>(
              value: StringResources.verifyByUserReference,
              groupValue: widget.verificationOption,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              onChanged: (value) {
                widget.verificationOption = value!;
                if (widget.onValueSelect != null) {
                  widget.onValueSelect!(value);
                }
                widget.jnvNoteNotifier.value = StringResources.jnvNote1;
                setState(() {});
              },
            ),
            const Text(StringResources.verifyByUserReference),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Radio<String>(
              value: StringResources.verifyByDocument,
              groupValue: widget.verificationOption,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              onChanged: (value) {
                widget.verificationOption = value!;
                if (widget.onValueSelect != null) {
                  widget.onValueSelect!(value);
                }
                widget.jnvNoteNotifier.value = StringResources.jnvNote2;
                setState(() {});
              },
            ),
            const Text(StringResources.verifyByDocument),
          ],
        )
      ],
    );
  }
}
