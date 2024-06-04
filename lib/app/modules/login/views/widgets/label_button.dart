import 'package:flutter/material.dart';

import '../../../../utils/styles/styles.dart';

class LabelButton extends StatelessWidget {
  const LabelButton(
      {super.key, required this.onTap, required this.title, this.subTitle = ''});
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              subTitle,
              style: TextStyle(
                  color: Styles.primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
