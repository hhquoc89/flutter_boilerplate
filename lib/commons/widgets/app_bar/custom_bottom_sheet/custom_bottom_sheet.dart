import 'package:flutter/material.dart';

class CustomBottomSheet {
  final BuildContext _context;

  CustomBottomSheet(this._context);

  ///Show a bottom sheet modal with the custom height,
  ///you can set the maximum height for the bottom sheet modal by
  ///set value for the [maxHeight] variable
  ///if not it will have the wrap content style,
  /// if the size is greater than the screen size  minus
  /// the sum of [kToolbarHeight] + [AppConstants.minimumSafeAreaPadding], it will be scrollable
  Future<void> show({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Widget? title,
    EdgeInsets? titleMargin,
    contentPadding,
    Clip? clipBehavior,
    double? maxHeight,
    Color? barrierColor,
    bool isScrollControlled = true,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
  }) {
    return showModalBottomSheet(
        context: _context,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: clipBehavior,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        routeSettings: routeSettings,
        transitionAnimationController: transitionAnimationController,
        builder: (context) {
          return LayoutBuilder(builder: (context, constraint) {
            double _maxHeight = maxHeight ?? double.infinity;
            if (maxHeight == null) {
              _maxHeight = constraint.maxHeight - kToolbarHeight;
            }
            return Container(
              padding: contentPadding,
              constraints: BoxConstraints(maxHeight: _maxHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null) _buildAppbar(title, titleMargin, context),
                  Expanded(child: builder(context)),
                ],
              ),
            );
          });
        });
  }

  _buildAppbar(Widget title, EdgeInsets? titleMargin, BuildContext context) =>
      Container(
        margin: titleMargin,
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.close)),
            Expanded(
              child: title,
            )
          ],
        ),
      );
}
