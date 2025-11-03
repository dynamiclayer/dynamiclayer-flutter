import 'package:flutter/material.dart';
import '../../tokens/dl_colors.dart';
import '../../tokens/dl_radius.dart';
import '../../tokens/dl_spacing.dart';
import '../../tokens/dl_typography.dart';

enum DLBadgeSize { sm, md }

class DLBadge extends StatelessWidget {
  const DLBadge({
    super.key,
    this.size = DLBadgeSize.md,
    this.count = 1,
    this.backgroundColor = DLColors.red500,
    this.foregroundColor = DLColors.white,
    this.minWidth,
    this.height,
    this.horizontalPadding,
    this.maxCount = 99, // still caps display to 99+
  });

  final DLBadgeSize size;
  final int count;

  final Color backgroundColor;
  final Color foregroundColor;

  final double? minWidth; // md default = 16
  final double? height; // md default = 16
  final double? horizontalPadding; // md default = p4
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final bool isMd = size == DLBadgeSize.md;

    if (!isMd) {
      // ── sm → dot only (8x8) ────────────────────────────────────────────────
      final double d = 8;
      return SizedBox(
        width: d,
        height: d,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: DLRadii.brFull,
          ),
        ),
      );
    }

    // ── md → count pill that hugs content ────────────────────────────────────
    final double resolvedMinWidth = minWidth ?? 16;
    final double resolvedHeight = height ?? 16;
    final double resolvedHPad = horizontalPadding ?? DLSpacing.p4;

    final String label = count > maxCount ? '$maxCount+' : '$count';

    return IntrinsicWidth(
      // ensures width is just text+padding (but >= minWidth)
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: resolvedMinWidth),
        child: SizedBox(
          height: resolvedHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: DLRadii.brFull,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: resolvedHPad),
              child: Center(
                child: Text(
                  label,
                  style: DLTypos.textXsBold(color: foregroundColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Anchor helper unchanged — keeps badge positioned on top of any child.
class DLBadgeAnchor extends StatelessWidget {
  const DLBadgeAnchor({
    super.key,
    required this.child,
    required this.badge,
    this.alignment = Alignment.topRight,
    this.offset = const Offset(0, 0),
    this.showIfZero = false,
  });

  final Widget child;
  final DLBadge badge;
  final Alignment alignment;
  final Offset offset;
  final bool showIfZero;

  bool _shouldShow() {
    if (badge.size == DLBadgeSize.sm) return true;
    // Only hide md when count==0 and showIfZero=false.
    if (!showIfZero && badge.count == 0) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final show = _shouldShow();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (show)
          Positioned.fill(
            child: Align(
              alignment: alignment,
              child: Transform.translate(offset: offset, child: badge),
            ),
          ),
      ],
    );
  }
}
