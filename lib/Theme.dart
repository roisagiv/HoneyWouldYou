import 'package:flutter/material.dart';

///
class AppColors {
  ///
  const AppColors();

  ///
  static const Color snow = const Color(0xfff9f9f9);

  ///
  static const Color lightGray = const Color(0xffD6D6D6);

  ///
  static const Color radicalRed = const Color(0xffF04C59);

  ///
  static const Color manatee = const Color(0xff8B8DA0);
}

///
class AppThemes {
  ///
  const AppThemes();

  ///
  static ThemeData main(BuildContext context) {
    final theme = Theme.of(context);
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

///
class AppDimens {
  ///
  const AppDimens();

  ///
  static const double screenEdgeMargin = 16.0;

  ///
  static const double screenContentMargin = 72.0;

  ///
  static const double toolBarHeight = 24.0;

  ///
  static const double subtitleHeight = 20.0;

  ///
  static const double bottomNavigationBarHeight = 56.0;

  ///
  static const double listItemHeight = 60.0;

  ///
  static const double listViewPadding =
      (screenContentMargin - screenEdgeMargin) / 2;
}
