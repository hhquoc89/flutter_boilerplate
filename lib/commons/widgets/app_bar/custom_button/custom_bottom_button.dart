import 'package:flutter/material.dart';

import '../../../../app/cubit/app_cubit.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_utils.dart';
import '../custom_loading/custom_loading_indicator.dart';

class CustomButton extends StatefulWidget {
  final Function? onTap;
  final BoxDecoration? boxDecoration;
  final String? title, subTitle, iconPathRight, iconPathLeft;
  final MainAxisAlignment? alignment;
  final MainAxisSize mainAxisSize;
  final TextStyle? textStyle, subTitleTextStyle;
  final TextAlign? titleAlignment;
  final Alignment? parentAlignment;
  final bool isLoading, disable, center;
  final EdgeInsetsGeometry? padding, margin;
  final Color? titleColor, disableBackGroundColor;
  final Widget? suffixIcon;

  final double? height, width;

  final Color? loadingColor;

  const CustomButton(
      {Key? key,
      this.height,
      this.loadingColor,
      this.parentAlignment,
      this.mainAxisSize = MainAxisSize.max,
      this.width,
      this.center = true,
      this.onTap,
      this.title,
      this.subTitle,
      this.textStyle,
      this.subTitleTextStyle,
      this.alignment,
      this.titleAlignment,
      this.boxDecoration,
      this.iconPathRight,
      this.iconPathLeft,
      this.padding,
      this.margin,
      this.suffixIcon,
      this.isLoading = false,
      this.titleColor,
      this.disableBackGroundColor,
      this.disable = false})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late AppCubit _appCubit;

  @override
  void initState() {
    _appCubit = AppUtils.getAppCubit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return Container(decoration: widget.boxDecoration,child: Text("E"),);
    return Container(
      margin: widget.margin ?? EdgeInsets.zero,
      height: widget.height,
      width: widget.width,
      child: Material(
        color: widget.disable
            ? (widget.disableBackGroundColor ?? Colors.transparent)
            : (widget.boxDecoration?.color ?? Colors.transparent),
        borderRadius: widget.boxDecoration?.borderRadius,
        child: InkWell(
          borderRadius:
              widget.boxDecoration?.borderRadius?.resolve(TextDirection.ltr),
          onTap: _onButtonTap,
          child: Container(
            alignment: widget.center ? Alignment.center : null,
            decoration:
                widget.boxDecoration?.copyWith(color: Colors.transparent) ??
                    BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.circular(0),
                    ),
            padding:
                widget.padding ?? const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: LoadingWidget(
              isLoading: widget.isLoading,
              color: widget.loadingColor,
              child: Row(
                mainAxisSize: widget.mainAxisSize,
                mainAxisAlignment: widget.alignment ?? MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.iconPathLeft != null)
                    Container(
                      margin: const EdgeInsets.only(right: 8, left: 8),
                      child: AppImage.asset(
                          assetPath: widget.iconPathLeft,
                          fit: BoxFit.scaleDown),
                    ),
                  if (widget.title != null)
                    Flexible(
                      child: Text(
                        widget.title!,
                        textAlign: widget.titleAlignment ?? TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: widget
                                .textStyle /*.copyWith(color: widget.titleColor)*/ ??
                            _appCubit.styles
                                .defaultTextStyle() /*.copyWith(color: widget.titleColor)*/,
                      ),
                    ),
                  if (widget.subTitle != null)
                    Text(
                      widget.subTitle!,
                      style: widget.subTitleTextStyle ??
                          _appCubit.styles.defaultTextStyle(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonTap() {
    if (!widget.isLoading && !widget.disable) {
      if (widget.onTap != null) {
        widget.onTap!();
      }
    }
  }
}
