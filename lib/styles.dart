import 'package:flutter/material.dart';
import 'commons/utils/app_colors.dart';

class AppFontWeight {
  static const thin = FontWeight.w100;
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
  static const ultraBold = FontWeight.w900;
}

class AppFont {}

abstract class AppStyles {
  late String dateFormatStyle;

  late ThemeData themeData;

  TextStyle defaultTextStyle();

  TextStyle defaultTextFieldStyle();

  TextStyle defaultTextFieldLabelStyle();

  TextStyle titleTextFieldStyle();

  TextStyle errorTextFieldStyle();

  TextStyle textFieldHelperStyle();

  Color defaultLoadMoreColor();

  TextStyle customTextStyle5();
  TextStyle customTextStyle6();
  TextStyle customTextStyleGrey6();
  TextStyle customTextStyle1();
  TextStyle customTextStyle2();
  TextStyle customTextStyle3();
  TextStyle customOption();
  TextStyle customOptionDark();
  TextStyle customTitlePanelDark();
  TextStyle customTitleButtonFooter();
  TextStyle customHeadLineFooter();

  TextStyle customTitleFooter();
  TextStyle customTextstyleCommunity();
}

class DefaultAppStyles implements AppStyles {
  @override
  String dateFormatStyle = "dd/MM/yyyy HH:mm:ss";

  @override
  ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    backgroundColor: AppColors.backgroundColor,
    hintColor: AppColors.lightTextColor,
    textTheme: const TextTheme(
      headline4: TextStyle(fontSize: 24, fontWeight: AppFontWeight.medium),
      headline5: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    ),
    fontFamily: 'HelveticaNeue',
  );

  @override
  TextStyle defaultTextStyle() {
    return themeData.textTheme.bodyText2!.copyWith(color: Colors.black);
  }

  @override
  TextStyle customTextstyleCommunity() {
    return themeData.textTheme.headline6!.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  TextStyle customOption() {
    return themeData.textTheme.bodyText2!
        .copyWith(color: Colors.white, fontWeight: FontWeight.bold);
  }

  @override
  TextStyle customOptionDark() {
    return themeData.textTheme.bodyText2!
        .copyWith(color: Colors.black, fontWeight: FontWeight.bold);
  }

  @override
  TextStyle customTextStyle1() {
    return themeData.textTheme.headline1!.copyWith(
        color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold);
  }

  @override
  TextStyle customTextStyle2() {
    return themeData.textTheme.headline2!.copyWith(
        color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold);
  }

  @override
  TextStyle customTextStyle3() {
    return themeData.textTheme.headline4!
        .copyWith(color: Colors.black, fontSize: 24);
  }

  @override
  TextStyle customTextStyle5() {
    return themeData.textTheme.headline5!.copyWith(color: Colors.white);
  }

  @override
  TextStyle customTextStyle6() {
    return themeData.textTheme.headline6!
        .copyWith(fontSize: 16, color: Colors.white);
  }

  @override
  TextStyle customTextStyleGrey6() {
    return themeData.textTheme.headline6!
        .copyWith(fontSize: 16, color: Colors.grey);
  }

  @override
  TextStyle defaultTextFieldStyle() {
    return themeData.textTheme.bodyText2!.copyWith(
        fontSize: 16, color: Colors.black, fontWeight: AppFontWeight.light);
  }

  @override
  TextStyle customTitlePanelDark() {
    return themeData.textTheme.headline4!
        .copyWith(color: Colors.white, fontSize: 24);
  }

  @override
  TextStyle customTitleButtonFooter() {
    return themeData.textTheme.headline4!.copyWith(color: Colors.blueAccent);
  }

  @override
  TextStyle customHeadLineFooter() {
    return themeData.textTheme.headline5!
        .copyWith(color: Colors.white, fontWeight: FontWeight.normal);
  }

  @override
  TextStyle customTitleFooter() {
    return themeData.textTheme.headline4!
        .copyWith(color: Colors.white, fontSize: 24);
  }

  @override
  TextStyle defaultTextFieldLabelStyle() => defaultTextStyle();

  @override
  TextStyle titleTextFieldStyle() => defaultTextStyle();

  @override
  TextStyle errorTextFieldStyle() => defaultTextStyle();

  @override
  TextStyle textFieldHelperStyle() => defaultTextStyle();

  @override
  Color defaultLoadMoreColor() => AppColors.primaryColor;
}
