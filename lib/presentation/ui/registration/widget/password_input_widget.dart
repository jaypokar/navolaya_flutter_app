import 'package:flutter/material.dart';

import '../../../../resources/string_resources.dart';

class PasswordInputWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool showOrHidePassword;
  final String hint;

  const PasswordInputWidget({
    required this.textEditingController,
    required this.showOrHidePassword,
    this.hint = StringResources.passwordHint,
    Key? key,
  }) : super(key: key);

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.all(10),
      child: TextField(
        controller: widget.textEditingController,
        obscureText: _isObscure,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            labelText: widget.hint,
            counterText: "",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              icon: widget.showOrHidePassword
                  ? Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                    )
                  : const SizedBox.shrink(),
            )),
      ),
    );
  }
}
