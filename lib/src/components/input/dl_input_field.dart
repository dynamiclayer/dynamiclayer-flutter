// lib/src/components/input/dl_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../dynamiclayers.dart';

/// Optional status icons (only used when showRightIcon == false)
const String _iconAlertTriangleFilled =
    'assets/alerts/alert-triangle-filled.svg';
const String _iconCircleAlert = 'assets/alerts/circle_alert.svg';
const String _iconCircleCheck = 'assets/alerts/circle_check.svg';

enum DLInputFieldSize { lg, md, sm }

/// Kept for backwards compatibility.
enum DLInputFieldType { normal, success, error, disabled }

class DLInputField extends StatefulWidget {
  const DLInputField({
    super.key,

    /// Requirement: width is HUG (not fixed)
    /// Keep for backwards compatibility; if null => hug/expand by parent.
    this.width,

    this.size = DLInputFieldSize.lg,
    this.type = DLInputFieldType.normal,

    /// You can still pass label, but now the "placeholder/hint" floats.
    /// If label is provided, it will be used as the floating text instead of placeholder.
    this.label,

    /// Requirement: placeholder (hint) floats to top when focused/typing.
    this.placeholder = 'Input Field',

    this.controller,
    this.onChanged,

    /// Only shown when type == error.
    this.errorText,

    /// Requirement: default left/right icon = const Icon(Icons.fullscreen)
    this.leftIcon,
    this.rightIcon,

    /// Requirement: bools to show/hide left & right icon
    this.showLeftIcon = false,
    this.showRightIcon = false,

    this.enabled = true,
  });

  /// If null => hug/expand.
  final double? width;

  final DLInputFieldSize size;
  final DLInputFieldType type;

  /// Optional floating label override.
  final String? label;

  /// Hint text (and floating label when label == null).
  final String placeholder;

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  final String? errorText;

  final Widget? leftIcon;
  final Widget? rightIcon;

  final bool showLeftIcon;
  final bool showRightIcon;

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

  static const Widget _defaultSideIcon = Icon(Icons.fullscreen);

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
      if (_ownsController) _controller.dispose();

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
    if (has != _hasText) setState(() => _hasText = has);
    widget.onChanged?.call(_controller.text);
  }

  void _handleFocusChange() {
    setState(() => _hasFocus = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    if (_ownsController) _controller.dispose();

    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  bool get _isEnabled =>
      widget.enabled && widget.type != DLInputFieldType.disabled;

  // ---------------------------------------------------------------------------
  // Layout tokens
  // ---------------------------------------------------------------------------

  double _minHeight() {
    switch (widget.size) {
      case DLInputFieldSize.lg:
        return 56;
      case DLInputFieldSize.md:
        return 48;
      case DLInputFieldSize.sm:
        return 40;
    }
  }

  EdgeInsets _containerPadding() {
    // IMPORTANT: keep padding stable to avoid “jump”
    switch (widget.size) {
      case DLInputFieldSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p16,
          vertical: DLSpacing.p8,
        );
      case DLInputFieldSize.md:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p16,
          vertical: DLSpacing.p6,
        );
      case DLInputFieldSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p12,
          vertical: DLSpacing.p4,
        );
    }
  }

  Color _backgroundColor() => DLColors.grey100;

  /// Requirement: active black 2 border, but no jump.
  /// Solution: ALWAYS keep border width = 2 (transparent when inactive).
  Color _borderColor() {
    if (widget.type == DLInputFieldType.disabled) return Colors.transparent;
    if (_hasFocus) return DLColors.black;
    return Colors.transparent;
  }

  double _borderWidth() => DLBorderWidth.w2;

  // ---------------------------------------------------------------------------
  // Typography / colors
  // ---------------------------------------------------------------------------

  Color _hintColor() {
    // Requirement: only placeholder/hint changes color for error/success
    switch (widget.type) {
      case DLInputFieldType.error:
        return DLColors.red600;
      case DLInputFieldType.success:
        return DLColors.green600;
      case DLInputFieldType.disabled:
        return DLColors.grey500;
      case DLInputFieldType.normal:
        return DLColors.grey500;
    }
  }

  // TextDecoration? _disabledDecoration() {
  //   return widget.type == DLInputFieldType.disabled
  //       ? TextDecoration.lineThrough
  //       : null;
  // }

  /// Requirement: text inside remains black even in error/success.
  TextStyle _textStyle() {
    final color = widget.type == DLInputFieldType.disabled
        ? DLColors.grey500
        : DLColors.black;

    return widget.type == DLInputFieldType.disabled
        ? DLTypos.textBaseStrike(color: color)
        : DLTypos.textBaseRegular(color: color);
  }

  /// Hint when it sits inside (rare; mainly labelText is used) + general hint style.
  TextStyle _hintStyle() {
    return widget.type == DLInputFieldType.disabled
        ? DLTypos.textBaseStrike(color: _hintColor())
        : DLTypos.textBaseRegular(color: _hintColor());
  }

  /// Floating label style (small, at top when focused/typing).
  TextStyle _floatingLabelStyle() {
    // Use sm to satisfy “small” requirement
    return widget.type == DLInputFieldType.disabled
        ? DLTypos.textBaseStrike(color: _hintColor())
        : DLTypos.textSmRegular(color: _hintColor());
  }

  // ---------------------------------------------------------------------------
  // Status icon logic (only if showRightIcon == false)
  // ---------------------------------------------------------------------------

  String? _statusIconAsset() {
    if (widget.showRightIcon) return null;

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

  Widget _buildLeftIcon() {
    final icon = widget.leftIcon ?? _defaultSideIcon;
    return IconTheme(
      data: IconThemeData(
        size: 24,
        color: widget.type == DLInputFieldType.disabled
            ? DLColors.grey500
            : DLColors.grey500,
      ),
      child: icon,
    );
  }

  Widget _buildRightIcon() {
    final icon = widget.rightIcon ?? _defaultSideIcon;
    return IconTheme(
      data: IconThemeData(
        size: 24,
        color: widget.type == DLInputFieldType.disabled
            ? DLColors.grey500
            : DLColors.grey500,
      ),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusAsset = _statusIconAsset();

    // Requirement: placeholder/hint floats to top when focused/typing.
    // Use labelText + floatingLabelBehavior.
    final floatingText = widget.label ?? widget.placeholder;

    final field = Container(
      constraints: BoxConstraints(minHeight: _minHeight()),
      padding: _containerPadding(),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(DLRadii.md),
        border: Border.all(color: _borderColor(), width: _borderWidth()),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.showLeftIcon) ...[
            _buildLeftIcon(),
            const SizedBox(width: DLSpacing.p16),
          ],

          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: _isEnabled,
              maxLines: 1,
              style: _textStyle(),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,

                // floating “placeholder”
                labelText: floatingText,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: _hintStyle(), // when resting inside
                floatingLabelStyle: _floatingLabelStyle(),

                // when empty and not focused, label sits inside (acts like hint)
                hintText: null,
                hintStyle: _hintStyle(),

                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          if (widget.showRightIcon) ...[
            const SizedBox(width: DLSpacing.p16),
            _buildRightIcon(),
          ] else if (statusAsset != null) ...[
            const SizedBox(width: DLSpacing.p16),
            SvgPicture.asset(
              statusAsset,
              width: 24,
              height: 24,
              color: _statusIconColor(),
            ),
          ],
        ],
      ),
    );

    Widget result = field;

    // width = hug by default; only constrain if width provided
    if (widget.width != null) {
      result = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: widget.width!),
        child: result,
      );
    }

    // error text below stays red; input text remains black (requirement)
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
