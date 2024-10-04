import 'package:greatbrands_blott_mobile/app_config.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? placeholder;
  const InputField({super.key, this.controller, this.placeholder});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isObscured = true;
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) => setState(() => isFocused = focused),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black, fontSize: subHeadingText),
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mutedColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mutedColor),
          ),
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            color: greyColor,
            fontSize: subHeadingText,
          ),
        ),
      ),
    );
  }
}
