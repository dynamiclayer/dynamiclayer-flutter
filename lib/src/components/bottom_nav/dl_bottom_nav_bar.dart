import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// 🧭 DynamicLayers — Bottom Navigation Bar (auto-height, no overflow)
/// ---------------------------------------------------------------------------
/// • Renders 2–5 items with equal spacing
/// • Top line uses DLSeparator (not Divider)
/// • No pressed/ripple/hover effects on item taps
/// • Optional iOS-like home indicator (with its own vertical space)
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

  // Elevation
  final double elevation;

  // Safe area
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    // Local Theme override to disable all ink/splash/pressed effects
    final noInkTheme = Theme.of(context).copyWith(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );

    Widget bar = Material(
      color: backgroundColor,
      elevation: elevation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // MUST be the Separator Component (full width)
          if (showSeparator)
            DLSeparator(direction: DLSeparatorDirection.horizontal),

          // Items row (icon + optional label) – auto height via padding
          Padding(
            padding: contentPadding,
            child: Theme(
              data: noInkTheme,
              child: Row(
                children: items
                    .map((w) => Expanded(child: Center(child: w)))
                    .toList(),
              ),
            ),
          ),
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
