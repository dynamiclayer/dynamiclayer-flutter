// dl_button_dock.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart'; // DLSeparator & DynamicLayers.buttons

/// Public spec for a single button inside the dock.
class DlButtonDock {
  DlButtonDock({
    required this.label,
    required this.type,
    required this.onPressed,
    this.size = DLButtonSize.lg,
    this.iconLeft,
    this.iconRight,
    this.enabled = true,
    this.state = DLButtonState.normal,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.fixedWidth = false,
  });

  final String label;
  final DLButtonType type;
  final VoidCallback? onPressed;

  // passthroughs to DynamicLayers.buttons
  final DLButtonSize size;
  final DLButtonState state;
  final Widget? iconLeft;
  final Widget? iconRight;
  final bool enabled;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool fixedWidth;
}

/// Button Dock
class DLButtonDock extends StatelessWidget {
  const DLButtonDock({
    super.key,
    required this.buttons,

    // Layout
    this.direction = Axis.vertical,
    this.gap = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.maxContentWidth = 600,

    // Chrome
    this.backgroundColor = Colors.white,
    this.elevation = 8.0,

    // Separator
    this.showSeparator = false, // uses DLSeparator when true
    this.separatorInset = EdgeInsets.zero, // full-bleed by default
    this.separatorFullBleed = true, // span entire dock width
    // iOS home indicator (disabled by default)
    this.showHomeIndicator = false,
    this.homeIndicatorColor = Colors.black,
    this.homeIndicatorWidth = 120,
    this.homeIndicatorHeight = 4,
    this.homeIndicatorRadius = 999,

    // SafeArea
    this.useSafeArea = true,
  });

  final List<DlButtonDock> buttons;
  final Axis direction;
  final double gap;
  final EdgeInsetsGeometry padding;
  final double maxContentWidth;

  final Color backgroundColor;
  final double elevation;

  // Separator
  final bool showSeparator;
  final EdgeInsetsGeometry separatorInset;
  final bool separatorFullBleed;

  // Home indicator (iOS)
  final bool showHomeIndicator;
  final Color homeIndicatorColor;
  final double homeIndicatorWidth;
  final double homeIndicatorHeight;
  final double homeIndicatorRadius;

  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      elevation: elevation,
      shadowColor: Colors.black.withOpacity(0.12),
      child: SafeArea(
        top: false,
        left: useSafeArea,
        right: useSafeArea,
        bottom: useSafeArea,
        child: Column(
          mainAxisSize: MainAxisSize.min, // intrinsic height, no overflow
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showSeparator)
              Padding(
                padding: separatorInset,
                // Full-bleed separator, not constrained by maxContentWidth
                child: separatorFullBleed
                    ? const SizedBox(
                        width: double.infinity,
                        child: DLSeparator(),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: maxContentWidth,
                          ),
                          child: const DLSeparator(),
                        ),
                      ),
              ),

            // Buttons area (constrained to maxContentWidth and with padding)
            Padding(
              padding: padding,
              child: Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: direction == Axis.horizontal
                      ? _row(buttons, gap)
                      : _column(buttons, gap),
                ),
              ),
            ),

            if (showHomeIndicator) ...[
              const SizedBox(height: 4),
              _HomeIndicator(
                color: homeIndicatorColor,
                width: homeIndicatorWidth,
                height: homeIndicatorHeight,
                radius: homeIndicatorRadius,
              ),
              const SizedBox(height: 6),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(List<DlButtonDock> items, double gap) {
    final children = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      children.add(Expanded(child: _dockButton(items[i])));
      if (i != items.length - 1) children.add(SizedBox(width: gap));
    }
    return Row(children: children);
  }

  Widget _column(List<DlButtonDock> items, double gap) {
    final children = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      children.add(_dockButton(items[i]));
      if (i != items.length - 1) children.add(SizedBox(height: gap));
    }
    return Column(mainAxisSize: MainAxisSize.min, children: children);
  }

  Widget _dockButton(DlButtonDock b) {
    return DynamicLayers.buttons(
      type: b.type,
      label: b.label,
      iconLeft: b.iconLeft,
      iconRight: b.iconRight,
      onPressed: b.onPressed,
      enabled: b.enabled,
      size: b.size,
      state: b.state,
      width: b.width,
      height: b.height,
      padding: b.padding,
      backgroundColor: b.backgroundColor,
      foregroundColor: b.foregroundColor,
      borderColor: b.borderColor,
      borderWidth: b.borderWidth,
      fixedWidth: b.fixedWidth,
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator({
    required this.color,
    required this.width,
    required this.height,
    required this.radius,
  });

  final Color color;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
