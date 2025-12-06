// lib/src/components/chip/dl_chip.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// Chip sizes from design spec:
/// lg: 68 x 40
/// md: 56 x 28
/// sm: 44 x 20
enum DLChipSize { lg, md, sm }

/// Filter/selection chip
///
/// Label typography per size:
/// - lg → Inter, 600, size 16 (font/size/3), line-height token 3
/// - md → Inter, 600, size 14 (font/size/2), line-height token 2
/// - sm → Inter, 600, size 12 (font/size/1), line-height token 1
///
/// Label colors:
/// - default → black (#000000)
/// - active  → violet600 (#7630F7)
/// - disabled → grey500 (#757575) + strikethrough
class DLChip extends StatelessWidget {
  const DLChip({
    super.key,
    required this.label,
    this.size = DLChipSize.lg,
    this.active = false,
    this.enabled = true,
    this.onTap,
    this.expanded = false,
    this.semanticLabel,
  });

  /// Chip label
  final String label;

  /// Size token
  final DLChipSize size;

  /// If true → use active label color
  final bool active;

  /// If false → disabled style (grey, strikethrough) and no interaction
  final bool enabled;

  /// Tap callback (ignored when [enabled] == false)
  final VoidCallback? onTap;

  /// If true → chip will stretch to take as much horizontal space as it can.
  final bool expanded;

  /// Optional semantics override
  final String? semanticLabel;

  bool get _isDisabled => !enabled;

  // ---- Size tokens ---------------------------------------------------------

  double get _minWidth {
    switch (size) {
      case DLChipSize.lg:
        return 68;
      case DLChipSize.md:
        return 56;
      case DLChipSize.sm:
        return 44;
    }
  }

  double get _minHeight {
    switch (size) {
      case DLChipSize.lg:
        return 40;
      case DLChipSize.md:
        return 28;
      case DLChipSize.sm:
        return 20;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case DLChipSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p16,
          vertical: DLSpacing.p8,
        );
      case DLChipSize.md:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p12,
          vertical: DLSpacing.p4,
        );
      case DLChipSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p8,
          vertical: DLSpacing.p2,
        );
    }
  }

  // ---- Label colors & decoration per state ---------------------------------

  Color get _labelColor {
    if (_isDisabled) return DLColors.grey500;
    if (active) return DLColors.violet600;
    return DLColors.black;
  }

  TextDecoration? get _decoration {
    if (_isDisabled) return TextDecoration.lineThrough;
    return TextDecoration.none;
  }

  // ---- Typography per size -------------------------------------------------

  TextStyle _labelTextStyle() {
    // base Inter style from tokens
    TextStyle base;
    switch (size) {
      case DLChipSize.lg:
        // font/size/3 (16) + font/line-height/3 (24)
        base = DLTypos.textBaseSemibold(
          color: _labelColor,
        ).copyWith(height: 24 / 16);
        break;
      case DLChipSize.md:
        // font/size/2 (14) + font/line-height/2 (20)
        base = DLTypos.textSmSemibold(color: _labelColor);
        break;
      case DLChipSize.sm:
        // font/size/1 (12) + font/line-height/1 (16)
        base = DLTypos.textXsSemibold(color: _labelColor);
        break;
    }

    // letter-spacing tokens are assumed to be 0 or close to default,
    // so we keep Flutter's default. Only decoration is overridden here.
    return base.copyWith(decoration: _decoration, decorationColor: _labelColor);
  }

  @override
  Widget build(BuildContext context) {
    final labelText = Text(
      label,
      style: _labelTextStyle(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );

    final chipBody = Container(
      padding: _padding,
      constraints: BoxConstraints(minWidth: _minWidth, minHeight: _minHeight),
      decoration: BoxDecoration(
        // Note: label spec controls text color;
        // background stays grey100/violet100 per earlier visual spec.
        color: DLColors.grey100,
        borderRadius: DLRadii.brFull,
      ),
      alignment: Alignment.center,
      child: labelText,
    );

    final wrapped = expanded
        ? SizedBox(width: double.infinity, child: chipBody)
        : chipBody;

    final interactive = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _isDisabled ? null : onTap,
      child: wrapped,
    );

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      selected: active,
      label: semanticLabel ?? label,
      child: interactive,
    );
  }
}
