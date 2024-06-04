import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//constant color
const primaryColor = Color(0xFF0d9cf4);
const secondaryColor = Color(0xFF00A9FF);
const mBackgroundColor = Color(0xFFFAFAFA);
const mGreyColor = Color(0xFFB4B0B0);
const mTitleColor = Color(0xFF23374D);
const mSubtitleColor = Color(0xFF8E8E8E);
const mBorderColor = Color(0xFFE8E8F3);
const mFillColor = Color(0xFFFFFFFF);
const mCardTitleColor = Color(0xFF2E4ECF);
const mCardSubtitleColor = mTitleColor;

const defaultPadding = 16.0;

//constant Style
var titleStyle = TextStyle(fontWeight: FontWeight.w600);

var titleLongStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w900);

// Style for Home Profile Header
var mWelcomeTitleStyle =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 10, color: mSubtitleColor);
var mUsernameTitleStyle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: mTitleColor);
var doctorNameTextStyle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: mTitleColor);
var specialistTextStyle =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 10, color: mSubtitleColor);
var appbarTextStyle =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: mTitleColor);

// Text Style for Doctor Category
var doctorCategoryTextStyle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: mTitleColor);

// Text Style for Doctor Card
var doctorNameStyle =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: mTitleColor);
var priceTextStyle =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 15, color: mSubtitleColor);
var priceNumberTextStyle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 25, color: secondaryColor);

//Text Style Detail Doctor
var titleTextStyle =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: mTitleColor);
var subTitleTextStyle =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: mSubtitleColor);
var doctorCategoryStyle =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: mSubtitleColor);

//Text Style for Detail Order
var tableColumHeader =
    TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: mTitleColor);

var tableCellText =
    TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: mTitleColor);
