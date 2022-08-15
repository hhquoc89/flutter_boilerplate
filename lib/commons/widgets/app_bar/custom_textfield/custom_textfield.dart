import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/commons/utils/extensions.dart';

import '../../../../app/cubit/app_cubit.dart';
import '../../../../configs/constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_utils.dart';

enum TrailingAnimation { none, showWhenFocus }
enum TextFieldActionType { normal, password, close }

class CustomTextField extends StatefulWidget {
  final String? title, errorText, labelText, hintText, helperText;
  final Function? onTapSubTitle;
  final VoidCallback? onSuffixTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaveTextContent;
  final StreamController<String?>? errorStream;
  final bool obscureText,
      isEnable,
      expand,
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
  final Color? inActiveFillColor;
  final double? borderWidth, height, borderRadius, width;
  final FocusNode? focusNode;
  final TrailingAnimation trailingAnimation;
  final EdgeInsets suffixWidgetMargin,
      globalMargin,
      helperTextMargin,
      errorLineMargin;
  final AutovalidateMode autoValidateMode;
  final Pattern? allowedInputFormatters;
  final GlobalKey<FormState>? formKey;

  final FloatingLabelBehavior floatingLabelBehavior;
  final int? maxLength;

  ///This function will trigger when it reaches the maximum length
  ///if max length is null, then this function wont be called
  final Function(String)? onComplete;

  final BoxShape shape;

  final VoidCallback? trailingWidgetTap;
  final EdgeInsets padding;

  const CustomTextField({
    Key? key,
    this.title,
    this.trailingWidgetTap,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.textFieldActionType = TextFieldActionType.normal,
    this.prefixErrorLine,
    this.ignoreErrorLine = false,
    this.errorStream,
    this.onSuffixTap,
    this.onComplete,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.helperTextMargin = const EdgeInsets.only(left: 16, top: 4, right: 16),
    this.errorLineMargin = const EdgeInsets.only(top: 7, bottom: 12),
    this.hintText,
    this.hintStyle,
    this.helperText,
    this.alignTextWithHint = false,
    this.helperStyle,
    this.expand = false,
    this.formKey,
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
    this.isEnable = true,
    this.maxLength,
    this.padding = const EdgeInsets.symmetric(vertical: 6),
    this.inActiveFillColor,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

enum CustomBorderState { error, focus, disable, normal }

class _CustomTextFieldState extends State<CustomTextField>
    with TickerProviderStateMixin {
  late final AppCubit _appCubit;
  late final AnimationController _trailingAnimation;
  late final Animation _trailingSizeAnimation, _trailingOpacityAnimation;
  late final FocusNode focusNode;
  late final GlobalKey<FormState>? _formKey;
  String? errorText;
  CustomBorderState borderState = CustomBorderState.normal;
  late bool obscureText;
  late TextEditingController _controller;
  String _lastValue = "";

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    obscureText = widget.obscureText;
    focusNode = widget.focusNode ?? FocusNode();
    _formKey = widget.formKey ?? GlobalKey<FormState>();
    _initFocusNodeListener();
    _appCubit = AppUtils.getAppCubit(context);
    initTrailingAnimationListener();
    _initErrorStream();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    if (widget.obscureText != oldWidget.obscureText) {
      obscureText = widget.obscureText;
    }
    if (widget.controller != _controller && widget.controller != null) {
      _controller = widget.controller!;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initFocusNodeListener() {
    focusNode.addListener(() {
      if (widget.autoFormatNumber) {
        _initFormatNumber();
      }
      _borderColorHandler(focusNode.hasFocus);
      if (!focusNode.hasFocus) {
        validator(_controller.text);
      }
    });
  }

  void _initFormatNumber() {
    if (!focusNode.hasFocus) {
      ///format the input data
      final dataInNumber = _controller.text.toNum();
      if (dataInNumber != null) {
        _controller.text =
            dataInNumber.formatNumber(keepDecimalDigitLikeOrigin: true);
      }
    }
  }

  @override
  void dispose() {
    _trailingAnimation.dispose();
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textFieldWidgets() => SizedBox(
          height: widget.height,
          width: widget.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: widget.padding,
                  decoration: BoxDecoration(
                      shape: widget.shape,
                      color: widget.isEnable
                          ? widget.activeFillColor
                          : widget.inActiveFillColor ??
                              AppColors.surfNDiveOpacity20,
                      borderRadius: BorderRadius.circular(widget.borderRadius ??
                          AppConstants.borderRadiusDefault),
                      border: Border.all(color: _buildBorderColor(), width: 1)),
                  child: TextFormField(
                    autovalidateMode: widget.autoValidateMode,
                    focusNode: focusNode,
                    expands: widget.expand,
                    maxLines: widget.expand ? null : 1,
                    autofocus: widget.autoFocus,
                    inputFormatters: _buildFormatter(),
                    controller: _controller,
                    keyboardType: widget.textInputType,
                    style: widget.textStyle ??
                        _appCubit.styles.defaultTextFieldStyle(),
                    enabled: widget.isEnable,
                    textAlign: widget.textAlign,
                    obscureText: obscureText,
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: widget.maxLength,
                    onChanged: _onChange,
                    decoration: InputDecoration(
                      counterText: "",
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
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                    ),
                    validator: validator,
                    onSaved: widget.onSaveTextContent,
                  ),
                ),
              ),
              _buildTrailingWidget()
            ],
          ),
        );
    return Container(
      margin: widget.globalMargin,
      child: Form(
        key: _formKey,
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
      ),
    );
  }

  List<TextInputFormatter>? _buildFormatter() {
    if (widget.allowedInputFormatters != null) {
      return [
        FilteringTextInputFormatter(widget.allowedInputFormatters!,
            allow: true),
      ];
    } else if (widget.maxLength != null) {
      return [LengthLimitingTextInputFormatter(widget.maxLength)];
    }
    return null;
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
    invokeError(result);
    return null;
  }

  void invokeError(String? error) {
    WidgetsBinding.instance!.scheduleFrameCallback((timeStamp) {
      if (errorText != error) {
        setState(() {
          errorText = error;
        });
      }
      if (errorText != null) {
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
  }

  Widget? _buildSuffixIcon() {
    if (widget.textFieldActionType == TextFieldActionType.password ||
        widget.suffixIconWidget != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onSuffixTap,
        child: Container(
          margin: widget.suffixWidgetMargin,
          child: suffixIconWidgets(),
        ),
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
    } else if (widget.textFieldActionType == TextFieldActionType.close) {
      if (focusNode.hasFocus || _controller.text.trim().isNotEmpty) {
        return widget.suffixIconWidget;
      }
      return const SizedBox();
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
        vsync: this, duration: const Duration(milliseconds: 120));

    _trailingSizeAnimation = SizeTween(
            begin: _shouldAnimateTrailingWidget() &&
                    _controller.text.isReallyEmpty() &&
                    _trailingAnimation.isDismissed
                ? Size.zero
                : null,
            end: null)
        .animate(_trailingAnimation);
    _trailingOpacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_trailingAnimation);
    focusNode.addListener(() {
      if (!focusNode.hasFocus && _controller.text.isReallyEmpty()) {
        _controller.clear();
      }
      if (_shouldAnimateTrailingWidget()) {
        _animateTrailingWidget();
      }
    });
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
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _animateTrailingWidget();
        if (widget.trailingWidgetTap != null) {
          widget.trailingWidgetTap!();
        }
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

  void _initErrorStream() {
    if (widget.errorStream != null) {
      widget.errorStream!.stream.listen((error) {
        Future.delayed(const Duration(milliseconds: 50), () {
          invokeError(error);
        });
      });
    }
  }

  void _onChange(String value) {
    if (widget.maxLength != null &&
        value.length == widget.maxLength &&
        widget.onComplete != null &&
        value != _lastValue) {
      widget.onComplete!(value);
    }
    _lastValue = value;
  }
}
