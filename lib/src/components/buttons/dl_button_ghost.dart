import 'package:flutter/material.dart';
import 'dl_button_enums.dart';
import 'dl_button_tokens.dart';
import '../../tokens/dl_colors.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers – Ghost Button (text + underline)
/// ---------------------------------------------------------------------------
/// Visual spec:
/// | State     | Background | Text/Icon            | Underline (color · thickness) |
/// |-----------|------------|----------------------|--------------------------------|
/// | normal    | transparent| black                | black · 1.0                    |
/// | hover     | transparent| black                | black · 1.0                    |
/// | pressed   | transparent| black                | black · 1.0                    |
/// | disabled  | transparent| grey500 (#757575)    | grey200 · 1.0                  |
/// | active    | transparent| black (bold)         | black · 1.2                    |
///
/// Interaction rules: normal→hover/press; hover→press; pressed/disabled/active→none.
///
/// Notes:
/// • Still uses size tokens for min width/height and padding so it aligns with your grid.
/// • Label never truncates; button grows to fit.
class _DLGhostButton extends StatefulWidget {
  const _DLGhostButton({
    required this.label,
    required this.iconLeft,
    required this.iconRight,
    required this.onPressed,
    required this.enabled,
    required this.size,
    required this.state,
    required this.minWidth,
    required this.minHeight,
    required this.padding,
    this.foregroundColor,
    this.fixedWidth = false,
    this.underlineThickness,
    this.underlineColor,
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
  final EdgeInsetsGeometry padding;

  /// Optional overrides
  final Color? foregroundColor;
  final bool fixedWidth;
  final double? underlineThickness;
  final Color? underlineColor;

  @override
  State<_DLGhostButton> createState() => _DLGhostButtonState();
}

class _DLGhostButtonState extends State<_DLGhostButton> {
  late DLButtonState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.enabled ? widget.state : DLButtonState.disabled;
  }

  @override
  void didUpdateWidget(covariant _DLGhostButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      _state = widget.enabled ? DLButtonState.normal : DLButtonState.disabled;
    } else if (widget.enabled && widget.state != oldWidget.state) {
      _state = widget.state;
    }
  }

  // Interactions
  bool get _interactionsAllowed =>
      widget.enabled &&
      _state != DLButtonState.disabled &&
      _state != DLButtonState.pressed &&
      _state != DLButtonState.active;

  bool get _canHover => _state == DLButtonState.normal;
  bool get _canPress =>
      _state == DLButtonState.normal || _state == DLButtonState.hover;

  // Colors
  Color get _fg {
    if (widget.foregroundColor != null) return widget.foregroundColor!;
    switch (_state) {
      case DLButtonState.disabled:
        return DLColors.grey500; // as requested
      default:
        return DLColors.black;
    }
  }

  Color get _lineColor {
    if (widget.underlineColor != null) return widget.underlineColor!;
    switch (_state) {
      case DLButtonState.disabled:
        return DLColors.grey200;
      default:
        return DLColors.black;
    }
  }

  double? get _lineThicknessDefaultOrOverride {
    // Per spec: "text-decoration-thickness: 0%" → let platform default (null).
    // If caller provides an override, use it.
    return widget.underlineThickness;
  }

  double get _iconSize => 18; // slightly smaller looks better for ghost text

  // Instant transitions (0ms)
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

  // ---------------------------------------------------------------------------
  // 👇 UPDATED: label typography per size
  // lg/md/sm → Inter Semibold, font/size/3, line-height font/line-height/3
  // xs       → Inter Semibold, font/size/2, line-height font/line-height/2
  // letter-spacing: token(7) not enforced (left as default unless you add it).
  // underline: solid, default thickness (unless override is provided).
  // ---------------------------------------------------------------------------
  TextStyle _labelStyleFor(DLButtonSize size) {
    late final double fs; // font-size
    late final double lhPx; // line-height in px
    switch (size) {
      case DLButtonSize.xs:
        fs = 12; // font/size/2
        lhPx = 16; // font/line-height/2
        break;
      case DLButtonSize.sm:
      case DLButtonSize.md:
      case DLButtonSize.lg:
      default:
        fs = 16; // font/size/3
        lhPx = 20; // font/line-height/3
        break;
    }

    // Base weight is 600; active state bumps to 700 below.
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: fs,
      height: lhPx / fs,
      fontWeight: FontWeight.w600,
      // If you have a fixed letter-spacing token (font/letter-spacing/7),
      // uncomment and set it here:
      // letterSpacing: YOUR_TOKEN_VALUE,
      color: _fg,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.solid,
      decorationColor: _lineColor,
      decorationThickness: _lineThicknessDefaultOrOverride,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _state == DLButtonState.active;

    final baseStyle = _labelStyleFor(
      widget.size,
    ).copyWith(fontWeight: isActive ? FontWeight.w700 : FontWeight.w600);

    final labelText = Text(
      widget.label,
      style: baseStyle,
      softWrap: false,
      overflow: TextOverflow.visible,
    );

    final children = <Widget>[
      if (widget.iconLeft != null) ...[
        IconTheme(
          data: IconThemeData(color: _fg, size: _iconSize),
          child: widget.iconLeft!,
        ),
        const SizedBox(width: 6),
      ],
      labelText,
      if (widget.iconRight != null) ...[
        const SizedBox(width: 6),
        IconTheme(
          data: IconThemeData(color: _fg, size: _iconSize),
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

    // Invisible box (keeps hit target & spacing consistent with other buttons)
    final content = ConstrainedBox(
      constraints: constraints,
      child: Padding(
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
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

/// Public factory – call via:
///   DynamicLayers.buttons.ghost(...)
Widget buildGhostButton({
  required String label,
  Widget? iconLeft,
  Widget? iconRight,
  VoidCallback? onPressed,
  bool enabled = true,
  DLButtonSize size = DLButtonSize.lg,
  DLButtonState state = DLButtonState.normal,
  double? width,
  double? height,
  EdgeInsetsGeometry? padding,
  Color? foregroundColor,
  bool fixedWidth = false,
  double? underlineThickness,
  Color? underlineColor,
}) {
  return _DLGhostButton(
    label: label,
    iconLeft: iconLeft,
    iconRight: iconRight,
    onPressed: onPressed,
    enabled: enabled,
    size: size,
    state: state,
    minWidth: width ?? DLButtonTokens.widthOf(size),
    minHeight: height ?? DLButtonTokens.heightOf(size),
    padding: padding ?? DLButtonTokens.padding(size),
    foregroundColor: foregroundColor,
    fixedWidth: fixedWidth,
    underlineThickness: underlineThickness,
    underlineColor: underlineColor,
  );
}
