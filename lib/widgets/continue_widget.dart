import 'package:flutter/material.dart';
import 'package:to_do/utils/theme.dart';

class ContinueWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const ContinueWidget({super.key, required this.text, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: CColors.subtitleColor),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Icon(
            icon,
            color: CColors.white,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            text,
            style: const TextStyle(color: CColors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
