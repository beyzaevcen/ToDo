import 'package:flutter/material.dart';
import 'package:to_do/utils/theme.dart';

class SignUpWidget extends StatelessWidget {
  final String text;
  final TextEditingController controller;

  const SignUpWidget({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: CColors.white,
          focusedErrorBorder: const OutlineInputBorder(gapPadding: 0),
          alignLabelWithHint: true,
          border: InputBorder.none,
          hintText: text,
        ),
      ),
    );
  }
}
