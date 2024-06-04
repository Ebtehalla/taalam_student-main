import 'package:flutter/material.dart';

import '../../../../utils/styles/styles.dart';

class IconCard extends StatelessWidget {
  final IconData? iconData;
  final String? text;
  const IconCard({super.key, this.iconData, this.text, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Styles.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: Icon(
                iconData,
                size: 30,
                color: Styles.secondaryColor,
              ),
              onPressed: onTap,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              text!,
              style: TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
