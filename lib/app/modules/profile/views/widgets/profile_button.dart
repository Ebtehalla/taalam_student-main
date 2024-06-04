import 'package:flutter/material.dart';

import '../../../../utils/styles/styles.dart';

class ProfileButton extends StatelessWidget {
  /// Icon data
  const ProfileButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onTap,
      this.hideArrowIcon = false});

  /// Icon data
  final IconData icon;

  /// Button text string
  final String text;

  /// Hide arrow icon
  final bool hideArrowIcon;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        leading: Icon(
          icon,
          size: 30,
          color: Styles.secondaryColor,
        ),
        trailing: hideArrowIcon
            ? SizedBox.shrink()
            : Icon(Icons.arrow_forward_ios_rounded,
                size: 20, color: Styles.primaryColor),
      ),
    );
  }
}
