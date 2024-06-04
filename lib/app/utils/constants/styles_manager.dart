import 'package:flutter/widgets.dart';
import 'package:hallo_doctor_client/app/utils/constants/font_manager.dart';

//TextStyle builder method
TextStyle _getTextStyle({
  double? fontSize,
  String? fontFamily,
  Color? color,
  FontWeight? fontWeight,
  TextOverflow? overFlow = TextOverflow.ellipsis,
  TextDecoration decoration = TextDecoration.none,
}) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      decoration: decoration,
      fontWeight: fontWeight,
      overflow: overFlow);
}

class StylesManager {
  ///regular TextStyle
  static TextStyle regular(
      {double fontSize = 14,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        color: color,
        decoration: decoration,
        fontWeight: FontWeights.regular);
  }

// Bold TextStyle
  static TextStyle bold(
      {double fontSize = 14,
      Color? color,
      TextOverflow overflow = TextOverflow.ellipsis,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        decoration: decoration,
        color: color,
        overFlow: overflow,
        fontWeight: FontWeights.bold);
  }

// Medium TextStyle
  static TextStyle medium(
      {double fontSize = 14,
      Color? color,
      TextOverflow overflow = TextOverflow.ellipsis,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        overFlow: overflow,
        decoration: decoration,
        color: color,
        fontWeight: FontWeights.regular);
  }

// Light TextStyle
  static TextStyle light(
      {double fontSize = 14,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        decoration: decoration,
        overFlow: TextOverflow.visible,
        color: color,
        fontWeight: FontWeights.light);
  }

// SemiBold TextStyle
  static TextStyle semiBold(
      {double fontSize = 14,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
        fontSize: fontSize,
        decoration: decoration,
        color: color,
        fontWeight: FontWeights.semiBold);
  }

// ExtraBold TextStyle
  static TextStyle extraBold(
      {double fontSize = 14,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
      fontSize: fontSize,
      decoration: decoration,
      color: color,
      fontWeight: FontWeights.extraBold,
    );
  }

// Black TextStyle
  static TextStyle black(
      {double fontSize = 14,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
      fontSize: fontSize,
      decoration: decoration,
      color: color,
      fontWeight: FontWeights.black,
    );
  }

// Thin TextStyle
  static TextStyle thin(
      {double fontSize = 14,
      Color? color,
      TextDecoration decoration = TextDecoration.none}) {
    return _getTextStyle(
      fontSize: fontSize,
      decoration: decoration,
      color: color,
      fontWeight: FontWeights.extraBold,
    );
  }
}
