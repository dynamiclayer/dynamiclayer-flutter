import 'package:flutter/material.dart';
import 'dl_button_enums.dart';
import 'dl_button_secondary.dart';
import 'dl_button_tokens.dart';
import '../../tokens/dl_colors.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers Button System – Primary Button
/// ---------------------------------------------------------------------------
///
/// Colors
/// | State     | Background | Text/Icon |
/// |-----------|------------|-----------|
/// | normal    | #000000    | White     |
/// | hover     | #1F1F1F    | White     |
/// | pressed   | #1F1F1F    | White     |
/// | disabled  | #EEEEEE    | #545454   |
/// | active    | #000000    | White     |
///
/// Interaction Rules
/// | State     | Allowed Interactions |
/// |-----------|----------------------|
/// | normal    | Hover, Pressing      |
/// | hover     | Pressing             |
/// | pressed   | None                 |
/// | disabled  | None                 |
/// | active    | None  *(visual=normal)* |
///

class DLPrimaryButton extends StatefulWidget {
  const DLPrimaryButton({
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
    required this.fixedWidth,
    required this.affordanceTextForIcons,
    required this.plusAffordance,
    required this.ellipsisAffordance,
  });

  final String label;
  final Widget? iconLeft;
  final Widget? iconRight;
  final VoidCallback? onPressed;
  final bool enabled;

  final DLButtonSize size;
  final DLButtonState state;

  /// Minimum width/height — button will expand to fit full content.
  final double minWidth;
  final double minHeight;

  final double radius;
  final double gap;
  final EdgeInsetsGeometry padding;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final bool fixedWidth;

  final bool affordanceTextForIcons;
  final String plusAffordance;
  final String ellipsisAffordance;

  @override
  State<DLPrimaryButton> createState() => _DLPrimaryButtonState();
}

class _DLPrimaryButtonState extends State<DLPrimaryButton> {
  late DLButtonState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.enabled ? widget.state : DLButtonState.disabled;
  }

  @override
  void didUpdateWidget(covariant DLPrimaryButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      _state = widget.enabled ? DLButtonState.normal : DLButtonState.disabled;
    } else if (widget.enabled && widget.state != oldWidget.state) {
      _state = widget.state;
    }
  }

  // ---------- Interaction permissions ----------
  bool get _interactionsAllowed =>
      widget.enabled &&
      _state != DLButtonState.disabled &&
      _state != DLButtonState.pressed &&
      _state != DLButtonState.active;

  bool get _canHover => _state == DLButtonState.normal;
  bool get _canPress =>
      _state == DLButtonState.normal || _state == DLButtonState.hover;

  // ---------- Colors ----------
  Color get _background {
    if (widget.backgroundColor != null) return widget.backgroundColor!;
    switch (_state) {
      case DLButtonState.normal:
      case DLButtonState.active:
        return DLColors.black; // #000000
      case DLButtonState.hover:
      case DLButtonState.pressed:
        return DLColors.grey800; // #1F1F1F
      case DLButtonState.disabled:
        return DLColors.grey100; // #EEEEEE
    }
  }

  Color get _foreground {
    if (widget.foregroundColor != null) return widget.foregroundColor!;
    switch (_state) {
      case DLButtonState.disabled:
        return DLColors.grey600; // #545454
      default:
        return Colors.white;
    }
  }

  // ---------- Icon emphasis (instant) ----------
  double get _iconSize {
    if (!widget.enabled) return 20;
    switch (_state) {
      case DLButtonState.hover:
        return 22;
      case DLButtonState.normal:
      case DLButtonState.active:
      case DLButtonState.pressed:
        return 21;
      case DLButtonState.disabled:
        return 20;
    }
  }

  // ---------- State transitions (0ms) ----------
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

  // ---------- Label Typography (Inter / 600) ----------
  TextStyle _labelStyle(DLButtonSize size) {
    // Token placeholders mapped to numbers:
    const double size2 = 14; // font/size/2
    const double size3 = 16; // font/size/3
    const double lineHeight2 = 20; // font/line-height/2
    const double lineHeight3 = 24; // font/line-height/3
    const double letterSpacing7 = 0.0; // font/letter-spacing/7

    double fontSize;
    double heightPx;
    switch (size) {
      case DLButtonSize.lg:
      case DLButtonSize.md:
      case DLButtonSize.sm:
        fontSize = size3;
        heightPx = lineHeight3;
        break;
      case DLButtonSize.xs:
        fontSize = size2;
        heightPx = lineHeight2;
        break;
    }

    return const TextStyle(
      fontFamily: 'Inter', // font/family/inter
      fontWeight: FontWeight.w600, // 600 = Semi Bold
    ).copyWith(
      fontSize: fontSize,
      height: heightPx / fontSize, // convert px line-height to Flutter multiple
      letterSpacing: letterSpacing7,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build effective label — by default we DO NOT add “+ …”,
    // so full text stays as provided.
    String effectiveLabel = widget.label;
    if (widget.affordanceTextForIcons && widget.enabled) {
      if (widget.iconLeft != null &&
          !effectiveLabel.trimLeft().startsWith('+')) {
        effectiveLabel = '${effectiveLabel}${widget.plusAffordance}';
      }
      if (widget.iconRight != null &&
          !effectiveLabel.trimRight().endsWith('…')) {
        effectiveLabel = '$effectiveLabel${widget.ellipsisAffordance}';
      }
    }

    final labelText = Text(
      effectiveLabel,
      // UPDATED: apply size-based Inter 600 typography
      style: _labelStyle(widget.size).copyWith(color: _foreground),
      softWrap: false,
      overflow: TextOverflow.visible, // <-- never truncate
    );

    final children = <Widget>[
      if (widget.iconLeft != null) ...[
        IconTheme(
          data: IconThemeData(color: _foreground, size: _iconSize),
          child: widget.iconLeft!,
        ),
        SizedBox(width: widget.gap),
      ],
      // No Flexible — let label use full width it needs
      labelText,
      if (widget.iconRight != null) ...[
        SizedBox(width: widget.gap),
        IconTheme(
          data: IconThemeData(color: _foreground, size: _iconSize),
          child: widget.iconRight!,
        ),
      ],
    ];

    // Use min constraints so the button can expand to fit full text.
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
        ),
        child: Padding(
          padding: widget.padding,
          child: Row(
            mainAxisSize: MainAxisSize.min, // <-- grow to content
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
