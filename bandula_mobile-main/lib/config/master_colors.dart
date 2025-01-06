import 'package:flutter/material.dart';

class MasterColors {
  MasterColors._();

  /// Primary Color
  static Color primary50 = cPrimary50;
  static Color primary100 = cPrimary100;
  static Color primary200 = cPrimary200;
  static Color primary300 = cPrimary300;
  static Color primary400 = cPrimary400;
  static Color primary500 = cPrimary500;
  static Color primary600 = cPrimary600;
  static Color primary700 = cPrimary700;
  static Color primary800 = cPrimary800;
  static Color primary900 = cPrimary900;

  /// Primary Dark Color
  static Color primaryDarkDark = cPrimaryDarkDark;
  static Color primaryDarkAccent = cPrimaryDarkAccent;
  static Color primaryDarkWhite = cPrimaryDarkWhite;
  static Color primaryDarkGrey = cPrimaryDarkGrey;
  static Color darkGrey = const Color(0xFF9F9F9F);

  /// Secondary Color
  static Color secondary50 = cSecondary50;
  static Color secondary100 = cSecondary100;
  static Color secondary200 = cSecondary200;
  static Color secondary300 = cSecondary300;
  static Color secondary400 = cSecondary400;
  static Color secondary500 = cSecondary500;
  static Color secondary600 = cSecondary600;
  static Color secondary700 = cSecondary700;
  static Color secondary800 = cSecondary800;
  static Color secondary900 = cSecondary900;

  ///
  /// text Color
  ///
  static Color? textColor1;
  static Color? textColor2;
  static Color? textColor3;
  static Color? textColor4;
  static Color? textColor5;

  ///
  /// Button Color
  ///
  static Color? buttonColor;
  static Color? appBarTitleColor;
  static Color? successColor;

  ///
  /// Primary Color
  ///
  static Color? mainColor;

  ///
  /// Icon Color
  ///
  static Color iconColor = dIconColor;
  static Color iconRejectColor = dIconColor;
  static Color iconSuccessColor = dIconColor;
  static Color iconInfoColor = dIconColor;

  ///
  /// General
  ///
  static Color white = cWhiteColor;
  static Color black = cBlackColor;
  static Color grey = cGreyColor;
  static Color transparent = cTransparentColor;

  /// Colors Config For the whole App
  /// Please change the color based on your brand need.

  ///
  /// Light Theme
  ///

  static Color lMainColor = const Color.fromRGBO(2, 80, 162, 1);
  static Color lBaseColor = const Color(0xFFffffff);
  static Color lbaseDarkColor = const Color(0xFFFFFFFF);
  static Color lbaseLightColor = const Color(0xFFEFEFEF);
  static Color lappBarColor = const Color(0x00F5F5F5);

  static Color lTextPrimaryColor = const Color(0xFF445E76);
  static Color lTextPrimaryLightColor = const Color(0xFFadadad);
  static Color lTextPrimaryDarkColor = const Color(0xFF25425D);
  static Color lTextColor4 = const Color(0xFF9F9F9F);

  static Color lIconColor = const Color(0xFFa92428);
  static Color lIconRejectColor = const Color(0xFFF23A43);
  static Color lIconSuccessColor = const Color(0xFF38C141);
  static Color lIconInfoColor = const Color(0xFF00A2DD);
  static Color lDividerColor = const Color(0x15505050);
  static Color lMainTransprentColor = const Color(0xFFF6E9EA);
  static Color lAppBarTitleColor = const Color(0xFF03045E);
  static Color lBottomNavigationColor = const Color(0xFFf5e5e5);
  // static Color lCardBackgroundColor = const Color(0xFFadadad);
  static Color cardBackgroundColor = Colors.white;
  static Color appBackgroundColor = Colors.white;

  static Color lButtonColor = const Color(0xFF303030);

  ///
  /// Dark Theme
  ///
  static Color dMainColor = const Color(0xFFD71721);
  static Color dBaseColor = const Color(0xFF212121);
  static Color dBaseDarkColor = const Color(0xFF303030);
  static Color dBaseLightColor = const Color(0xFF454545);
  static Color dTextPrimaryColor = const Color(0xFFFFFFFF);
  static Color dTextPrimaryLightColor = const Color(0xFFFFFFFF);
  static Color dTextPrimaryDarkColor = const Color(0xFFFFFFFF);
  static Color dTextColor3 = const Color(0xFFA0A0A0);
  static Color dIconColor = const Color(0xFFffb0b1);
  static Color dDividerColor = const Color(0x1FFFFFFF);
  static Color dMainTransparentColor = const Color(0xFFF6E9EA);
  static Color dCardBackgroundColor = const Color(0xFF303030);
  static Color dButtonColor = const Color(0xFFA0A0A0);

  ///
  /// Common Theme
  ///

  static Color cPrimary50 = const Color(0xFFFDEBE7);
  static Color cPrimary100 = const Color(0xFFFACDC2);
  static Color cPrimary200 = const Color(0xFFF7AC9A);
  static Color cPrimary300 = const Color(0xFFF48A72);
  static Color cPrimary400 = const Color(0xFFF17153);
  static Color cPrimary500 = const Color(0xFFEF5835);
  static Color cPrimary600 = const Color(0xFFED5030);
  static Color cPrimary700 = const Color(0xFFEB4728);
  static Color cPrimary800 = const Color(0xFFE83D22);
  static Color cPrimary900 = const Color(0xFFE42D16);

  static Color cPrimaryDarkDark = const Color(0xFF303030);
  static Color cPrimaryDarkAccent = const Color(0xFFffb0b1);
  static Color cPrimaryDarkWhite = const Color(0xFFffffff);
  static Color cPrimaryDarkGrey = const Color(0xFFA0A0A0);

  static Color cSecondary50 = const Color(0xFFF9F9F9);
  static Color cSecondary100 = const Color(0xFFF3F3F3);
  static Color cSecondary200 = const Color(0xFFEAEAEA);
  static Color cSecondary300 = const Color(0xFFDADADA);
  static Color cSecondary400 = const Color(0xFFB7B7B7);
  static Color cSecondary500 = const Color(0xFF979797);
  static Color cSecondary600 = const Color(0xFF6F6F6F);
  static Color cSecondary700 = const Color(0xFF5B5B5B);
  static Color cSecondary800 = const Color(0xFF3C3C3C);
  static Color cSecondary900 = const Color(0xFF1C1C1C);

  static Color cSecondaryDarkDark = const Color(0xFF303030);
  static Color cSecondaryDarkAccent = const Color(0xFF6facff);
  static Color cSecondaryDarkWhite = const Color(0xFFffffff);
  static Color cSecondaryDarkGrey = const Color(0xFFA0A0A0);

  static Color cWhiteColor = Colors.white;
  static Color cBlackColor = Colors.black;
  static Color cGreyColor = const Color(0xFFF4F4F4);
  static Color cBlueColor = Colors.blue;
  static Color cTransparentColor = Colors.transparent;
  static Color cPaidAdsColor = Colors.lightGreen;

  static Color cFacebookLoginColor = const Color(0xFF1877F2);
  static Color cGoogleLoginColor = const Color(0xFFFFFFFF);
  static Color cPhoneLoginColor = const Color(0xFF38C141);
  static Color cAppleLoginColor = const Color(0xFF000000);

  static Color cPaypalColor = const Color(0xFF3b7bbf);
  static Color cStripeColor = const Color(0xFF008cdd);
  static Color cCardBackgroundColor = const Color(0xFF303030);

  static Color cRatingColor = const Color(0xFFF59E0B);
  static Color cSoldOutColor = const Color(0x80D2232A);
  static Color cItemTypeColor = const Color(0xFFBDBDBD);

  static Color cWatingForApprovalColor = const Color(0xFFF59E0B);
  static Color cNotYetStartColor = const Color(0xFF979797);
  static Color cAdInFinishColor = const Color(0xFF10B981);
  static Color cAdInRejectColor = const Color(0xFFF23A43);
  static Color cAdInProgressColor = const Color(0xFF00A2DD);
  static Color cWarningColor = const Color(0xFFFFC700);

  static Color cOfflineIconColor = const Color(0xFF6B7280);
  static Color cSenderTextMsgColor = const Color(0xFF009993);
  static Color cReceiverTextMsgColor = const Color(0xFFF6E9EA);
  static Color cButtonBorderColor = const Color(0xFFE5E7EB);
  static Color cBorderColor = const Color(0xFFD1D5DB);

  static void loadColor(BuildContext context) {
    _loadLightColors();
  }

  static void loadColor2(bool isLightMode) {
    _loadLightColors();
  }

  static void _loadLightColors() {
    ///
    ///Primary Color
    ///
    primary50 = cPrimary50;
    primary100 = cPrimary100;
    primary200 = cPrimary200;
    primary300 = cPrimary300;
    primary400 = cPrimary400;
    primary500 = cPrimary500;
    primary600 = cPrimary600;
    primary700 = cPrimary700;
    primary800 = cPrimary800;
    primary900 = cPrimary900;

    ///
    ///Secondary Color
    ///
    secondary50 = cSecondary50;
    secondary100 = cSecondary100;
    secondary200 = cSecondary200;
    secondary300 = cSecondary300;
    secondary400 = cSecondary400;
    secondary500 = cSecondary500;
    secondary600 = cSecondary600;
    secondary700 = cSecondary700;
    secondary800 = cSecondary800;
    secondary900 = cSecondary900;

    textColor1 = lMainColor;
    textColor2 = lAppBarTitleColor;
    textColor3 = cSecondary900;
    textColor4 = lTextColor4;
    textColor5 = white;

    ///
    /// Button Color
    ///
    buttonColor = lButtonColor;
    mainColor = lMainColor;
    appBarTitleColor = lAppBarTitleColor;
    successColor = lIconSuccessColor;

    ///
    /// Icon Color
    ///
    iconColor = lIconColor;
    iconRejectColor = lIconRejectColor;
    iconSuccessColor = lIconSuccessColor;
    iconInfoColor = lIconInfoColor;

    ///
    /// Background Color
    ///

    ///
    /// General
    ///
    white = cWhiteColor;
    black = cBlackColor;
    grey = cGreyColor;
    transparent = cTransparentColor;
  }
}
