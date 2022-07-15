import 'package:flutter/material.dart';

import '../../../../resources/string_resources.dart';

class PasswordInputWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  const PasswordInputWidget({required this.textEditingController, Key? key}) : super(key: key);

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _isObscure = false;

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
            labelText: StringResources.passwordHint,
            counterText: "",
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility))),
      ),
    );
  }
}
