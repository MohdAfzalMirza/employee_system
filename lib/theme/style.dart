import 'dart:io';

import 'package:demo/constants/app_colors.dart';
import 'package:demo/constants/dimensions.dart';
import 'package:demo/theme/textTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension CustomTextTheme on TextTheme {
  TextStyle get headline1Regular => TextStyles.headline1Regular;

  TextStyle get headline1Light =>
      headline1Regular.copyWith(fontWeight: FontWeight.w300);

  TextStyle get headline1SemiBold =>
      headline1Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get headline1Bold =>
      headline1Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get headline2Regular => TextStyles.headline2Regular;

  TextStyle get headline2Light =>
      headline2Regular.copyWith(fontWeight: FontWeight.w300);

  TextStyle get headline2SemiBold =>
      headline2Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get headline2Bold =>
      headline2Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get headline3Regular => TextStyles.headline3Regular;

  TextStyle get captionSemiBold =>
      captionRegular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get headline3SemiBold =>
      headline3Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get headline3Bold =>
      headline3Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get headline4Regular => TextStyles.headline4Regular;

  TextStyle get headline4SemiBold =>
      headline4Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get headline4Bold =>
      headline4Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get headline5Regular => TextStyles.headline5Regular;

  TextStyle get headline5SemiBold =>
      headline5Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get headline5Bold =>
      headline5Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get headline6Regular => TextStyles.headline6Regular;

  TextStyle get header2 => TextStyles.header2;

  TextStyle get headline6SemiBold =>
      headline6Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get headline6Medium =>
      headline6Regular.copyWith(fontWeight: FontWeight.w500);

  TextStyle get headline6Bold =>
      headline6Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get subtitle1Regular => TextStyles.subtitle1Regular;

  TextStyle get subtitle1SemiBold =>
      subtitle1Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get subtitle1Bold =>
      subtitle1Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get subtitle2Regular => TextStyles.subtitle2Regular;

  TextStyle get subtitle2SemiBold =>
      subtitle2Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get subtitle2Bold =>
      subtitle2Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get body1Regular => TextStyles.body1Regular;

  TextStyle get body1SemiBold =>
      body1Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get body1Bold => body1Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get body2Regular => TextStyles.body2Regular;

  TextStyle get body2SemiBold =>
      body2Regular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get body2Bold => body2Regular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get buttonLargeRegular => TextStyles.buttonLargeRegular;

  TextStyle get buttonLargeSemiBold =>
      buttonLargeRegular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get buttonLargeBold =>
      buttonLargeRegular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get buttonMediumRegular => TextStyles.buttonMediumRegular;

  TextStyle get buttonMediumSemiBold =>
      buttonMediumRegular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get buttonMediumBold =>
      buttonMediumRegular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get buttonSmallRegular => TextStyles.button.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.colorPrimary600,
        fontSize: px_13,
        letterSpacing: .45,
      );

  TextStyle get buttonSmallSemiBold => buttonSmallRegular.copyWith(
        fontWeight: FontWeight.w600,
      );

  TextStyle get captionRegular => TextStyles.captionRegular;

  TextStyle get outfitSemiBold => TextStyles.outfitSemiBold;

  TextStyle get captionRegularSemiBold =>
      captionRegular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get captionRegularBold =>
      captionRegular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get overLineRegular => TextStyles.overLineRegular;

  TextStyle get overLineSemiBold =>
      overLineRegular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get overLineBold =>
      overLineRegular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get helperTextRegular => TextStyles.helperTextRegular;

  TextStyle get helperTextSemiBold =>
      helperTextRegular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get helperTextBold =>
      helperTextRegular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get inputTextRegular => TextStyles.inputTextRegular;

  TextStyle get inputTextSemiBold =>
      inputTextRegular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get inputTextBold =>
      inputTextRegular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get tooltipRegular => TextStyles.tooltipRegular;

  TextStyle get tooltipSemiBold =>
      tooltipRegular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get tooltipBold =>
      tooltipRegular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get inputLabelRegular => TextStyles.inputLabelRegular;

  TextStyle get inputLabelSemiBold =>
      inputLabelRegular.copyWith(fontWeight: FontWeight.w600);

  TextStyle get inputLabelBold =>
      inputLabelRegular.copyWith(fontWeight: FontWeight.w700);

  TextStyle get headline5Medium =>
      TextStyles.headline5.copyWith(fontWeight: FontWeight.w500);
}

class FontFamilies {
  static const outfit = 'Outfit';
  static const outfitBold = 'Outfit-Bold';
  static const outfitRegular = 'Outfit-Regular';
  static const outfitMedium = 'Outfit-Medium';
  static const outfitSemiBold = 'Outfit-SemiBold';
  static const outfitLight = 'Outfit-Light';
  static const openSans = 'OpenSans';
  static const openSansRegular = 'OpenSans-Regular';
  static const openSansBold = 'OpenSans-Bold';
  static const openSansSemiBold = 'OpenSans-SemiBold';
}

final theme = ThemeData(
  primarySwatch: MaterialColor(
    AppColors.colorPrimary500.value,
    const <int, Color>{
      50: AppColors.colorPrimary50,
      100: AppColors.colorPrimary100,
      200: AppColors.colorPrimary200,
      300: AppColors.colorPrimary300,
      400: AppColors.colorPrimary400,
      500: AppColors.colorPrimary500,
      600: AppColors.colorPrimary600,
      700: AppColors.colorPrimary700,
      800: AppColors.colorPrimary800,
      900: AppColors.colorPrimary900,
      1000: AppColors.colorPrimary1000
    },
  ),
  fontFamily: FontFamilies.outfitRegular,
  textTheme: const TextTheme(
    displayLarge: TextStyles.headline1Regular,
    displayMedium: TextStyles.headline2Regular,
    displaySmall: TextStyles.headline3Regular,
    headlineMedium: TextStyles.headline6Regular,
    headlineSmall: TextStyles.headline5Regular,
    titleLarge: TextStyles.headline6Regular,
    bodyLarge: TextStyles.body1Regular,
    bodyMedium: TextStyles.body2Regular,
    labelLarge: TextStyles.buttonMediumRegular,
    bodySmall: TextStyles.captionRegular,
    labelSmall: TextStyles.overLineRegular,
  ),
);

extension ContextHelper on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Size get displaySize => MediaQuery.of(this).size;

  double get displayWidth => MediaQuery.of(this).size.width;

  double get displayHeight => MediaQuery.of(this).size.height;

  SystemUiOverlayStyle systemUiOverlayStyle(Color color,
      {Brightness brightness = Brightness.dark}) {
    Brightness iosBrightness = Brightness.dark;
    if (brightness == Brightness.dark) {
      iosBrightness = Brightness.light;
    }

    return Platform.isIOS
        ? SystemUiOverlayStyle(
            statusBarColor: color,
            statusBarIconBrightness: iosBrightness,
            statusBarBrightness: iosBrightness)
        : SystemUiOverlayStyle(
            statusBarColor: color,
            statusBarIconBrightness: brightness,
            statusBarBrightness: brightness,
          );
  }
}
