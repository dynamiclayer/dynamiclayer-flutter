// lib/src/components/buttons/dl_button_dock.dart
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

/// Button Dock with precise gaps per spec.
/// - Outer padding: 16
/// - Vertical gap: 16
/// - Horizontal gap: 16
/// - Horizontal strategy (default): first button Expanded, last button HUG (intrinsic)
class DLButtonDock extends StatelessWidget {
  const DLButtonDock({
    super.key,
    required this.buttons,

    // Layout
    this.direction = Axis.vertical,
    this.verticalGap = DLSpacing.p16, // p16
    this.horizontalGap = DLSpacing.p16, // p16
    this.padding = const EdgeInsets.symmetric(
      horizontal: DLSpacing.p16,
      vertical: DLSpacing.p16,
    ),
    this.maxContentWidth = 800,

    // Horizontal behavior
    this.horizontalLastHug = true, // match mock: left fills, right hug
    this.horizontalSplitEvenly = false, // set true to force 50/50 split
    // Chrome
    this.backgroundColor = Colors.white,
    this.elevation = 8.0,

    // Separator
    this.showSeparator = false,
    this.separatorInset = EdgeInsets.zero,
    this.separatorFullBleed = true,

    // SafeArea
    this.useSafeArea = true,
  });

  final List<DLButton> buttons;
  final Axis direction;

  // GAP controls (per spec)
  final double verticalGap; // p16 between stacked buttons
  final double horizontalGap; // p16 between horizontal buttons

  final EdgeInsetsGeometry padding;
  final double maxContentWidth;

  // Horizontal strategies
  final bool horizontalLastHug; // first Expanded, last Hug
  final bool horizontalSplitEvenly; // both Expanded (50/50)

  final Color backgroundColor;
  final double elevation;

  // Separator
  final bool showSeparator;
  final EdgeInsetsGeometry separatorInset;
  final bool separatorFullBleed;

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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showSeparator)
              Padding(
                padding: separatorInset,
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

            // Buttons area
            Padding(
              padding: padding, // p16 outer padding
              child: Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: direction == Axis.horizontal
                      ? _row(buttons)
                      : _column(buttons),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Horizontal layout with exact gaps
  Widget _row(List<DLButton> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    // 50/50 split override
    if (horizontalSplitEvenly) {
      final children = <Widget>[];
      for (var i = 0; i < items.length; i++) {
        children.add(Expanded(child: _dockButton(items[i])));
        if (i != items.length - 1)
          children.add(SizedBox(width: horizontalGap)); // p16
      }
      return Row(children: children);
    }

    // Default: first Expanded, last Hug — matches mock with 2 buttons.
    if (horizontalLastHug && items.length == 2) {
      return Row(
        children: [
          Expanded(child: _dockButton(items[0])),
          SizedBox(width: horizontalGap), // p16
          _dockButton(items[1]),
        ],
      );
    }

    // Fallback: natural widths with fixed gap
    final children = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      children.add(_dockButton(items[i]));
      if (i != items.length - 1)
        children.add(SizedBox(width: horizontalGap)); // p16
    }
    return Row(children: children);
  }

  // Vertical layout: stretch each to full width, gap p16
  Widget _column(List<DLButton> items) {
    final children = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      children.add(
        SizedBox(width: double.infinity, child: _dockButton(items[i])),
      );
      if (i != items.length - 1)
        children.add(SizedBox(height: verticalGap)); // p16
    }
    return Column(mainAxisSize: MainAxisSize.min, children: children);
  }

  Widget _dockButton(DLButton b) {
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
      fixedWidth: b.fixedWidth,
    );
  }
}
