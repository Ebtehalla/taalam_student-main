import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/styles/styles.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;
  const DisplayImage(
      {super.key, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final color = Color.fromRGBO(64, 105, 225, 1);
    return Center(
        child: Stack(children: [
      buildImage(color),
      Positioned(
        child: buildEditIcon(color),
        right: 5,
        top: 105,
      )
    ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    final image = imagePath.isNotEmpty
        ? CachedNetworkImageProvider(imagePath)
        : AssetImage('assets/images/user.png');

    return CircleAvatar(
      radius: 74,
      backgroundColor: Styles.primaryColor,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 0.8,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: GestureDetector(
          child: Icon(
            Icons.edit,
            size: 20,
            color: Styles.secondaryColor,
          ),
          onTap: onPressed,
        ),
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Styles.primaryColor,
        child: child,
      ));
}
