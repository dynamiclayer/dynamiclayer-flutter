import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// 🧭 DynamicLayers — Bottom Navigation Bar (auto-height, no overflow)
/// ---------------------------------------------------------------------------
/// • Renders 2–5 items with equal spacing
/// • Optional top separator (DLSeparator)
/// • Optional iOS-like home indicator (now gets its own vertical space)
/// • Auto height: no fixed SizedBox height, content defines its own height
/// • SafeArea-aware, with extra bottom padding for the home indicator
/// ---------------------------------------------------------------------------
class DLBottomNavBar extends StatelessWidget {
  const DLBottomNavBar({
    super.key,
    required this.items, // 2..5 tabs
    this.backgroundColor = DLColors.white,

    // Spacing
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),

    // Separator
    this.showSeparator = true,
    this.separatorColor = const Color(0x1F000000),
    this.separatorThickness = 1.0,

    // Home indicator pill (now placed in its own row below the items)
    this.showHomeIndicator = true,
    this.homeIndicatorColor = DLColors.black,
    this.homeIndicatorWidth = 120,
    this.homeIndicatorHeight = 4,
    this.homeIndicatorRadius = 999,
    this.homeIndicatorTopGap = 6,
    this.homeIndicatorBottomGap = 6,

    // Shadow/elevation
    this.elevation = 8.0,

    // SafeArea
    this.useSafeArea = true,
  }) : assert(
         items.length >= 2 && items.length <= 5,
         'DLBottomNavBar supports between 2 and 5 items.',
       );

  /// 2..5 widgets; typically `DLBottomNavTab(...)`
  final List<Widget> items;

  final Color backgroundColor;
  final EdgeInsetsGeometry contentPadding;

  // Separator
  final bool showSeparator;
  final Color separatorColor;
  final double separatorThickness;

  // Home indicator
  final bool showHomeIndicator;
  final Color homeIndicatorColor;
  final double homeIndicatorWidth;
  final double homeIndicatorHeight;
  final double homeIndicatorRadius;
  final double homeIndicatorTopGap;
  final double homeIndicatorBottomGap;

  // Elevation
  final double elevation;

  // Safe area
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    Widget bar = Material(
      color: backgroundColor,
      elevation: elevation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showSeparator)
            DLSeparator(
              direction: DLSeparatorDirection.horizontal,
              thickness: separatorThickness,
              color: separatorColor,
              opacity: 1.0,
            ),

          // Items row (icon + optional label) – auto height via padding
          Padding(
            padding: contentPadding,
            child: Row(
              children: items
                  .map((w) => Expanded(child: Center(child: w)))
                  .toList(),
            ),
          ),

          // Dedicated space for the home indicator (no overlay ⇒ no overflow)
          if (showHomeIndicator) ...[
            SizedBox(height: homeIndicatorTopGap),
            Container(
              width: homeIndicatorWidth,
              height: homeIndicatorHeight,
              decoration: BoxDecoration(
                color: homeIndicatorColor,
                borderRadius: BorderRadius.circular(homeIndicatorRadius),
              ),
            ),
            SizedBox(height: homeIndicatorBottomGap),
          ],
        ],
      ),
    );

    // Honor device bottom insets (e.g., iOS home bar area)
    if (useSafeArea) {
      bar = SafeArea(top: false, child: bar);
    }

    return bar;
  }
}
