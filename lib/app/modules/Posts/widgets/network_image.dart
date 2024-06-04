import 'shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCashedImage extends StatelessWidget {
  final String imageUrl;
  final double? radius, width, height;
  final BoxFit? fit;
  final Color? borderColor;
  final double? borderWidth;
  final bool isCircular;

  const AppCashedImage({
    required this.imageUrl,
    this.width = 200,
    this.height = 200,
    this.radius,
    this.fit,
    this.borderColor,
    this.borderWidth,
    this.isCircular = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: borderColor == null
              ? null
              : Border.all(
                  color: borderColor ?? Theme.of(context).primaryColor,
                  width: borderWidth ?? 0),
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              isCircular ? null : BorderRadius.circular(radius ?? 12)),
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircular
                ? null
                : BorderRadius.only(
                    topLeft: Radius.circular(radius ?? 12),
                    topRight: Radius.circular(radius ?? 12),
                    bottomLeft: Radius.circular(radius ?? 12),
                    bottomRight: Radius.circular(radius ?? 12),
                  ),
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
              // colorFilter:
              //     const ColorFilter.mode(Colors.red, BlendMode.colorBurn),
            ),
          ),
        ),
        imageUrl: imageUrl,
        width: width,
        height: height,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const Shimmer(),
        errorWidget: (context, url, error) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircular
                ? null
                : BorderRadius.only(
                    topLeft: Radius.circular(radius ?? 12),
                    topRight: Radius.circular(radius ?? 12),
                    bottomLeft: Radius.circular(radius ?? 12),
                    bottomRight: Radius.circular(radius ?? 12),
                  ),
          ),
          child: const Icon(Icons.error),
        ),
      ),
    );
  }
}
