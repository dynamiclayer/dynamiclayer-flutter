// lib/src/components/input/dl_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../dynamiclayers.dart';

/// Icons (paths) – adjust to your own assets file if needed.
const String _iconAlertTriangleFilled =
    'assets/alerts/alert-triangle-filled.svg';
const String _iconCircleAlert = 'assets/alerts/circle_alert.svg';
const String _iconCircleCheck = 'assets/alerts/circle_check.svg';
const String _iconCircleX = 'assets/alerts/circle_x.svg';
const String _iconInfo = 'assets/alerts/info.svg';

enum DLInputFieldSize { lg, md, sm }

enum DLInputFieldType { normal, success, error, disabled }

class DLInputField extends StatefulWidget {
  const DLInputField({
    super.key,
    this.width = 343,
    this.size = DLInputFieldSize.lg,
    this.type = DLInputFieldType.normal,
    this.label,
    this.placeholder = 'Input Field',
    this.controller,
    this.onChanged,
    this.errorText,
    this.iconLeft,
    this.iconRight,
    this.enabled = true,
  });

  /// Fixed width (defaults to 343).
  final double width;

  final DLInputFieldSize size;
  final DLInputFieldType type;

  /// Small text shown above when active/filled.
  final String? label;

  /// Placeholder text inside the field.
  final String placeholder;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  /// Only used when [type] == error.
  final String? errorText;

  /// Custom leading / trailing icons (overrides status icons).
  final Widget? iconLeft;
  final Widget? iconRight;

  /// Overall enabled flag (in addition to [type] == disabled).
  final bool enabled;

  @override
  State<DLInputField> createState() => _DLInputFieldState();
}

class _DLInputFieldState extends State<DLInputField> {
  late TextEditingController _controller;
  late bool _ownsController;
  final FocusNode _focusNode = FocusNode();

  bool _hasText = false;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();
    _hasText = _controller.text.trim().isNotEmpty;
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
  }

  @override
  void didUpdateWidget(covariant DLInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (_ownsController) {
        _controller.dispose();
      }

      _ownsController = widget.controller == null;
      final newController = widget.controller ?? TextEditingController();
      newController.text = _controller.text;

      _controller.removeListener(_handleTextChange);
      _focusNode.removeListener(_handleFocusChange);

      _controller = newController;
      _hasText = _controller.text.trim().isNotEmpty;

      _controller.addListener(_handleTextChange);
      _focusNode.addListener(_handleFocusChange);
    }
  }

  void _handleTextChange() {
    final has = _controller.text.trim().isNotEmpty;
    if (has != _hasText) {
      setState(() => _hasText = has);
    }
    widget.onChanged?.call(_controller.text);
  }

  void _handleFocusChange() {
    setState(() => _hasFocus = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    if (_ownsController) {
      _controller.dispose();
    }
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  bool get _isEnabled =>
      widget.enabled && widget.type != DLInputFieldType.disabled;

  // ---------------------------------------------------------------------------
  // Layout tokens
  // ---------------------------------------------------------------------------

  EdgeInsets _padding() {
    // In spec: default vs active padding.
    final bool isActiveLike = _hasFocus || _hasText;
    switch (widget.size) {
      case DLInputFieldSize.lg:
        return isActiveLike
            ? const EdgeInsets.fromLTRB(
                DLSpacing.p16,
                DLSpacing.p8,
                DLSpacing.p16,
                DLSpacing.p8,
              )
            : const EdgeInsets.all(DLSpacing.p16);
      case DLInputFieldSize.md:
        return isActiveLike
            ? const EdgeInsets.fromLTRB(
                DLSpacing.p16,
                DLSpacing.p4,
                DLSpacing.p16,
                DLSpacing.p4,
              )
            : const EdgeInsets.fromLTRB(
                DLSpacing.p16,
                DLSpacing.p12,
                DLSpacing.p16,
                DLSpacing.p12,
              );
      case DLInputFieldSize.sm:
        return isActiveLike
            ? const EdgeInsets.fromLTRB(
                DLSpacing.p12,
                DLSpacing.p4,
                DLSpacing.p12,
                DLSpacing.p4,
              )
            : const EdgeInsets.fromLTRB(
                DLSpacing.p12,
                DLSpacing.p8,
                DLSpacing.p12,
                DLSpacing.p8,
              );
    }
  }

  double _minHeight() {
    // Token: min height for each size. Container will HUG content above this.
    switch (widget.size) {
      case DLInputFieldSize.lg:
        return 56;
      case DLInputFieldSize.md:
        return 48;
      case DLInputFieldSize.sm:
        return 40;
    }
  }

  Color _backgroundColor() {
    if (widget.type == DLInputFieldType.disabled) {
      return DLColors.grey100;
    }
    return DLColors.grey100;
  }

  // Only active (focused) has border; filled-but-not-focused = no border
  Color _borderColor() {
    if (!_hasFocus) {
      return Colors.transparent;
    }

    switch (widget.type) {
      case DLInputFieldType.normal:
        return DLColors.black;
      case DLInputFieldType.success:
        return DLColors.green600;
      case DLInputFieldType.error:
        return DLColors.red600;
      case DLInputFieldType.disabled:
        return Colors.transparent;
    }
  }

  double _borderWidth() {
    if (!_hasFocus || widget.type == DLInputFieldType.disabled) return 0;
    // Spec: 2px when active.
    return DLBorderWidth.w2;
  }

  TextStyle _placeholderStyle() {
    Color color = DLColors.grey500;
    if (widget.type == DLInputFieldType.error) {
      color = DLColors.red600;
    } else if (widget.type == DLInputFieldType.disabled) {
      color = DLColors.grey500;
    }
    TextDecoration? decoration = widget.type == DLInputFieldType.disabled
        ? TextDecoration.lineThrough
        : null;

    return DLTypos.textBaseRegular(
      color: color,
    ).copyWith(decoration: decoration);
  }

  TextStyle _textStyle() {
    Color color = DLColors.black;
    if (widget.type == DLInputFieldType.error) {
      color = DLColors.red600;
    } else if (widget.type == DLInputFieldType.disabled) {
      color = DLColors.grey500;
    }
    TextDecoration? decoration = widget.type == DLInputFieldType.disabled
        ? TextDecoration.lineThrough
        : null;

    return DLTypos.textBaseRegular(
      color: color,
    ).copyWith(decoration: decoration);
  }

  TextStyle _labelStyle() {
    Color color = DLColors.grey500;
    if (widget.type == DLInputFieldType.error) {
      color = DLColors.red600;
    } else if (widget.type == DLInputFieldType.success) {
      color = DLColors.green600;
    } else if (widget.type == DLInputFieldType.disabled) {
      color = DLColors.grey500;
    }
    TextDecoration? decoration = widget.type == DLInputFieldType.disabled
        ? TextDecoration.lineThrough
        : null;

    return DLTypos.textSmRegular(color: color).copyWith(decoration: decoration);
  }

  String? _statusIconAsset() {
    if (widget.iconRight != null) return null;

    switch (widget.type) {
      case DLInputFieldType.normal:
        return null;
      case DLInputFieldType.success:
        return _iconCircleCheck;
      case DLInputFieldType.error:
        return _iconCircleAlert;
      case DLInputFieldType.disabled:
        return _iconAlertTriangleFilled;
    }
  }

  /// UPDATED: return `null` for disabled so the SVG uses its own yellow color.
  Color? _statusIconColor() {
    switch (widget.type) {
      case DLInputFieldType.normal:
        return DLColors.grey500;
      case DLInputFieldType.success:
        return DLColors.green600;
      case DLInputFieldType.error:
        return DLColors.red600;
      case DLInputFieldType.disabled:
        return null; // keep original icon color
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showLabel = widget.label != null && (_hasFocus || _hasText);
    final statusAsset = _statusIconAsset();

    final field = Container(
      constraints: BoxConstraints(minHeight: _minHeight()),
      padding: _padding(),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(DLRadii.md),
        border: Border.all(color: _borderColor(), width: _borderWidth()),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.iconLeft != null) ...[
            widget.iconLeft!,
            const SizedBox(width: DLSpacing.p16),
          ],
          // Text column
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showLabel) ...[
                  Text(widget.label!, style: _labelStyle()),
                  const SizedBox(height: 2),
                ],
                TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: _isEnabled,
                  maxLines: 1,
                  style: _textStyle(),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: showLabel ? null : widget.placeholder,
                    hintStyle: _placeholderStyle(),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          if (statusAsset != null) ...[
            const SizedBox(width: DLSpacing.p16),
            SvgPicture.asset(
              statusAsset,
              width: 24,
              height: 24,
              color: _statusIconColor(), // color nullable, disabled keeps SVG
            ),
          ] else if (widget.iconRight != null) ...[
            const SizedBox(width: DLSpacing.p16),
            widget.iconRight!,
          ],
        ],
      ),
    );

    Widget result = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.width),
      child: field,
    );

    // Error wrapper with message below
    if (widget.type == DLInputFieldType.error && widget.errorText != null) {
      result = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          result,
          const SizedBox(height: DLSpacing.p4),
          Text(
            widget.errorText!,
            style: DLTypos.textSmRegular(color: DLColors.red600),
          ),
        ],
      );
    }

    return result;
  }
}
