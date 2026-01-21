import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

enum DLTextareaState { defaultState, active, filled, disabled }

class DLTextarea extends StatelessWidget {
  const DLTextarea({
    super.key,
    this.state = DLTextareaState.defaultState,
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.maxLines,
  });

  final DLTextareaState state;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  /// Default state uses this as placeholder: "Tell us something about you"
  final String? hintText;

  final ValueChanged<String>? onChanged;

  /// Figma height is fixed (128). This lets content wrap.
  /// If not provided, we use null (TextField decides), but the widget is height-fixed anyway.
  final int? maxLines;

  static const double _height = 128.0;

  bool get _isDisabled => state == DLTextareaState.disabled;
  bool get _isActive => state == DLTextareaState.active;

  TextStyle _baseTextStyle(BuildContext context) {
    // Per your instruction: use DLTypos.textBaseRegular
    return DLTypos.textBaseRegular();
  }

  TextStyle _valueStyle(BuildContext context) {
    final base = _baseTextStyle(context);

    // Filled text in Figma appears as normal text (black).
    // Disabled: line through.
    return base.copyWith(
      color: DLColors.black,
      decoration: _isDisabled
          ? TextDecoration.lineThrough
          : TextDecoration.none,
    );
  }

  TextStyle _hintStyle(BuildContext context) {
    final base = _baseTextStyle(context);
    return base.copyWith(
      color: const Color(0xFF757575),
      decoration: TextDecoration.none,
    );
  }

  BoxDecoration _decoration() {
    // Background color always #EEEEEE
    // Active: 2px black border
    // Others: no border
    return BoxDecoration(
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(DLRadii.md),
      border: _isActive
          ? Border.all(color: DLColors.black, width: DLBorderWidth.w2)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: DecoratedBox(
        decoration: _decoration(),
        child: Padding(
          // Figma padding: p_16
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            enabled: !_isDisabled,
            readOnly: _isDisabled,
            maxLines: maxLines ?? null,
            style: _valueStyle(context),
            cursorColor: DLColors.black,
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: _hintStyle(context),
              // No extra padding; we already applied p_16 on the container
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: _isDisabled ? null : onChanged,
          ),
        ),
      ),
    );
  }
}
