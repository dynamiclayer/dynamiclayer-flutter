// lib/src/components/buttons/dl_icon_button.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// Types: primary / secondary / tertiary
enum DLIconButtonType { primary, secondary, tertiary }

/// Visual state (can be controlled or auto-managed)
enum DLIconButtonState { normal, hover, pressed, disabled }

/// Sizes: lg / md / sm / xs
enum DLIconButtonSize { lg, md, sm, xs }

class DLIconButton extends StatefulWidget {
  const DLIconButton({
    super.key,
    required this.type,
    required this.icon,
    this.size = DLIconButtonSize.lg,
    this.state = DLIconButtonState.normal,
    this.onPressed,
    this.tooltip,
    this.semanticsLabel,
  });

  /// Visual variant
  final DLIconButtonType type;

  /// Icon widget (24x24 is recommended)
  final Widget icon;

  /// Size token (container + padding)
  final DLIconButtonSize size;

  /// State:
  /// - normal  → interactive, uses hover/pressed from pointer
  /// - hover   → forced hover visuals, no interaction
  /// - pressed → forced pressed visuals, no interaction
  /// - disabled→ forced disabled visuals, no interaction
  final DLIconButtonState state;

  /// Tap callback (if null → treated as disabled)
  final VoidCallback? onPressed;

  /// Optional tooltip (desktop/web)
  final String? tooltip;

  /// Optional semantics override for screen readers
  final String? semanticsLabel;

  @override
  State<DLIconButton> createState() => _DLIconButtonState();
}

class _DLIconButtonState extends State<DLIconButton> {
  bool _hovering = false;
  bool _pressed = false;

  bool get _isControlled => widget.state != DLIconButtonState.normal;

  bool get _canInteract => !_isControlled && widget.onPressed != null;

  // Size tokens from your JSON
  double get _dimension {
    switch (widget.size) {
      case DLIconButtonSize.lg:
        return 56;
      case DLIconButtonSize.md:
        return 48;
      case DLIconButtonSize.sm:
        return 40;
      case DLIconButtonSize.xs:
        return 32;
    }
  }

  EdgeInsets get _padding {
    switch (widget.size) {
      case DLIconButtonSize.lg:
        return const EdgeInsets.all(DLSpacing.p16);
      case DLIconButtonSize.md:
        return const EdgeInsets.all(DLSpacing.p12);
      case DLIconButtonSize.sm:
        return const EdgeInsets.all(DLSpacing.p8);
      case DLIconButtonSize.xs:
        return const EdgeInsets.all(DLSpacing.p4);
    }
  }

  double get _iconSize => 24;

  DLIconButtonState get _effectiveState {
    // Explicit state wins
    if (_isControlled) return widget.state;

    // Auto state based on pointer *and* having onPressed
    if (widget.onPressed == null) return DLIconButtonState.disabled;
    if (_pressed) return DLIconButtonState.pressed;
    if (_hovering) return DLIconButtonState.hover;
    return DLIconButtonState.normal;
  }

  Color _background(DLIconButtonState state) {
    switch (widget.type) {
      case DLIconButtonType.primary:
        switch (state) {
          case DLIconButtonState.normal:
          case DLIconButtonState.hover:
          case DLIconButtonState.pressed:
            return DLColors.black;
          case DLIconButtonState.disabled:
            return DLColors.grey100; // visually matches your grid
        }
      case DLIconButtonType.secondary:
        switch (state) {
          case DLIconButtonState.normal:
            return DLColors.grey100;
          case DLIconButtonState.hover:
            return DLColors.grey200;
          case DLIconButtonState.pressed:
            return DLColors.grey300;
          case DLIconButtonState.disabled:
            return DLColors.grey100;
        }
      case DLIconButtonType.tertiary:
        switch (state) {
          case DLIconButtonState.normal:
            return DLColors.white;
          case DLIconButtonState.hover:
            return DLColors.grey50;
          case DLIconButtonState.pressed:
            return DLColors.grey100;
          case DLIconButtonState.disabled:
            return DLColors.white;
        }
    }
  }

  Color _iconColor(DLIconButtonState state) {
    switch (widget.type) {
      case DLIconButtonType.primary:
        return state == DLIconButtonState.disabled
            ? DLColors.grey400
            : DLColors.white;
      case DLIconButtonType.secondary:
      case DLIconButtonType.tertiary:
        return state == DLIconButtonState.disabled
            ? DLColors.grey400
            : DLColors.black;
    }
  }

  double _borderWidth() {
    switch (widget.type) {
      case DLIconButtonType.primary:
      case DLIconButtonType.secondary:
        return DLBorderWidth.w0;
      case DLIconButtonType.tertiary:
        return DLBorderWidth.w1;
    }
  }

  Color? _borderColor(DLIconButtonState state) {
    if (widget.type != DLIconButtonType.tertiary) return null;
    // Tertiary border is always grey200 in all states (per spec)
    return DLColors.grey200;
  }

  void _handleTapDown(TapDownDetails _) {
    if (!_canInteract) return;
    setState(() => _pressed = true);
  }

  void _handleTapUp(TapUpDetails _) {
    if (!_canInteract) return;
    setState(() => _pressed = false);
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (!_canInteract) return;
    setState(() => _pressed = false);
  }

  void _handleHover(bool hovering) {
    if (!_canInteract) return;
    setState(() => _hovering = hovering);
  }

  @override
  Widget build(BuildContext context) {
    final state = _effectiveState;
    final bg = _background(state);
    final iconColor = _iconColor(state);
    final bw = _borderWidth();
    final bc = _borderColor(state);

    Widget content = DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: DLRadii.brMd, // rounded_md
        border: bw > 0 && bc != null ? Border.all(width: bw, color: bc) : null,
      ),
      child: Padding(
        padding: _padding,
        child: Center(
          child: IconTheme(
            data: IconThemeData(size: _iconSize, color: iconColor),
            child: widget.icon,
          ),
        ),
      ),
    );

    final semantics = Semantics(
      button: true,
      enabled: state != DLIconButtonState.disabled,
      label: widget.semanticsLabel,
      child: content,
    );

    final withHover = MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: semantics,
    );

    final interactive = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _canInteract ? _handleTapDown : null,
      onTapUp: _canInteract ? _handleTapUp : null,
      onTapCancel: _canInteract ? _handleTapCancel : null,
      child: withHover,
    );

    if (widget.tooltip != null && widget.tooltip!.isNotEmpty) {
      return Tooltip(message: widget.tooltip!, child: interactive);
    }
    return interactive;
  }
}
