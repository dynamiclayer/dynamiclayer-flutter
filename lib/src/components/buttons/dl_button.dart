// lib/src/components/buttons/dl_button.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers – DLButton (simplified: no hover/active, fixed colors)
/// ---------------------------------------------------------------------------
/// Variants: primary | secondary | tertiary | ghost
/// Press feedback: shows "pressed" color only while pointer is down.
/// Label: one line, ellipsis overflow. Icons: fixed 24x24 px.
/// Disabled text color rules:
/// • primary, secondary  -> DLColors.grey600
/// • tertiary, ghost     -> DLColors.grey500
/// Borders:
/// • secondary has NO border in any state
/// Ghost update:
/// • Always underlined (normal/pressed/disabled), per spec screenshot
/// ---------------------------------------------------------------------------
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
    this.width,
    this.height,
    this.radius,
    this.gap,
    this.padding,
    this.fixedWidth = false,

    // Optional affordance text
    this.affordanceTextForIcons = false,
    this.plusAffordance = ' +',
    this.ellipsisAffordance = ' …',

    // External state override
    this.state = DLButtonState.normal,
  });

  final DLButtonType type;
  final String label;
  final Widget? iconLeft;
  final Widget? iconRight;
  final VoidCallback? onPressed;
  final bool enabled;

  final DLButtonSize size;

  final double? width;
  final double? height;
  final double? radius;
  final double? gap;
  final EdgeInsetsGeometry? padding;
  final bool fixedWidth;

  final bool affordanceTextForIcons;
  final String plusAffordance;
  final String ellipsisAffordance;

  final DLButtonState state;

  @override
  State<DLButton> createState() => _DLButtonState();
}

class _DLButtonState extends State<DLButton> {
  DLButtonState _state = DLButtonState.normal;

  @override
  void initState() {
    super.initState();
    _state = _deriveInitialState();
  }

  @override
  void didUpdateWidget(covariant DLButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled ||
        widget.state != oldWidget.state) {
      _state = _deriveInitialState();
    }
  }

  DLButtonState _deriveInitialState() {
    if (widget.state != DLButtonState.normal) return widget.state;
    return widget.enabled ? DLButtonState.normal : DLButtonState.disabled;
  }

  bool get _interactionsAllowed =>
      widget.onPressed != null &&
      widget.enabled &&
      widget.state == DLButtonState.normal &&
      _state != DLButtonState.disabled;

  void _pressDown() {
    if (_interactionsAllowed) setState(() => _state = DLButtonState.pressed);
  }

  void _pressUpOrCancel() {
    if (widget.state != DLButtonState.normal) return; // forced state
    if (_state == DLButtonState.pressed)
      setState(() => _state = DLButtonState.normal);
  }

  EdgeInsetsGeometry get _padding {
    if (widget.padding != null) return widget.padding!;
    switch (widget.size) {
      case DLButtonSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p24,
          vertical: DLSpacing.p16,
        );
      case DLButtonSize.md:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p16,
          vertical: DLSpacing.p12,
        );
      case DLButtonSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p16,
          vertical: DLSpacing.p8,
        );
      case DLButtonSize.xs:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p12,
          vertical: DLSpacing.p6,
        );
    }
  }

  double get _radius => widget.radius ?? DLButtonTokens.defaultRadius;
  double get _gap => widget.gap ?? DLButtonTokens.defaultGap;
  double get _iconSize => 24;

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
    if (_state == DLButtonState.disabled) {
      switch (widget.type) {
        case DLButtonType.primary:
        case DLButtonType.secondary:
          return DLColors.grey600;
        case DLButtonType.tertiary:
        case DLButtonType.ghost:
          return DLColors.grey500;
      }
    }
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
    // primary, secondary, ghost => no border
    if (widget.type == DLButtonType.primary ||
        widget.type == DLButtonType.secondary ||
        widget.type == DLButtonType.ghost) {
      return null;
    }
    if (_state == DLButtonState.disabled) return DLColors.grey200;
    return _state == DLButtonState.pressed
        ? DLColors.grey300
        : DLColors.grey200;
  }

  double _borderWidth() {
    switch (widget.type) {
      case DLButtonType.primary:
      case DLButtonType.ghost:
      case DLButtonType.secondary:
        return 0;
      case DLButtonType.tertiary:
        return 1;
    }
  }

  TextStyle _labelStyle(Color color) {
    final base = () {
      switch (widget.size) {
        case DLButtonSize.xs:
          return DLTypos.textSmSemibold(color: color);
        case DLButtonSize.sm:
        case DLButtonSize.md:
        case DLButtonSize.lg:
          return DLTypos.textBaseSemibold(color: color);
      }
    }();

    // UPDATED: Ghost is ALWAYS underlined (normal/pressed/disabled).
    if (widget.type == DLButtonType.ghost) {
      return base.copyWith(
        decoration: TextDecoration.underline,
        decorationColor: color,
        decorationThickness: 1,
      );
    }

    return base;
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
    }
    // Ghost: keeps transparent background; padding already ensures tap area.

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
