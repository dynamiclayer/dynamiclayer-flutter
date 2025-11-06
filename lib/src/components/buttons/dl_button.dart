// lib/src/components/buttons/dl_button.dart
import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers – DLButton (simplified: no hover/active, fixed colors)
/// ---------------------------------------------------------------------------
/// Variants: primary | secondary | tertiary | ghost
/// Press feedback: shows "pressed" color only while pointer is down.
/// Label: one line, ellipsis overflow.
/// Icons: fixed 24x24 px.
/// Usage:
/// DLButton(
///   type: DLButtonType.primary, // primary | secondary | tertiary | ghost
///   label: 'Continue',
///   iconLeft: Icon(Icons.add),
///   onPressed: () {},
///   size: DLButtonSize.lg,
///   state: DLButtonState.normal,
/// )

class DLButton extends StatefulWidget {
  const DLButton({
    super.key,
    // Core
    required this.type,
    required this.label,
    this.iconLeft,
    this.iconRight,
    this.onPressed,
    this.enabled = true,

    // Tokens
    this.size = DLButtonSize.lg,

    // Optional overrides (HUG by default)
    this.width, // if null => hug
    this.height, // if null => hug
    this.radius,
    this.gap,
    this.padding, // if null => size-based padding from Figma
    this.fixedWidth = false, // ignored unless width is provided
    // Optional affordance text
    this.affordanceTextForIcons = false,
    this.plusAffordance = ' +',
    this.ellipsisAffordance = ' …',
  });

  final DLButtonType type;
  final String label;
  final Widget? iconLeft;
  final Widget? iconRight;
  final VoidCallback? onPressed;
  final bool enabled;

  final DLButtonSize size;

  // By default we DO NOT set any constraints (hug). If provided, we respect them.
  final double? width;
  final double? height;
  final double? radius;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final bool fixedWidth;

  final bool affordanceTextForIcons;
  final String plusAffordance;
  final String ellipsisAffordance;

  @override
  State<DLButton> createState() => _DLButtonState();
}

class _DLButtonState extends State<DLButton> {
  DLButtonState _state = DLButtonState.normal;

  @override
  void initState() {
    super.initState();
    _state = widget.enabled ? DLButtonState.normal : DLButtonState.disabled;
  }

  @override
  void didUpdateWidget(covariant DLButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      _state = widget.enabled ? DLButtonState.normal : DLButtonState.disabled;
    }
  }

  bool get _interactionsAllowed =>
      widget.enabled && _state != DLButtonState.disabled;

  void _pressDown() {
    if (_interactionsAllowed) setState(() => _state = DLButtonState.pressed);
  }

  void _pressUpOrCancel() {
    if (_state == DLButtonState.pressed)
      setState(() => _state = DLButtonState.normal);
  }

  // ----- Size-based padding from Figma (HUG sizing) -----
  EdgeInsetsGeometry get _padding {
    if (widget.padding != null) return widget.padding!;
    switch (widget.size) {
      case DLButtonSize.lg:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
      case DLButtonSize.md:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case DLButtonSize.sm:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case DLButtonSize.xs:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    }
  }

  // Optional corner radius & gap fallbacks (you can plug into tokens if needed)
  double get _radius => widget.radius ?? DLButtonTokens.defaultRadius;
  double get _gap => widget.gap ?? DLButtonTokens.defaultGap;

  // Fixed icon size (Figma)
  double get _iconSize => 24;

  // ----- Fixed colors per style (normal/pressed/disabled) -----
  Color _background() {
    if (_state == DLButtonState.disabled) {
      switch (widget.type) {
        case DLButtonType.primary:
        case DLButtonType.secondary:
          return DLColors.grey100;
        case DLButtonType.tertiary:
          return DLColors.white;
        case DLButtonType.ghost:
          return Colors.transparent;
      }
    }
    final isPressed = _state == DLButtonState.pressed;
    switch (widget.type) {
      case DLButtonType.primary:
        return isPressed ? DLColors.grey800 : DLColors.black;
      case DLButtonType.secondary:
        return isPressed ? DLColors.grey300 : DLColors.grey100;
      case DLButtonType.tertiary:
        return isPressed ? DLColors.grey200 : DLColors.white;
      case DLButtonType.ghost:
        return Colors.transparent;
    }
  }

  Color _foreground() {
    if (_state == DLButtonState.disabled) return DLColors.grey600;
    switch (widget.type) {
      case DLButtonType.primary:
        return Colors.white;
      case DLButtonType.secondary:
      case DLButtonType.tertiary:
      case DLButtonType.ghost:
        return DLColors.black;
    }
  }

  Color? _borderColor() {
    if (widget.type == DLButtonType.primary ||
        widget.type == DLButtonType.ghost)
      return null;
    if (_state == DLButtonState.disabled) return DLColors.grey200;
    return _state == DLButtonState.pressed
        ? DLColors.grey300
        : DLColors.grey200;
  }

  double _borderWidth() {
    switch (widget.type) {
      case DLButtonType.primary:
      case DLButtonType.ghost:
        return 0;
      case DLButtonType.secondary:
      case DLButtonType.tertiary:
        return 1;
    }
  }

  TextStyle _labelStyle(Color color) {
    switch (widget.size) {
      case DLButtonSize.xs:
        return DLTypos.textSmSemibold(color: color);
      case DLButtonSize.sm:
      case DLButtonSize.md:
      case DLButtonSize.lg:
        return DLTypos.textBaseSemibold(color: color);
    }
  }

  String get _effectiveLabel {
    if (!widget.affordanceTextForIcons || !widget.enabled) return widget.label;
    var txt = widget.label;
    if (widget.iconLeft != null && !txt.trimLeft().startsWith('+')) {
      txt = '$txt${widget.plusAffordance}';
    }
    if (widget.iconRight != null && !txt.trimRight().endsWith('…')) {
      txt = '$txt${widget.ellipsisAffordance}';
    }
    return txt;
  }

  @override
  Widget build(BuildContext context) {
    final fg = _foreground();
    final bg = _background();
    final borderClr = _borderColor();
    final borderW = _borderWidth();

    final label = Text(
      _effectiveLabel,
      style: _labelStyle(fg),
      softWrap: false,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    final rowChildren = <Widget>[
      if (widget.iconLeft != null) ...[
        IconTheme(
          data: IconThemeData(color: fg, size: _iconSize),
          child: widget.iconLeft!,
        ),
        SizedBox(width: _gap),
      ],
      Flexible(child: label),
      if (widget.iconRight != null) ...[
        SizedBox(width: _gap),
        IconTheme(
          data: IconThemeData(color: fg, size: _iconSize),
          child: widget.iconRight!,
        ),
      ],
    ];

    // HUG sizing: no minWidth/minHeight constraints unless width/height provided
    Widget content = Padding(
      padding: _padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: rowChildren,
      ),
    );

    if (widget.type != DLButtonType.ghost) {
      content = DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(_radius),
          border: borderClr != null
              ? Border.all(color: borderClr, width: borderW)
              : null,
        ),
        child: content,
      );
    } else {
      // Ghost needs the text color but no fill; wrap to keep tap area = padding
      content = DecoratedBox(decoration: const BoxDecoration(), child: content);
    }

    // Only add constraints if explicit sizing is requested.
    if (widget.width != null || widget.height != null) {
      final box = BoxConstraints(
        minWidth: widget.fixedWidth ? (widget.width ?? 0) : 0,
        minHeight: 0,
        maxWidth: widget.width ?? double.infinity,
        maxHeight: widget.height ?? double.infinity,
      );
      content = ConstrainedBox(constraints: box, child: content);
    }

    final interactive = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _interactionsAllowed ? (_) => _pressDown() : null,
      onTapUp: _interactionsAllowed
          ? (_) {
              _pressUpOrCancel();
              widget.onPressed?.call();
            }
          : null,
      onTapCancel: _interactionsAllowed ? _pressUpOrCancel : null,
      child: Focus(canRequestFocus: _interactionsAllowed, child: content),
    );

    return Semantics(
      button: true,
      enabled: widget.enabled && _state != DLButtonState.disabled,
      label: widget.label,
      child: interactive,
    );
  }
}
