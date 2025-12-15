// lib/src/components/chip/dl_chip.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// Chip sizes from design spec:
/// lg: 68 x 40
/// md: 56 x 28
/// sm: 44 x 20
enum DLChipSize { lg, md, sm }

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

  final String label;
  final DLChipSize size;
  final bool active;
  final bool enabled;
  final VoidCallback? onTap;
  final bool expanded;
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

  // ---- Colors (Black & White for active) ----------------------------------

  Color get _backgroundColor {
    if (_isDisabled) return DLColors.grey100;
    if (active) return DLColors.black;
    return DLColors.grey100; // inactive pill (light)
  }

  Color get _labelColor {
    if (_isDisabled) return DLColors.grey500;
    if (active) return DLColors.white;
    return DLColors.black;
  }

  // TextDecoration get _decoration =>
  //     _isDisabled ? TextDecoration.lineThrough : TextDecoration.none;

  // ---- Typography per size -------------------------------------------------

  TextStyle _labelTextStyle() {
    TextStyle base;
    switch (size) {
      case DLChipSize.lg:
        base = _isDisabled
            ? DLTypos.textBaseStrike(
                color: _labelColor,
              ).copyWith(height: 24 / 16)
            : DLTypos.textBaseSemibold(
                color: _labelColor,
              ).copyWith(height: 24 / 16);
        break;
      case DLChipSize.md:
        base = _isDisabled
            ? DLTypos.textSmStrike(color: _labelColor)
            : DLTypos.textSmSemibold(color: _labelColor);
        break;
      case DLChipSize.sm:
        base = _isDisabled
            ? DLTypos.textXsStrike(color: _labelColor)
            : DLTypos.textXsSemibold(color: _labelColor);
        break;
    }

    return base;
  }

  @override
  Widget build(BuildContext context) {
    final chipBody = Container(
      padding: _padding,
      constraints: BoxConstraints(minWidth: _minWidth, minHeight: _minHeight),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: DLRadii.brFull,
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: _labelTextStyle(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );

    final wrapped = expanded
        ? SizedBox(width: double.infinity, child: chipBody)
        : chipBody;

    return Semantics(
      button: true,
      enabled: !_isDisabled,
      selected: active,
      label: semanticLabel ?? label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _isDisabled ? null : onTap,
        child: wrapped,
      ),
    );
  }
}
