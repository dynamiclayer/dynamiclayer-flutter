import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

enum DLBnavBadge { none, sm, md }

/// How to render the provided image icon.
enum DLBnavIconStyle {
  /// Keep the original image colors. (Default)
  /// Unselected state is shown via [unselectedOpacity].
  original,

  /// Force a solid mono-color tint (like ImageIcon does).
  /// Uses [selectedColor]/[unselectedColor].
  tint,
}

class DLBottomNavTab extends StatelessWidget {
  const DLBottomNavTab({
    super.key,

    // Icon images
    required this.iconImage,
    this.selectedIconImage,
    this.unselectedIconImage,
    this.iconSize = 24,
    this.iconStyle = DLBnavIconStyle.original,
    this.unselectedOpacity = 0.55, // gently dim when not selected
    // Label & state
    this.label = 'Label',
    this.showLabel = true,
    this.selected = false,

    // Badges
    this.badge = DLBnavBadge.none,
    this.badgeCount = 1,
    this.badgeAlignment = Alignment.topRight,
    this.badgeOffsetSm = const Offset(2, -2),
    this.badgeOffsetMd = const Offset(4, -4),

    // Colors (only used when iconStyle == tint)
    this.selectedColor = DLColors.black,
    this.unselectedColor = DLColors.grey400,

    // Interaction
    this.onTap,
  });

  /// Base icon used for both states unless overrides below are provided.
  final ImageProvider iconImage;

  /// Optional override for selected state.
  final ImageProvider? selectedIconImage;

  /// Optional override for unselected state.
  final ImageProvider? unselectedIconImage;

  final double iconSize;

  /// original = keep asset colors (default), tint = force mono-color.
  final DLBnavIconStyle iconStyle;

  /// Only applies when [iconStyle] == original (no tint).
  /// Controls how dim the unselected icon appears.
  final double unselectedOpacity;

  final String label;
  final bool showLabel;
  final bool selected;

  final DLBnavBadge badge;
  final int badgeCount;

  final Alignment badgeAlignment;
  final Offset badgeOffsetSm;
  final Offset badgeOffsetMd;

  /// Only used when [iconStyle] == tint
  final Color selectedColor;
  final Color unselectedColor;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color labelColor = selected ? selectedColor : unselectedColor;
    final textStyle = selected
        ? DLTypos.textSmBold(color: labelColor)
        : DLTypos.textSmRegular(color: labelColor);

    // Decide which image to show (allow explicit overrides).
    final ImageProvider baseImage = selected
        ? (selectedIconImage ?? iconImage)
        : (unselectedIconImage ?? iconImage);

    // Build the icon with either preserved colors or tinted.
    Widget baseIcon;
    if (iconStyle == DLBnavIconStyle.tint) {
      // Monochrome tint (behaves like ImageIcon).
      baseIcon = ImageIcon(
        baseImage,
        size: iconSize,
        color: selected ? selectedColor : unselectedColor,
      );
    } else {
      // Preserve asset colors. Dim the unselected state with opacity.
      baseIcon = Image(
        image: baseImage,
        width: iconSize,
        height: iconSize,
        filterQuality: FilterQuality.medium,
      );

      if (!selected) {
        baseIcon = Opacity(opacity: unselectedOpacity, child: baseIcon);
      }
    }

    // Apply badge overlay if requested.
    final Widget iconWithBadge = switch (badge) {
      DLBnavBadge.none => baseIcon,
      DLBnavBadge.sm => DLBadgeAnchor(
        child: baseIcon,
        badge: const DLBadge(size: DLBadgeSize.sm),
        alignment: badgeAlignment,
        offset: badgeOffsetSm,
        showIfZero: true,
      ),
      DLBnavBadge.md => DLBadgeAnchor(
        child: baseIcon,
        badge: DLBadge(size: DLBadgeSize.md, count: badgeCount),
        alignment: badgeAlignment,
        offset: badgeOffsetMd,
        showIfZero: false,
      ),
    };

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconWithBadge,
        if (showLabel) ...[
          const SizedBox(height: 6),
          Text(label, style: textStyle),
        ],
      ],
    );

    return Semantics(
      selected: selected,
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: content,
        ),
      ),
    );
  }
}
