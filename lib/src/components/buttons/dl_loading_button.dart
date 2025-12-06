import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';
import '../loaders/dl_loading_dots.dart';

/// Loading button – uses only the 3-dot loader as content.
/// Type & size match DLButton tokens.
class DLButtonLoading extends StatelessWidget {
  const DLButtonLoading({
    super.key,
    required this.type,
    this.size = DLButtonSize.lg,
    this.onPressed,
    this.tooltip,
    this.semanticsLabel,
  });

  final DLButtonType type;
  final DLButtonSize size;

  /// Optional tap (usually disabled while loading, but available if needed).
  final VoidCallback? onPressed;

  final String? tooltip;
  final String? semanticsLabel;

  double get _width {
    switch (size) {
      case DLButtonSize.lg:
        return 96.0;
      case DLButtonSize.md:
        return 80.0;
      case DLButtonSize.sm:
        return 80.0;
      case DLButtonSize.xs:
        return 72.0;
    }
  }

  double get _height {
    switch (size) {
      case DLButtonSize.lg:
        return 56.0;
      case DLButtonSize.md:
        return 48.0;
      case DLButtonSize.sm:
        return 40.0;
      case DLButtonSize.xs:
        return 32.0;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case DLButtonSize.lg:
        return const EdgeInsets.fromLTRB(
          DLSpacing.p24,
          DLSpacing.p20,
          DLSpacing.p24,
          DLSpacing.p20,
        );
      case DLButtonSize.md:
        return const EdgeInsets.fromLTRB(
          DLSpacing.p20,
          DLSpacing.p16,
          DLSpacing.p20,
          DLSpacing.p16,
        );
      case DLButtonSize.sm:
        return const EdgeInsets.fromLTRB(
          DLSpacing.p16,
          DLSpacing.p12,
          DLSpacing.p16,
          DLSpacing.p12,
        );
      case DLButtonSize.xs:
        return const EdgeInsets.fromLTRB(
          DLSpacing.p12,
          DLSpacing.p8,
          DLSpacing.p12,
          DLSpacing.p8,
        );
    }
  }

  Color _background() {
    switch (type) {
      case DLButtonType.primary:
        return DLColors.black;
      case DLButtonType.secondary:
        return DLColors.grey100;
      case DLButtonType.tertiary:
        return DLColors.white;
      case DLButtonType.ghost:
        return Colors.transparent;
    }
  }

  Color _dotColor() {
    switch (type) {
      case DLButtonType.primary:
        return DLColors.white;
      case DLButtonType.secondary:
      case DLButtonType.tertiary:
      case DLButtonType.ghost:
        return DLColors.black;
    }
  }

  double _borderWidth() {
    switch (type) {
      case DLButtonType.tertiary:
        return DLBorderWidth.w1;
      case DLButtonType.primary:
      case DLButtonType.secondary:
      case DLButtonType.ghost:
        return DLBorderWidth.w0;
    }
  }

  Color? _borderColor() {
    if (type != DLButtonType.tertiary) return null;
    return DLColors.grey200;
  }

  @override
  Widget build(BuildContext context) {
    final bg = _background();
    final dotsColor = _dotColor();
    final bw = _borderWidth();
    final bc = _borderColor();

    Widget button = SizedBox(
      width: _width,
      height: _height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: DLRadii.brMd, // rounded_md
          border: bw > 0 && bc != null
              ? Border.all(width: bw, color: bc)
              : null,
        ),
        child: Padding(
          padding: _padding,
          child: Center(
            // Loader adapts to available width (no overflow on md/xs)
            child: DLLoadingDots(color: dotsColor),
          ),
        ),
      ),
    );

    button = Semantics(
      button: true,
      enabled: onPressed != null,
      label: semanticsLabel ?? 'Loading',
      child: button,
    );

    if (onPressed != null) {
      button = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: button,
      );
    }

    if (tooltip != null && tooltip!.isNotEmpty) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}
