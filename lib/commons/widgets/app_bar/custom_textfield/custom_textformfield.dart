import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/commons/utils/extensions.dart';

import '../../../../app/cubit/app_cubit.dart';
import '../../../../configs/constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_utils.dart';
import 'custom_textfield.dart';

class CustomTextFormField extends StatefulWidget {
  final String? title, errorText, labelText, hintText, helperText;
  final Function? onTapSubTitle;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaveTextContent;
  final bool obscureText,
      isEnable,
      isCollapsed,
      ignoreErrorLine,
      isDense,
      alignTextWithHint,
      autoFocus,
      autoFormatNumber;
  final TextStyle? textStyle, labelStyle, titleStyle, hintStyle, helperStyle;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final TextFieldActionType textFieldActionType;
  final Widget? suffixIconWidget,
      prefixIconWidget,
      trailingWidget,
      prefixErrorLine;
  final TextAlign textAlign;
  final Color enabledBorderColor,
      activeFillColor,
      errorBorderColor,
      disableBorderColor,
      focusBorderColor;
  final double borderWidth, height;
  final double? width;
  final FocusNode? focusNode;
  final TrailingAnimation trailingAnimation;
  final EdgeInsets suffixWidgetMargin,
      globalMargin,
      helperTextMargin,
      errorLineMargin;
  final AutovalidateMode autoValidateMode;
  final Pattern? allowedInputFormatters;

  final FloatingLabelBehavior floatingLabelBehavior;

  const CustomTextFormField(
      {Key? key,
      this.title,
      this.textFieldActionType = TextFieldActionType.normal,
      this.prefixErrorLine,
      this.ignoreErrorLine = false,
      this.floatingLabelBehavior = FloatingLabelBehavior.auto,
      this.helperTextMargin =
          const EdgeInsets.only(left: 16, top: 4, right: 16),
      this.errorLineMargin = const EdgeInsets.only(top: 7, bottom: 12),
      this.hintText,
      this.hintStyle,
      this.helperText,
      this.alignTextWithHint = false,
      this.helperStyle,
      this.height = 56.0,
      this.width,
      this.errorBorderColor = AppColors.redPigment,
      this.autoFormatNumber = false,
      this.allowedInputFormatters,
      this.globalMargin = EdgeInsets.zero,
      this.autoValidateMode = AutovalidateMode.disabled,
      this.suffixWidgetMargin = EdgeInsets.zero,
      this.trailingAnimation = TrailingAnimation.none,
      this.titleStyle,
      this.disableBorderColor = AppColors.aquarellePurple,
      this.autoFocus = false,
      this.labelStyle,
      this.focusNode,
      this.labelText,
      this.isCollapsed = false,
      this.isDense = false,
      this.enabledBorderColor = AppColors.aquarellePurple,
      this.focusBorderColor = AppColors.haileyBlue,
      this.activeFillColor = Colors.transparent,
      this.borderWidth = 1,
      this.prefixIconWidget,
      this.errorText,
      this.trailingWidget,
      this.controller,
      this.onSaveTextContent,
      this.onTapSubTitle,
      this.textInputType = TextInputType.text,
      this.textStyle,
      this.textAlign = TextAlign.start,
      this.suffixIconWidget,
      this.validator,
      this.obscureText = false,
      this.isEnable = true})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

enum CustomBorderState { error, focus, disable, normal }

class _CustomTextFormFieldState extends State<CustomTextFormField>
    with TickerProviderStateMixin {
  late final AppCubit _appCubit;
  late final AnimationController _trailingAnimation;
  late final Animation _trailingSizeAnimation, _trailingOpacityAnimation;
  late final FocusNode focusNode;
  late String? errorText;
  CustomBorderState borderState = CustomBorderState.normal;
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    focusNode = widget.focusNode ?? FocusNode();
    _initFocusNodeListener();
    _appCubit = AppUtils.getAppCubit(context);
    initTrailingAnimationListener();
  }

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    if (widget.obscureText != oldWidget.obscureText) {
      obscureText = widget.obscureText;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initFocusNodeListener() {
    focusNode.addListener(() {
      if (widget.autoFormatNumber) {
        _initFormatNumber();
      }
      _borderColorHandler(focusNode.hasFocus);
    });
  }

  void _initFormatNumber() {
    if (!focusNode.hasFocus) {
      ///format the input data
      if (widget.controller != null) {
        final dataInNumber = widget.controller!.text.toNum();
        if (dataInNumber != null) {
          widget.controller!.text =
              dataInNumber.formatNumber(keepDecimalDigitLikeOrigin: true);
        }
      }
    }
  }

  @override
  void dispose() {
    _trailingAnimation.dispose();
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textFieldWidgets() => Container(
          height: widget.height,
          width: widget.width,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(AppConstants.borderRadiusDefault),
              border: Border.all(color: _buildBorderColor(), width: 1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  autovalidateMode: widget.autoValidateMode,
                  focusNode: focusNode,
                  autofocus: widget.autoFocus,
                  inputFormatters: widget.allowedInputFormatters != null
                      ? [
                          FilteringTextInputFormatter(
                              widget.allowedInputFormatters!,
                              allow: true)
                        ]
                      : null,
                  controller: widget.controller,
                  keyboardType: widget.textInputType,
                  style: widget.textStyle ??
                      _appCubit.styles.defaultTextFieldStyle(),
                  enabled: widget.isEnable,
                  textAlign: widget.textAlign,
                  obscureText: obscureText,
                  //textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isCollapsed: widget.isCollapsed,
                    isDense: widget.isDense,
                    border: InputBorder.none,
                    errorText: widget.errorText,
                    labelText: widget.labelText,
                    alignLabelWithHint: widget.alignTextWithHint,
                    hintText: widget.hintText,
                    hintStyle: widget.hintStyle ??
                        _appCubit.styles
                            .defaultTextFieldLabelStyle()
                            .copyWith(fontSize: 12),
                    labelStyle: widget.labelStyle ??
                        _appCubit.styles.defaultTextFieldLabelStyle(),
                    floatingLabelBehavior: widget.floatingLabelBehavior,
                    prefixIcon: widget.prefixIconWidget != null
                        ? Container(
                            margin: const EdgeInsets.only(left: 12, right: 8),
                            child: widget.prefixIconWidget,
                          )
                        : null,
                    prefixIconConstraints: const BoxConstraints(),
                    suffixIcon: _buildSuffixIcon(),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    fillColor: widget.isEnable
                        ? widget.activeFillColor
                        : AppColors.surfNDiveOpacity20,
                    filled: true,
                  ),
                  validator: validator,
                  onSaved: widget.onSaveTextContent,
                ),
              ),
              _buildTrailingWidget()
            ],
          ),
        );
    return Container(
      margin: widget.globalMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            _buildTitleTextField(
              widget.title,
            ),
          AnimatedBuilder(
              animation: _trailingAnimation,
              child: textFieldWidgets(),
              builder: (context, child) {
                ///For the better performance when we dont need to
                ///process the animation here, so we just return the child
                if (!_shouldAnimateTrailingWidget()) {
                  return child!;
                }
                return textFieldWidgets();
              }),
          if (shouldBuildErrorLine()) _buildErrorLine(),
          if (widget.helperText != null) _buildHelperText(),
        ],
      ),
    );
  }

  bool shouldBuildErrorLine() =>
      borderState == CustomBorderState.error &&
      errorText != null &&
      !widget.ignoreErrorLine;

  String? validator(dynamic data) {
    String? result;
    if (widget.validator != null) {
      result = widget.validator!(data);
    }
    errorText = result;
    WidgetsBinding.instance!.scheduleFrameCallback((timeStamp) {
      if (result != null) {
        if (borderState != CustomBorderState.error) {
          setState(() {
            borderState = CustomBorderState.error;
          });
        }
      } else {
        if (borderState == CustomBorderState.error) {
          setState(() {
            borderState = CustomBorderState.normal;
          });
        }
      }
    });
    return null;
  }

  Container? _buildSuffixIcon() {
    if (widget.textFieldActionType == TextFieldActionType.password ||
        widget.suffixIconWidget != null) {
      return Container(
        margin: widget.suffixWidgetMargin,
        child: suffixIconWidgets(),
      );
    }
    return null;
  }

  Widget? suffixIconWidgets() {
    if (widget.textFieldActionType == TextFieldActionType.password) {
      return GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: obscureText
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off));
    }
    return widget.suffixIconWidget;
  }

  Widget _buildTitleTextField(String? title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        title!,
        style: widget.titleStyle ?? _appCubit.styles.titleTextFieldStyle(),
      ),
    );
  }

  void onPressed() {}

  bool _shouldAnimateTrailingWidget() {
    return widget.trailingWidget != null &&
        widget.trailingAnimation != TrailingAnimation.none;
  }

  void initTrailingAnimationListener() {
    _trailingAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));

    _trailingSizeAnimation = SizeTween(
            begin: _shouldAnimateTrailingWidget() &&
                    widget.controller != null &&
                    widget.controller!.text.isReallyEmpty() &&
                    _trailingAnimation.isDismissed
                ? Size.zero
                : null,
            end: null)
        .animate(_trailingAnimation);
    _trailingOpacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_trailingAnimation);
    if (_shouldAnimateTrailingWidget()) {
      focusNode.addListener(() {
        _animateTrailingWidget();
      });
    }
  }

  void _animateTrailingWidget() {
    if (_trailingSizeAnimation.status == AnimationStatus.dismissed) {
      _trailingAnimation.forward();
    } else if (_trailingAnimation.status == AnimationStatus.completed) {
      _trailingAnimation.reverse();
    }
  }

  Widget _buildTrailingWidget() {
    if (widget.trailingWidget == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        _animateTrailingWidget();
      },
      child: SizedBox.fromSize(
        size: _trailingSizeAnimation.value,
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            DefaultTextStyle.merge(
                style: _appCubit.styles.defaultTextStyle(),
                child: widget.trailingWidget!)
          ],
        ),
      ),
    );
  }

  Color _buildBorderColor() {
    switch (borderState) {
      case CustomBorderState.error:
        return widget.errorBorderColor;
      case CustomBorderState.focus:
        return widget.focusBorderColor;
      case CustomBorderState.normal:
        return widget.enabledBorderColor;
      case CustomBorderState.disable:
        return widget.disableBorderColor;
      default:
        return widget.enabledBorderColor;
    }
  }

  void _borderColorHandler(bool hasFocus) {
    CustomBorderState? state;
    if (hasFocus) {
      if (borderState == CustomBorderState.normal) {
        state = CustomBorderState.focus;
      }
    } else {
      if (borderState == CustomBorderState.focus) {
        state = CustomBorderState.normal;
      }
    }
    if (state != null) {
      setState(() {
        borderState = state!;
      });
    }
  }

  Widget _buildErrorLine() {
    return Container(
      margin: widget.errorLineMargin,
      child: Row(
        children: [
          if (widget.prefixErrorLine != null) ...[
            widget.prefixErrorLine!,
            const SizedBox(
              width: 9,
            ),
          ],
          Expanded(
            child: Text(
              errorText!,
              style: _appCubit.styles.errorTextFieldStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelperText() {
    return Container(
      margin: widget.helperTextMargin,
      child: Text(
        widget.helperText!,
        style: widget.helperStyle ?? _appCubit.styles.textFieldHelperStyle(),
      ),
    );
  }
}
