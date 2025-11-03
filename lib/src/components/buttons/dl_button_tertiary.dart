import 'package:flutter/material.dart';
import 'dl_button_enums.dart';
import 'dl_button_tokens.dart';
import '../../tokens/dl_colors.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers – Tertiary Button (updated)
/// ---------------------------------------------------------------------------
/// | State     | Background     | Text/Icon         | Border (color · width) |
/// |-----------|----------------|-------------------|------------------------|
/// | normal    | white          | black             | grey200 · 1.0          |
/// | hover     | white          | black             | grey300 · 1.0          |
/// | pressed   | grey200        | black             | grey300 · 1.0          |
/// | disabled  | white          | grey500 (#757575) | grey200 · 1.0          |
/// | active    | grey100        | black             | black  · 1.5           |
///
/// Interactions: normal→hover/press; hover→press; pressed/disabled/active→none.
class _DLTertiaryButton extends StatefulWidget {
  const _DLTertiaryButton({
    required this.label,
    required this.iconLeft,
    required this.iconRight,
    required this.onPressed,
    required this.enabled,
    required this.size,
    required this.state,
    required this.minWidth,
    required this.minHeight,
    required this.radius,
    required this.gap,
    required this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.fixedWidth = false,
  });

  final String label;
  final Widget? iconLeft;
  final Widget? iconRight;
  final VoidCallback? onPressed;
  final bool enabled;

  final DLButtonSize size;
  final DLButtonState state;

  final double minWidth;
  final double minHeight;

  final double radius;
  final double gap;
  final EdgeInsetsGeometry padding;

  // Optional overrides
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;

  /// If true, forces tight width/height; otherwise acts as min constraints.
  final bool fixedWidth;

  @override
  State<_DLTertiaryButton> createState() => _DLTertiaryButtonState();
}

class _DLTertiaryButtonState extends State<_DLTertiaryButton> {
  late DLButtonState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.enabled ? widget.state : DLButtonState.disabled;
  }

  @override
  void didUpdateWidget(covariant _DLTertiaryButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      _state = widget.enabled ? DLButtonState.normal : DLButtonState.disabled;
    } else if (widget.enabled && widget.state != oldWidget.state) {
      _state = widget.state;
    }
  }

  // Interaction permissions
  bool get _interactionsAllowed =>
      widget.enabled &&
      _state != DLButtonState.disabled &&
      _state != DLButtonState.pressed &&
      _state != DLButtonState.active;

  bool get _canHover => _state == DLButtonState.normal;
  bool get _canPress =>
      _state == DLButtonState.normal || _state == DLButtonState.hover;

  // ---- Colors (with overrides respected) ----
  Color get _background {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    switch (_state) {
      case DLButtonState.pressed:
        return DLColors.grey200; // pressed fill
      case DLButtonState.active:
        return DLColors.grey100; // ← updated (was white)
      default:
        return DLColors.white; // normal/hover/disabled
    }
  }

  Color get _foreground {
    if (widget.foregroundColor != null) return widget.foregroundColor!;
    switch (_state) {
      case DLButtonState.disabled:
        return DLColors.grey500; // ← updated (was grey600)
      default:
        return DLColors.black;
    }
  }

  Color get _borderClr {
    if (widget.borderColor != null) return widget.borderColor!;
    switch (_state) {
      case DLButtonState.active:
        return DLColors.black;
      case DLButtonState.hover:
      case DLButtonState.pressed:
        return DLColors.grey300;
      case DLButtonState.normal:
      case DLButtonState.disabled:
      default:
        return DLColors.grey200;
    }
  }

  double get _borderW {
    if (widget.borderWidth != null) return widget.borderWidth!;
    return _state == DLButtonState.active ? 1.5 : 1.0;
  }

  double get _iconSize => 20;

  // ---- Label typography (only change requested) ----
  // Tokens mapping requested:
  // - lg/md/sm → font/size/3, line-height font/line-height/3, letter-spacing 7
  // - xs       → font/size/2, line-height font/line-height/2, letter-spacing 7
  // Inter, weight 600 (Semibold).
  TextStyle _labelStyle(DLButtonSize size, Color color) {
    switch (size) {
      case DLButtonSize.xs:
        return const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 14, // font/size/2
          height: 18 / 14, // font/line-height/2
          letterSpacing:
              0.0, // font/letter-spacing/7 (wire your token if non-zero)
          color: null, // will be overridden below
        ).copyWith(color: color);
      case DLButtonSize.sm:
      case DLButtonSize.md:
      case DLButtonSize.lg:
      default:
        return const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          fontSize: 16, // font/size/3
          height: 20 / 16, // font/line-height/3
          letterSpacing:
              0.0, // font/letter-spacing/7 (wire your token if non-zero)
          color: null, // will be overridden below
        ).copyWith(color: color);
    }
  }

  // ---- Instant transitions (0ms) ----
  void _enterHover() {
    if (_interactionsAllowed && _canHover)
      setState(() => _state = DLButtonState.hover);
  }

  void _exitHover() {
    if (!_interactionsAllowed) return;
    if (_state == DLButtonState.hover)
      setState(() => _state = DLButtonState.normal);
  }

  void _pressDown() {
    if (_interactionsAllowed && _canPress)
      setState(() => _state = DLButtonState.pressed);
  }

  void _pressUpOrCancel() {
    if (!_interactionsAllowed) return;
    if (_state == DLButtonState.pressed)
      setState(() => _state = DLButtonState.hover);
  }

  @override
  Widget build(BuildContext context) {
    final labelText = Text(
      widget.label,
      // UPDATED: size-specific Inter Semibold text
      style: _labelStyle(widget.size, _foreground),
      softWrap: false,
      overflow: TextOverflow.visible,
    );

    final children = <Widget>[
      if (widget.iconLeft != null) ...[
        IconTheme(
          data: IconThemeData(color: _foreground, size: _iconSize),
          child: widget.iconLeft!,
        ),
        SizedBox(width: widget.gap),
      ],
      labelText,
      if (widget.iconRight != null) ...[
        SizedBox(width: widget.gap),
        IconTheme(
          data: IconThemeData(color: _foreground, size: _iconSize),
          child: widget.iconRight!,
        ),
      ],
    ];

    final constraints = widget.fixedWidth
        ? BoxConstraints.tightFor(
            width: widget.minWidth,
            height: widget.minHeight,
          )
        : BoxConstraints(
            minWidth: widget.minWidth,
            minHeight: widget.minHeight,
          );

    final content = ConstrainedBox(
      constraints: constraints,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(color: _borderClr, width: _borderW),
        ),
        child: Padding(
          padding: widget.padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );

    final interactive = MouseRegion(
      onEnter: _interactionsAllowed ? (_) => _enterHover() : null,
      onExit: _interactionsAllowed ? (_) => _exitHover() : null,
      cursor: _interactionsAllowed
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
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
      ),
    );

    return Semantics(
      button: true,
      enabled: widget.enabled && _state != DLButtonState.disabled,
      label: widget.label,
      child: interactive,
    );
  }
}

/// Public factory (hook from DynamicLayers.buttons.tertiary)
Widget buildTertiaryButton({
  required String label,
  Widget? iconLeft,
  Widget? iconRight,
  VoidCallback? onPressed,
  bool enabled = true,
  DLButtonSize size = DLButtonSize.lg,
  DLButtonState state = DLButtonState.normal,
  double? width,
  double? height,
  double? radius,
  double? gap,
  EdgeInsetsGeometry? padding,
  Color? backgroundColor,
  Color? foregroundColor,
  Color? borderColor,
  double? borderWidth,
  bool fixedWidth = false,
}) {
  return _DLTertiaryButton(
    label: label,
    iconLeft: iconLeft,
    iconRight: iconRight,
    onPressed: onPressed,
    enabled: enabled,
    size: size,
    state: state,
    minWidth: width ?? DLButtonTokens.widthOf(size),
    minHeight: height ?? DLButtonTokens.heightOf(size),
    radius: radius ?? DLButtonTokens.defaultRadius,
    gap: gap ?? DLButtonTokens.defaultGap,
    padding: padding ?? DLButtonTokens.padding(size),
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    borderColor: borderColor,
    borderWidth: borderWidth,
    fixedWidth: fixedWidth,
  );
}
