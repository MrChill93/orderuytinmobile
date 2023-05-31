// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, depend_on_referenced_packages
// ignore_for_file: unnecessary_nullable_for__variable_declarations

import 'package:flutter/material.dart';

import '../../themes/text_styles.dart';
import 'base_input_configs.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Hcm23BaseInput extends StatefulWidget {
  BaseInputConfigs baseConfigs;
  Hcm23BaseInput({
    super.key,
    required this.baseConfigs,
  });

  @override
  State<Hcm23BaseInput> createState() => _Hcm23BaseInputState();
}

class _Hcm23BaseInputState extends State<Hcm23BaseInput> {
  late Widget? _customLabel;
  late String? _labelText;
  late TextStyle? _labelTextStyle;
  late Widget? _customHint;
  late String? _hintText;
  late TextStyle? _hintTextStyle;
  late Widget? _customFeedback;
  late FeedbackType? _feedBackType;
  late String? _feedbackMessage;
  late TextStyle? _feedbackMessageStyle;
  late String? _placeholderText;
  late TextStyle? _placeholderTextStyle;
  late String? _value;
  late TextStyle? _valueTextStyle;
  late EdgeInsetsGeometry _contentPadding;
  late bool _enabled;
  late bool _readOnly;
  late FocusNode _focusNode;
  late Color _fillColor;
  late TextEditingController? _controller;
  late Color _cursorColor;
  late double _cursorHeight;
  late double _cursorWidth;

  late InputDecoration _decoration;

  @override
  void initState() {
    _customLabel = widget.baseConfigs.customLabel;
    _labelText = widget.baseConfigs.labelText;
    _labelTextStyle = widget.baseConfigs.labelTextStyle ??
        tStyle.display14().w400().copyWith(
              color: const Color(0XFF586B8B),
            );
    _customHint = widget.baseConfigs.customHint;
    _hintText = widget.baseConfigs.hintText;
    _hintTextStyle = widget.baseConfigs.hintTextStyle ??
        tStyle.w400().copyWith(
              fontSize: 12,
              color: const Color(0XFF586B8B),
            );
    _customFeedback = widget.baseConfigs.customFeedback;
    _feedBackType = widget.baseConfigs.feedBackType;
    _feedbackMessage = widget.baseConfigs.feedbackMessage;
    _feedbackMessageStyle = widget.baseConfigs.feedbackMessageStyle ??
        tStyle.w400().copyWith(
              fontSize: 12,
              color: const Color(0XFF586B8B),
            );
    _placeholderText = widget.baseConfigs.placeholderText;
    _placeholderTextStyle =
        widget.baseConfigs.placeholderTextStyle ?? _buildPlaceholderTextStyle();
    _value = widget.baseConfigs.initialValue;
    _valueTextStyle =
        widget.baseConfigs.valueTextStyle ?? _buildValueTextStyle();
    _contentPadding = widget.baseConfigs.contentPadding ??
        const EdgeInsets.symmetric(vertical: 12);
    _enabled = widget.baseConfigs.enable ?? true;
    _readOnly = widget.baseConfigs.viewOnly ?? false;
    _focusNode = widget.baseConfigs.focusNode ?? FocusNode();
    _fillColor = widget.baseConfigs.fillColor ??
        const Color(0XDDDBDFEF).withOpacity(0.2);
    _controller = widget.baseConfigs.controller;
    _cursorColor = widget.baseConfigs.cursorColor ?? const Color(0XFF000000);
    _cursorHeight = widget.baseConfigs.cursorHeight ?? 20;
    _cursorWidth = widget.baseConfigs.cursorWidth ?? 1;
    _decoration = widget.baseConfigs.decoration ?? const InputDecoration();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.addListener(() {
        if (!_focusNode.hasFocus) {
          widget.baseConfigs.onUnfocus?.call();
        }
      });
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Hcm23BaseInput oldWidget) {
    setState(() {
      _customLabel = widget.baseConfigs.customLabel;
      _labelText = widget.baseConfigs.labelText;
      _labelTextStyle = widget.baseConfigs.labelTextStyle ??
          tStyle.display14().w400().copyWith(
                color: const Color(0XFF586B8B),
              );
      _customHint = widget.baseConfigs.customHint;
      _hintText = widget.baseConfigs.hintText;
      _hintTextStyle = widget.baseConfigs.hintTextStyle ??
          tStyle.w400().copyWith(
                fontSize: 12,
                color: const Color(0XFF586B8B),
              );
      _customFeedback = widget.baseConfigs.customFeedback;
      _feedBackType = widget.baseConfigs.feedBackType;
      _feedbackMessage = widget.baseConfigs.feedbackMessage;
      _feedbackMessageStyle = widget.baseConfigs.feedbackMessageStyle ??
          tStyle.w400().copyWith(
                fontSize: 12,
                color: const Color(0XFF586B8B),
              );
      _placeholderText = widget.baseConfigs.placeholderText;
      _placeholderTextStyle = widget.baseConfigs.placeholderTextStyle ??
          _buildPlaceholderTextStyle();
      _value = widget.baseConfigs.initialValue;
      _valueTextStyle =
          widget.baseConfigs.valueTextStyle ?? _buildValueTextStyle();
      _contentPadding = widget.baseConfigs.contentPadding ??
          const EdgeInsets.symmetric(vertical: 12);
      _enabled = widget.baseConfigs.enable ?? true;
      _readOnly = widget.baseConfigs.viewOnly ?? false;
      _focusNode = widget.baseConfigs.focusNode ?? FocusNode();
      _fillColor = widget.baseConfigs.fillColor ??
          const Color(0XDDDBDFEF).withOpacity(0.2);
      _controller = widget.baseConfigs.controller;
      _cursorColor = widget.baseConfigs.cursorColor ?? const Color(0XFF000000);
      _cursorHeight = widget.baseConfigs.cursorHeight ?? 20;
      _cursorWidth = widget.baseConfigs.cursorWidth ?? 1;
      _decoration = widget.baseConfigs.decoration ?? const InputDecoration();
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (mounted) {
      _controller?.dispose();
      _focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLabelAndHint(),
        _buildTextFormField(),
        _buildFeedback(),
      ],
    );
  }

  /// _buildLabelAndHint
  Widget _buildLabelAndHint() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: _customLabel ??
                Text(
                  _labelText ?? "",
                  style: _labelTextStyle,
                  overflow: TextOverflow.fade,
                ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: _customHint ??
                Text(
                  _hintText ?? "",
                  style: _hintTextStyle,
                  overflow: TextOverflow.fade,
                ),
          ),
        )
      ],
    );
  }

  /// _buildFeedback
  Widget _buildFeedback() {
    return Container(
      child: _customFeedback ??
          (_feedBackType != FeedbackType.none
              ? Row(
                  children: [
                    _buildFeedbackIcon(),
                    Text(
                      _feedbackMessage ?? "",
                      style: _feedbackMessageStyle,
                      overflow: TextOverflow.fade,
                    )
                  ],
                )
              : const SizedBox.shrink()),
    );
  }

  Widget _buildFeedbackIcon() {
    switch (_feedBackType) {
      case FeedbackType.error:
        return Container(
          margin: const EdgeInsets.only(right: 8),
          height: 16,
          width: 16,
          // color: const Color(0XFFEA5455),
          child: SvgPicture.asset(
            "packages/hcm23_ui/assets/icons/bold/error.svg",
            fit: BoxFit.scaleDown,
          ),
        );
      case FeedbackType.warning:
        return Container(
          margin: const EdgeInsets.only(right: 8),
          height: 16,
          width: 16,
          // color: const Color(0XFFF3AA1C),
          child: SvgPicture.asset(
            "packages/hcm23_ui/assets/icons/bold/danger.svg",
            fit: BoxFit.scaleDown,
          ),
        );
      case FeedbackType.success:
        return Container(
          margin: const EdgeInsets.only(right: 8),
          height: 16,
          width: 16,
          // color: Colors.green,
          child: SvgPicture.asset(
            "packages/hcm23_ui/assets/icons/bold/tick_square.svg",
            fit: BoxFit.scaleDown,
          ),
        );
      case FeedbackType.none:
      default:
        return const SizedBox.shrink();
    }
  }

  // ==================================================================

  /// _buildTextFormField
  Padding _buildTextFormField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: TextFormField(
        controller: _controller,
        initialValue: _value,
        focusNode: _focusNode,
        style: _valueTextStyle,
        onChanged: widget.baseConfigs.onChanged,
        enabled: _enabled,
        readOnly: _readOnly,
        cursorColor: _cursorColor,
        cursorHeight: _cursorHeight,
        cursorWidth: _cursorWidth,
        decoration: _buildDecoration(),
        keyboardType: widget.baseConfigs.keyboardType,
        textCapitalization:
            widget.baseConfigs.textCapitalization ?? TextCapitalization.none,
        textInputAction: widget.baseConfigs.textInputAction,
        strutStyle: widget.baseConfigs.strutStyle,
        textDirection: widget.baseConfigs.textDirection,
        textAlign: widget.baseConfigs.textAlign ?? TextAlign.start,
        textAlignVertical: widget.baseConfigs.textAlignVertical,
        autofocus: widget.baseConfigs.autofocus ?? false,
        toolbarOptions: widget.baseConfigs.toolbarOptions,
        showCursor: widget.baseConfigs.showCursor,
        obscuringCharacter: widget.baseConfigs.obscuringCharacter ?? '•',
        obscureText: widget.baseConfigs.obscureText ?? false,
        autocorrect: widget.baseConfigs.autocorrect ?? true,
        smartDashesType: widget.baseConfigs.smartDashesType,
        smartQuotesType: widget.baseConfigs.smartQuotesType,
        enableSuggestions: widget.baseConfigs.enableSuggestions ?? true,
        maxLengthEnforcement: widget.baseConfigs.maxLengthEnforcement,
        maxLines: widget.baseConfigs.maxLines,
        minLines: widget.baseConfigs.minLines,
        expands: widget.baseConfigs.expands ?? false,
        maxLength: widget.baseConfigs.maxLength,
        onTap: widget.baseConfigs.onTap,
        onEditingComplete: widget.baseConfigs.onEditingComplete,
        onFieldSubmitted: widget.baseConfigs.onFieldSubmitted,
        onSaved: widget.baseConfigs.onSaved,
        inputFormatters: widget.baseConfigs.inputFormatters,
        cursorRadius: widget.baseConfigs.cursorRadius,
        keyboardAppearance: widget.baseConfigs.keyboardAppearance,
        scrollPadding:
            widget.baseConfigs.scrollPadding ?? const EdgeInsets.all(20.0),
        enableInteractiveSelection:
            widget.baseConfigs.enableInteractiveSelection,
        selectionControls: widget.baseConfigs.selectionControls,
        buildCounter: widget.baseConfigs.buildCounter,
        scrollPhysics: widget.baseConfigs.scrollPhysics,
        autofillHints: widget.baseConfigs.autofillHints,
        autovalidateMode: widget.baseConfigs.autovalidateMode,
        restorationId: widget.baseConfigs.restorationId,
        enableIMEPersonalizedLearning:
            widget.baseConfigs.enableIMEPersonalizedLearning ?? true,
        mouseCursor: widget.baseConfigs.mouseCursor,
      ),
    );
  }

  _buildDecoration() {
    return _decoration.copyWith(
      fillColor: _fillColor,
      filled: _buildFilled(),
      enabled: _enabled,
      isCollapsed: true,
      contentPadding: _contentPadding,
      hintText: _placeholderText,
      hintStyle: _placeholderTextStyle,
      prefix: widget.baseConfigs.decoration?.prefixIcon != null
          ? null
          : const SizedBox(
              width: 16,
            ),
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(),
      disabledBorder: _buildBorder(),
    );
  }

  OutlineInputBorder _buildBorder() {
    late Color borderColor;
    double opacity = !_enabled ? 0.5 : (_focusNode.hasFocus ? 0.5 : 1);

    switch (_feedBackType) {
      case FeedbackType.warning:
        borderColor = const Color(0XFFF3AA1C).withOpacity(opacity);

        break;
      case FeedbackType.error:
        borderColor = const Color(0XFFEA5455).withOpacity(opacity);

        break;
      case FeedbackType.success:
        borderColor = const Color(0XFF7966FF).withOpacity(opacity);

        break;
      case FeedbackType.none:
      default:
        borderColor = const Color(0XFFDBDFEF);
        break;
    }
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: borderColor,
      ),
    );
  }

  _buildPlaceholderTextStyle() {
    return tStyle.display14().w400().copyWith(
          color: const Color(0XFF586B8B).withOpacity(0.5),
        );
  }

  _buildValueTextStyle() {
    return tStyle.display14().w400().copyWith(
          color: const Color(0XFF3D5586),
        );
  }

  bool _buildFilled() {
    if (_feedBackType == FeedbackType.none && (!_enabled || _readOnly)) {
      return true;
    }
    return false;
  }
  // ==================================================================
}
