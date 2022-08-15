import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final bool isLoading;
  final Color? color, backgroundColor;
  final Widget child;
  final double? value;
  final EdgeInsets margin;
  const LoadingWidget(
      {this.isLoading = false,
      this.value,
      this.backgroundColor,
      this.margin = const EdgeInsets.all(2),
      this.child = const SizedBox(),
      this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      secondChild: Center(
        child: Container(
            color: backgroundColor,
            height: 17,
            width: 17,
            margin: margin,
            child: Theme(
              data: ThemeData(
                  cupertinoOverrideTheme:
                      const CupertinoThemeData(brightness: Brightness.dark)),
              child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: value,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(color ?? AppColors.white)),
            )),
      ),
      crossFadeState:
          isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      firstChild: child,
      duration: const Duration(milliseconds: 200),
    );
  }
}
