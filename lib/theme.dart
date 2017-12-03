import 'package:flutter/material.dart';

///
class FontFamilies {
  ///
  const FontFamilies();

  ///
  static const String nunito = 'Nunito';

  ///
  static const String poppins = 'Poppins';

  ///
  static const String notoSans = 'NotoSans';

  ///
  static const String varelaRound = 'VarelaRound';

  ///
  static const String montserrat = 'Montserrat';

  ///
  static const String appDefault = varelaRound;
}

///
class AppColors {
  ///
  const AppColors();

  ///
  static const Color snow = const Color(0xfff9f9f9);

  ///
  static const Color lightGray = const Color(0xffD8D8D8);

  ///
  static const Color darkGray = const Color(0xff818395);

  ///
  static Color black = Colors.black87;

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
    final ThemeData theme = Theme.of(context);
    return new ThemeData.light().copyWith(
        primaryColor: Colors.white,
        // primaryTextTheme: new Typography(platform: theme.platform).black,
        // .apply(displayColor: AppColors.manatee),
        primaryColorBrightness: Brightness.light,
        backgroundColor: AppColors.lightGray,
        scaffoldBackgroundColor: AppColors.snow,
        accentColor: AppColors.radicalRed,
        textTheme: theme.textTheme.copyWith(
            title: theme.textTheme.title.copyWith(
              color: AppColors.manatee,
              fontFamily: FontFamilies.appDefault,
            ),
            body1: theme.textTheme.body1.copyWith(
              fontFamily: FontFamilies.appDefault,
            ),
            body2: theme.textTheme.body2.copyWith(
              fontFamily: FontFamilies.appDefault,
            ),
            caption: theme.textTheme.caption.copyWith(
              fontFamily: FontFamilies.appDefault,
            ),
            headline: theme.textTheme.headline.copyWith(
              fontFamily: FontFamilies.appDefault,
            ),
            button: theme.textTheme.button.copyWith(
              fontFamily: FontFamilies.appDefault,
            ),
            subhead: theme.textTheme.subhead.copyWith(
              color: AppColors.darkGray,
              fontFamily: FontFamilies.appDefault,
            ),
            display1: theme.textTheme.display1.copyWith(
              color: AppColors.black,
              fontFamily: FontFamilies.appDefault,
            )));
  }
}

///
class AppTextStyles {
  ///
  const AppTextStyles();

  ///
  static TextStyle appBarTitle(BuildContext context) =>
      Theme.of(context).textTheme.display1;

  ///
  static TextStyle appBarSubtitle(BuildContext context) =>
      Theme.of(context).textTheme.subhead;

  ///
  static TextStyle textErrorMessage(BuildContext context) =>
      Theme.of(context).textTheme.caption.copyWith(color: AppColors.radicalRed);

  ///
  static TextStyle buttonText(BuildContext context) =>
      Theme.of(context).textTheme.button.copyWith(color: AppColors.snow);

  ///
  static TextStyle buttonTextDark(BuildContext context) =>
      Theme.of(context).textTheme.button.copyWith(color: AppColors.black);
}

///
class AppDimens {
  ///
  const AppDimens();

  ///
  static const double screenEdgeMargin = 8.0;

  ///
  static const double screenContentMargin = 48.0;

  ///
  static const double toolBarHeight = 24.0;

  ///
  static const double subtitleHeight = 48.0;

  ///
  static const double subtitlePadding = 4.0;

  ///
  static const double bottomNavigationBarHeight = 56.0;

  ///
  static const double listItemHeight = 72.0;

  ///
  static const double listViewPadding =
      (screenContentMargin - screenEdgeMargin) / 2;

  ///
  static const double taskItemHeight = 64.0;
}
