import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';
import '../radio/dl_radio_button.dart';

enum DLRadioGroupVariant { v1, v2, v3, v4, v5 }

enum DLRadioGroupLayout { column, twoColumn }

class DLRadioGroup extends StatelessWidget {
  const DLRadioGroup({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    this.variant = DLRadioGroupVariant.v5,
    this.layout = DLRadioGroupLayout.column, // ✅ default = one per line
    this.enabled = true,
    this.rowGap = 16,
    this.columnGap = 48,
  }) : assert(labels.length > 0);

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  final DLRadioGroupVariant variant;
  final DLRadioGroupLayout layout;
  final bool enabled;

  final double rowGap;
  final double columnGap;

  int get _itemCount {
    switch (variant) {
      case DLRadioGroupVariant.v1:
        return 1;
      case DLRadioGroupVariant.v2:
        return 2;
      case DLRadioGroupVariant.v3:
        return 3;
      case DLRadioGroupVariant.v4:
        return 4;
      case DLRadioGroupVariant.v5:
        return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final count = _itemCount.clamp(1, labels.length);
    final items = labels.take(count).toList();
    final sel = selectedIndex.clamp(0, items.length - 1);

    if (layout == DLRadioGroupLayout.column) {
      // ✅ One option per line
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(items.length, (i) {
          final w = DLRadioGroupItem(
            label: items[i],
            selected: i == sel,
            enabled: enabled,
            onTap: enabled ? () => onChanged(i) : null,
            semanticLabel: 'Radio Group: ${items[i]}',
          );

          if (i == items.length - 1) return w;
          return Padding(
            padding: EdgeInsets.only(bottom: rowGap),
            child: w,
          );
        }),
      );
    }

    // Optional two-column layout (kept for future use)
    final cols = 2;
    final children = <Widget>[];

    for (int start = 0; start < items.length; start += cols) {
      final end = (start + cols).clamp(0, items.length);
      final rowItems = items.sublist(start, end);

      children.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(rowItems.length, (j) {
            final i = start + j;
            final item = Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: DLRadioGroupItem(
                  label: rowItems[j],
                  selected: i == sel,
                  enabled: enabled,
                  onTap: enabled ? () => onChanged(i) : null,
                ),
              ),
            );

            if (j == 0) return item;
            return Padding(
              padding: EdgeInsets.only(left: columnGap),
              child: item,
            );
          }),
        ),
      );

      if (end < items.length) children.add(SizedBox(height: rowGap));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class DLRadioGroupItem extends StatelessWidget {
  const DLRadioGroupItem({
    super.key,
    required this.label,
    required this.selected,
    this.enabled = true,
    this.onTap,
    this.semanticLabel,
    this.gap = 8,
    this.height = 24,
    this.textStyle,
  });

  /// Figma label text
  final String label;

  /// Whether this option is selected
  final bool selected;

  /// If false → disabled visuals + ignore taps
  final bool enabled;

  /// Whole-row tap handler
  final VoidCallback? onTap;

  final String? semanticLabel;

  /// Figma: gap 8
  final double gap;

  /// Figma: row height 24 (radio itself is 24)
  final double height;

  /// Optional override
  final TextStyle? textStyle;

  bool get _isDisabled => !enabled || onTap == null;

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        (textStyle ?? (DLTypos.textBaseRegular() ?? const TextStyle()))
            .copyWith(fontWeight: FontWeight.w400);

    final effectiveStyle = baseStyle.copyWith(
      color: _isDisabled ? DLColors.grey400 : DLColors.black,
      decoration: _isDisabled
          ? TextDecoration.lineThrough
          : TextDecoration.none,
      decorationThickness: 1.4,
    );

    return Semantics(
      label: semanticLabel ?? label,
      button: true,
      enabled: !_isDisabled,
      child: InkWell(
        onTap: _isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisSize: MainAxisSize.min, // hug width
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DLRadioButton(
                selected: selected,
                enabled: !_isDisabled,
                semanticLabel: semanticLabel ?? label,
                // Keep behavior consistent: tap radio selects this option
                onChanged: _isDisabled ? null : (_) => onTap?.call(),
              ),
              SizedBox(width: gap),
              Text(label, style: effectiveStyle),
            ],
          ),
        ),
      ),
    );
  }
}
