import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';
import 'dl_button_enums.dart';
import 'dl_button_tokens.dart';
import '../../tokens/dl_colors.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers Button System – Secondary Button
/// ---------------------------------------------------------------------------
///
/// Visual spec (from your image):
/// | State     | Background | Text/Icon | Border           |
/// |-----------|------------|-----------|------------------|
/// | normal    | grey-100   | black     | none             |
/// | hover     | grey-200   | black     | none             |
/// | pressed   | grey-300   | black     | none             |
/// | disabled  | grey-100   | grey-600  | none             |
/// | active    | white      | black     | black 1.0 width  |
///
/// Interaction rules are identical to Primary:
/// - normal: allows hover + pressing
/// - hover: allows pressing
/// - pressed: none
/// - disabled: none
/// - active: none (locked look)
///
/// API matches Primary: size, state, icons, min width/height, etc.
class _DLSecondaryButton extends StatefulWidget {
  const _DLSecondaryButton({
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

  /// Optional overrides
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;

  /// When true, forces tight width/height instead of min constraints.
  final bool fixedWidth;

  @override
  State<_DLSecondaryButton> createState() => _DLSecondaryButtonState();
}

class _DLSecondaryButtonState extends State<_DLSecondaryButton> {
  late DLButtonState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.enabled ? widget.state : DLButtonState.disabled;
  }

  @override
  void didUpdateWidget(covariant _DLSecondaryButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      _state = widget.enabled ? DLButtonState.normal : DLButtonState.disabled;
    } else if (widget.enabled && widget.state != oldWidget.state) {
      _state = widget.state;
    }
  }

  // Interaction permissions (same as Primary)
  bool get _interactionsAllowed =>
      widget.enabled &&
      _state != DLButtonState.disabled &&
      _state != DLButtonState.pressed &&
      _state != DLButtonState.active;

  bool get _canHover => _state == DLButtonState.normal;
  bool get _canPress =>
      _state == DLButtonState.normal || _state == DLButtonState.hover;

  // Colors per state, with optional overrides respected.
  Color get _background {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    switch (_state) {
      case DLButtonState.normal:
        return DLColors.grey100; // #EEEEEE
      case DLButtonState.hover:
        return DLColors.grey200; // #E2E2E2
      case DLButtonState.pressed:
        return DLColors.grey300; // #CBCBCB
      case DLButtonState.disabled:
        return DLColors.grey100; // #EEEEEE
      case DLButtonState.active:
        return DLColors.white; // outline look
    }
  }

  Color get _foreground {
    if (widget.foregroundColor != null) return widget.foregroundColor!;
    switch (_state) {
      case DLButtonState.disabled:
        return DLColors.grey600; // #545454
      default:
        return DLColors.black;
    }
  }

  // Outline for active state
  Color? get _borderColor {
    if (widget.borderColor != null) return widget.borderColor!;
    if (_state == DLButtonState.active) return DLColors.black;
    return null;
  }

  double get _borderWidth {
    if (widget.borderWidth != null) return widget.borderWidth!;
    return _state == DLButtonState.active ? 1.0 : 0.0;
  }

  // Icons: keep consistent size (no emphasis on secondary)
  double get _iconSize => 20;

  // ✨ size-aware label style (Inter, 600) + token letter-spacing
  TextStyle _labelStyleFor(DLButtonSize size, Color color) {
    switch (size) {
      // lg / md / sm → font/size/3 & line-height/3 (Inter, 600)
      case DLButtonSize.lg:
      case DLButtonSize.md:
      case DLButtonSize.sm:
        return DLTypos.textBaseSemibold(color: color);
      // xs → font/size/2 & line-height/2 (Inter, 600)
      case DLButtonSize.xs:
        return DLTypos.textSmSemibold(color: color);
    }
  }

  // State transitions
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
      // ⬇️ updated to size-aware Inter Semibold + letter-spacing token
      style: _labelStyleFor(widget.size, _foreground),
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
          border: _borderColor != null
              ? Border.all(color: _borderColor!, width: _borderWidth)
              : null,
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

/// ---------------------- Public factory method -------------------------------
/// Call via:
///   DynamicLayers.buttons.secondary(...)
Widget buildSecondaryButton({
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
  return _DLSecondaryButton(
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
