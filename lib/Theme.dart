import 'package:flutter/material.dart';

class AppColors {
  const AppColors();

  static const snow = const Color(0xfff9f9f9);
  static const lightGray = const Color(0xffD6D6D6);
  static const radicalRed = const Color(0xffF04C59);
  static const manatee = const Color(0xff8B8DA0);
}

class Themes {
  const Themes();

  static ThemeData main(BuildContext context) {
    var theme = Theme.of(context);
    return new ThemeData.light().copyWith(
        primaryColor: Colors.white,
        primaryTextTheme: new Typography(platform: theme.platform)
            .black
            .apply(displayColor: AppColors.manatee),
        primaryColorBrightness: Brightness.light,
        backgroundColor: AppColors.lightGray,
        scaffoldBackgroundColor: AppColors.snow,
        accentColor: AppColors.radicalRed);
  }
}
