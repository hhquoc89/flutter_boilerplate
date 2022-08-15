import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'app_utils.dart';
import 'validator.dart';

extension NumberExtension on num {
  ///[keepDecimalDigitLikeOrigin] set to true if you want to keep all the rest of digits numbers value
  String formatNumber(
      {int decimalDigits = 0, bool keepDecimalDigitLikeOrigin = false}) {
    String suffix = List.generate(decimalDigits, (index) => "0").join();
    final splitText = toString().split(".");
    if (this == 0) {
      if (decimalDigits == 0) return "0";
      return "0.$suffix";
    } else if (splitText.first == "0") {
      suffix = List.generate(decimalDigits, (index) => "#").join();
    }
    if (keepDecimalDigitLikeOrigin) {
      final haveDecimalDigits = splitText.length > 1;
      if (haveDecimalDigits) {
        suffix = List.generate(splitText.last.length, (index) => "#").join();
      }
    }
    String result = NumberFormat('#,###.$suffix').format(this);
    if (suffix.isNotEmpty) {
      result = NumberFormat('#,###.$suffix').format(this);
    } else {
      result = NumberFormat('#,###').format(this);
    }
    final haveDot = result.contains(".");
    if (!haveDot && suffix.isNotEmpty) {
      result =
          "$result.${List.generate(suffix.length, (index) => "0").join("")}";
    }
    return result;
  }

  String formatNumberWithCurrency(
          {String currencySymbol = "\$", int decimalDigits = 1}) =>
      "$currencySymbol${formatNumber(decimalDigits: decimalDigits)}";
}

extension StringExtension1 on String? {
  bool isReallyEmpty() {
    return this == null || this!.trim().isEmpty;
  }

  bool isAbleToConvertToNumber() =>
      this != null && Validator.isAbleToConvertToNumber(this!.trim());

  num? toNum() {
    ///convert failed
    if (!isAbleToConvertToNumber()) return null;

    ///Because maybe it may be has been formatted before
    ///So we need to remove all the comma symbol
    final textWithoutComma = this!.replaceAll(",", "");
    final number = num.tryParse(textWithoutComma);
    return number;
  }

  String dateFormat(BuildContext context,
      {bool ignoreInvalidDateFormat = false, bool includeTimeFormat = false}) {
    String dateFormatStyle =
        AppUtils.getAppCubit(context).styles.dateFormatStyle;
    final splitStyle =
        AppUtils.getAppCubit(context).styles.dateFormatStyle.split(" ");
    if (!includeTimeFormat) {
      dateFormatStyle = splitStyle.first;
    }
    if (this == null) return "";
    final dateReg = RegExp(
        r"(([0-9]{1,4}[\/-]+[0-9]{1,4}[\/-]+[0-9]{2,4})|([0-9]{0,2}[,-]*((JANUARY)|(FEBRUARY)|(MARCH)|(APRIL)|(MAY)|(JUNE)|(JULY)|(AUGUST)|(SEPTEMBER)|(OCTOBER)|(NOVEMBER)|(DECEMBER))[ ,-]*[0-9]*[ ,-]*[0-9]*)|[0-9]{0,2}[,-]*((JAN)|(FEB)|(MAR)|(APR)|(MAY)|(JUN)|(JUL)|(AUG)|(SEP)|(SEPT)|(OCT)|(NOV)|(DEC))([ ,-]*[0-9]*[ ,-]*[0-9]))+( [0-9]+\:[0-9]+\:[0-9]{2})?");
    try {
      return this!.splitMapJoin(dateReg,
          onMatch: (Match m) {
            final format = DateFormat(dateFormatStyle);
            String data = format.format(DateTime.parse(m[0] ?? ""));
            if (includeTimeFormat) {
              final formatData = format.parse(data, true).toLocal();
              data = format.format(formatData);
              final splitData = data.split(" ");
              if (splitData.length == 1) {
                return splitData.first;
              } else if (splitData.length == 2) {
                return "${splitData.first} - ${splitData.last.split(":").take(2).join(":")}";
              }
              return data;
            }
            return data;
          },
          onNonMatch: (data) => ignoreInvalidDateFormat ? "" : data);
    } on Exception {
      return this!;
    }
  }

  int getDateMil(BuildContext context) {
    String _date;
    final dateFormatStyle =
        AppUtils.getAppCubit(context).styles.dateFormatStyle;
    if (this == null) return 0;
    final dateReg = RegExp(
        r"(([0-9]{1,4}[\/-]+[0-9]{1,4}[\/-]+[0-9]{2,4})|([0-9]{0,2}[,-]*((JANUARY)|(FEBRUARY)|(MARCH)|(APRIL)|(MAY)|(JUNE)|(JULY)|(AUGUST)|(SEPTEMBER)|(OCTOBER)|(NOVEMBER)|(DECEMBER))[ ,-]*[0-9]*[ ,-]*[0-9]*)|[0-9]{0,2}[,-]*((JAN)|(FEB)|(MAR)|(APR)|(MAY)|(JUN)|(JUL)|(AUG)|(SEP)|(SEPT)|(OCT)|(NOV)|(DEC))([ ,-]*[0-9]*[ ,-]*[0-9]))+( [0-9]+\:[0-9]+\:[0-9]{2})?");
    final format = DateFormat(dateFormatStyle);
    try {
      _date = this!.splitMapJoin(dateReg,
          onMatch: (Match m) {
            String? date = m[0];
            if (date != null && date.isNotEmpty) {
              return format.format(DateTime.parse(date));
            }
            return m[0] ?? "";
          },
          onNonMatch: (data) => data);
    } on Exception {
      _date = this!;
    }
    try {
      return format.parse(_date, true).toLocal().millisecondsSinceEpoch;
    } catch (e) {
      return 0;
    }
  }

  // String getDifferenceTimeFromNow(BuildContext context) {
  //   final milTime = getDateMil(context);
  //   final difference = DateTime.now()
  //       .toLocal()
  //       .difference(DateTime.fromMillisecondsSinceEpoch(milTime));
  //   int time;
  //   String des;
  //   final locale = AppLocalizations.instance;
  //   if (difference.inMinutes < 1) {
  //     time = difference.inSeconds;
  //     des = locale.giay();
  //   } else if (difference.inHours < 1) {
  //     time = difference.inMinutes;
  //     des = locale.phut();
  //   } else if (difference.inHours < 24) {
  //     time = difference.inHours;
  //     des = locale.gio();
  //   } else {
  //     time = difference.inDays;
  //     des = locale.ngay();
  //   }
  //   return "$time $des";
  // }
}

extension StringExtension2 on String {
  bool isReallyEmpty() {
    return trim().isEmpty;
  }

  bool isAbleToConvertToNumber() => Validator.isAbleToConvertToNumber(trim());

  num? toNum() {
    ///convert failed
    if (!isAbleToConvertToNumber()) return null;

    ///Because maybe it may be has been formatted before
    ///So we need to remove all the comma symbol
    final textWithoutComma = replaceAll(",", "");
    final number = num.tryParse(textWithoutComma);
    return number;
  }
}
