// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseInputConfigs {
  final Widget? customLabel;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final Widget? customHint;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final Widget? customFeedback;
  final FeedbackType feedBackType;
  final String? feedbackMessage;
  final TextStyle? feedbackMessageStyle;
  final String? placeholderText;
  final TextStyle? placeholderTextStyle;
  final String? initialValue;
  final TextStyle? valueTextStyle;
  final EdgeInsets? contentPadding;
  final bool? enable;
  final bool? viewOnly;
  final FocusNode? focusNode;
  final Color? fillColor;
  final TextEditingController? controller;
  final Color? cursorColor;
  final double? cursorHeight;
  final double? cursorWidth;
  final Function()? onUnfocus;
  final Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool? autofocus;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final String? obscuringCharacter;
  final bool? obscureText;
  final bool? autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool? enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool? expands;
  final int? maxLength;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final Radius? cursorRadius;
  final Brightness? keyboardAppearance;
  final EdgeInsets? scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final Widget? Function(BuildContext,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength})? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final String? restorationId;
  final bool? enableIMEPersonalizedLearning;
  final MouseCursor? mouseCursor;

  /// Without fillColor, filled, enabled, isCollapsed, contentPadding, hintText, hintStyle
  /// prefix, border, enabledBorder, focusedBorder, disabledBorder
  final InputDecoration? decoration;

  BaseInputConfigs({
    this.customLabel,
    this.labelText,
    this.labelTextStyle,
    this.customHint,
    this.hintText,
    this.hintTextStyle,
    this.customFeedback,
    this.feedBackType = FeedbackType.none,
    this.feedbackMessage,
    this.feedbackMessageStyle,
    this.placeholderText,
    this.placeholderTextStyle,
    this.initialValue,
    this.valueTextStyle,
    this.contentPadding,
    this.enable,
    this.viewOnly,
    this.focusNode,
    this.fillColor,
    this.controller,
    this.cursorColor,
    this.cursorHeight,
    this.cursorWidth,
    this.onUnfocus,
    this.onChanged,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.textAlign,
    this.textAlignVertical,
    this.autofocus,
    this.toolbarOptions,
    this.showCursor,
    this.obscuringCharacter,
    this.obscureText,
    this.autocorrect,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions,
    this.maxLengthEnforcement,
    this.maxLines,
    this.minLines,
    this.expands,
    this.maxLength,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.inputFormatters,
    this.cursorRadius,
    this.keyboardAppearance,
    this.scrollPadding,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.restorationId,
    this.enableIMEPersonalizedLearning,
    this.mouseCursor,
    this.buildCounter,
    this.decoration,
  })  : assert(
            customLabel == null ||
                (labelText == null && labelTextStyle == null),
            "\n =>Only use customLabel (Widget) or labelText(String)"),
        assert(
            ((feedBackType != FeedbackType.none && feedbackMessage != null) ||
                (feedBackType == FeedbackType.none &&
                    feedbackMessage == null &&
                    feedbackMessageStyle == null)),
            "\n => When feedBackType == FeedbackType.none, feedbackMessage == null and feedbackMessageStyle == null"),
        assert(initialValue == null || controller == null);
}

enum FeedbackType {
  error,
  warning,
  success,
  none,
}
