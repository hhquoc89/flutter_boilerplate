import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../app/cubit/app_cubit.dart';
import '../../localizations/app_localization.dart';
import '../widgets/app_bar/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../widgets/app_bar/dialog.dart';
import 'app_colors.dart';
import 'app_utils.dart';

class PopupUtils {
  final BuildContext _context;
  final CustomBottomSheet _customBottomSheet;
  final AppCubit _appCubit;
  final AppLocalizations _locale;

  PopupUtils(this._context)
      : _customBottomSheet = CustomBottomSheet(_context),
        _appCubit = AppUtils.getAppCubit(_context),
        _locale = AppUtils.getAppLocale(_context);

  Future<DateTimeRange?> showDateRangePicker({
    DateTimeRange? dateTimeRange,
  }) async {
    final now = DateTime.now();
    return await Navigator.of(_context).push(DialogRoute(
      context: _context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          currentDate: DateTime.now(),
          initialDateRange: dateTimeRange,
          firstDate: now,
          lastDate: DateTime(now.year, 12, DateTime(now.year, 12, 0).day),
        );
      },
    ));
  }

  Future showAlertDialog(
      {String? title,
      String? content,
      required DialogBase dialog,
      DialogActionCallback? actionCallback,
      bool barrierDismissible = true,
      String? rightActionContent,
      String? leftActionContent}) async {
    final _dialog = DialogFactory(
        dialog: dialog,
        content: content,
        title: title,
        dialogActionCallback: actionCallback,
        leftActionContent: leftActionContent,
        rightActionContent: rightActionContent);
    return showDialog(
        context: _context,
        builder: _dialog.buildDialog,
        barrierDismissible: barrierDismissible);
  }

  void showSnackBar() {
    ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text("Copied",
          style: AppUtils.getAppCubit(_context).styles.defaultTextStyle()),
      backgroundColor: AppColors.backgroundColor,
    ));
  }

  Future showFlushBar(
    String message, {
    Color bgColor = AppColors.backgroundColor,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
    Duration? duration,
  }) {
    return Flushbar(
      forwardAnimationCurve: Curves.decelerate,
      reverseAnimationCurve: Curves.easeOut,
      backgroundColor: bgColor,
      flushbarPosition: position,
      duration: duration ?? const Duration(seconds: 5),
      messageText: Text(
        message,
        style: _appCubit.styles
            .defaultTextStyle()
            .copyWith(color: AppColors.white),
        textAlign: TextAlign.center,
      ),
    ).show(_context);
  }
}
