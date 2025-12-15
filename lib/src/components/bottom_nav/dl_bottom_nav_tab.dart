import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../dynamiclayers.dart';
import '../../../generated/assets.dart';

enum DLBnavBadge { none, sm, md }

/// How to render the provided SVG icon.
enum DLBnavIconStyle {
  /// Keep the original SVG colors. (Default)
  /// Unselected state is shown via [unselectedOpacity].
  original,

  /// Force a solid mono-color tint.
  /// Uses [selectedColor]/[unselectedColor].
  tint,
}

class DLBottomNavTab extends StatelessWidget {
  const DLBottomNavTab({
    super.key,

    // Sizing & style
    this.iconSize = 24,
    this.iconStyle = DLBnavIconStyle.original,
    this.unselectedOpacity = 0.55,

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
  }) : assert(unselectedOpacity >= 0 && unselectedOpacity <= 1);

  final double iconSize;
  final DLBnavIconStyle iconStyle;
  final double unselectedOpacity;

  final String label;
  final bool showLabel;
  final bool selected;

  final DLBnavBadge badge;
  final int badgeCount;

  final Alignment badgeAlignment;
  final Offset badgeOffsetSm;
  final Offset badgeOffsetMd;

  final Color selectedColor;
  final Color unselectedColor;

  final VoidCallback? onTap;

  // Point to your generated SVG asset paths
  String get _selectedAsset => Assets.bottomNavigationSelected;
  String get _unselectedAsset => Assets.bottomNavigationUnselected;

  TextStyle _labelStyle(bool isSelected) {
    return DLTypos.textSmBold(
      color: isSelected ? DLColors.black : DLColors.grey400,
    ).copyWith(letterSpacing: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    // 1) Decide which SVG to show
    final String assetPath = selected ? _selectedAsset : _unselectedAsset;

    // 2) Build icon (tinted or original)
    Widget baseIcon;
    if (iconStyle == DLBnavIconStyle.tint) {
      baseIcon = SvgPicture.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
        colorFilter: ColorFilter.mode(
          selected ? selectedColor : unselectedColor,
          BlendMode.srcIn,
        ),
      );
    } else {
      baseIcon = SvgPicture.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
      );
      if (!selected) {
        baseIcon = Opacity(opacity: unselectedOpacity, child: baseIcon);
      }
    }

    // 3) Badge
    Widget iconWithBadge = baseIcon;
    switch (badge) {
      case DLBnavBadge.none:
        break;
      case DLBnavBadge.sm:
        iconWithBadge = DLBadgeAnchor(
          child: baseIcon,
          badge: const DLBadge(size: DLBadgeSize.sm),
          alignment: badgeAlignment,
          offset: badgeOffsetSm,
          showIfZero: true,
        );
        break;
      case DLBnavBadge.md:
        iconWithBadge = DLBadgeAnchor(
          child: baseIcon,
          badge: DLBadge(size: DLBadgeSize.md, count: badgeCount),
          alignment: badgeAlignment,
          offset: badgeOffsetMd,
          showIfZero: false,
        );
        break;
    }

    // 4) Content
    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: DLSpacing.p8),
        iconWithBadge,
        if (showLabel) ...<Widget>[
          const SizedBox(height: DLSpacing.p8),
          Builder(
            builder: (context) {
              final style = _labelStyle(selected);
              return Text(
                label,
                style: style,
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,

                // FIX: stabilize font metrics to avoid fractional pixel overflow
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
                strutStyle: StrutStyle(
                  fontSize: style.fontSize,
                  height: style.height,
                  forceStrutHeight: true,
                ),
              );
            },
          ),
        ],
        const SizedBox(height: DLSpacing.p8),
      ],
    );

    // 5) Return
    return Semantics(
      selected: selected,
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DLSpacing.p16,
            vertical: 0,
          ),
          child: content,
        ),
      ),
    );
  }
}
