import 'package:demo/constants/app_colors.dart';
import 'package:demo/constants/dimensions.dart';
import 'package:demo/theme/style.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static const headline1Regular = TextStyle(
      fontSize: 107.0,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.2,
      height: 135 / 107,
      color: Colors.black);

  static const headline2Regular = TextStyle(
      fontSize: 67.0,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.5,
      height: 84 / 67,
      color: Colors.black);

  static const headline3Regular = TextStyle(
      fontSize: 54.0,
      fontWeight: FontWeight.w400,
      height: 68 / 54,
      color: Colors.black);

  static const headline4Regular = TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 40 / 32,
      color: Colors.black);

  static const headline5Regular = TextStyle(
      fontFamily: FontFamilies.outfit,
      fontSize: 27.0,
      fontWeight: FontWeight.w400,
      height: 34 / 27,
      color: Colors.black);

  static const headline6Regular = TextStyle(
      fontFamily: FontFamilies.outfit,
      fontSize: 22.0,
      height: 28 / 22,
      fontWeight: FontWeight.w400,
      color: Colors.black);

  static const header2 = TextStyle(
      fontSize: 20.0,
      height: 28 / 22,
      fontWeight: FontWeight.w700,
      color: Colors.black);

  static const subtitle1Regular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      height: 25 / 18,
      letterSpacing: 0.1,
      color: Colors.black);

  static const subtitle2Regular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 22 / 16,
      letterSpacing: 0.15,
      color: Colors.black);

  static const body1Regular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 22 / 16,
      letterSpacing: 0.5,
      color: Colors.black);

  static const body2Regular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 19 / 14,
      letterSpacing: 0.25,
      color: Colors.black);

  static const buttonLargeRegular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
      height: 20 / 15,
      letterSpacing: 0.45,
      color: Colors.black);

  static const buttonMediumRegular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 19 / 14,
      letterSpacing: 0.45,
      color: Colors.black);

  static const captionRegular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: Colors.black);

  static const outfitSemiBold = TextStyle(
      fontFamily: FontFamilies.outfit,
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: Colors.white);

  static const overLineRegular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
      letterSpacing: 1,
      color: Colors.black);

  static const helperTextRegular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: Colors.black);

  static const inputTextRegular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 24 / 16,
      color: Colors.black);

  static const tooltipRegular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
      color: Colors.black);

  static const inputLabelRegular = TextStyle(
      fontFamily: FontFamilies.openSans,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 19 / 14,
      letterSpacing: 0.15,
      color: Colors.black);

  static const button = TextStyle(
    fontFamily: FontFamilies.openSans,
    fontSize: px_12,
    fontWeight: FontWeight.normal,
    color: AppColors.white,
    letterSpacing: .45,
  );

  static const headline5 = TextStyle(
    fontFamily: FontFamilies.outfit,
    fontSize: px_27,
    color: AppColors.neutralGrey900,
  );
}
