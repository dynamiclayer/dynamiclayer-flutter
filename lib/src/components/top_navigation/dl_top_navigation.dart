import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';

enum DLTopNavigationSize { md, lg }

class DLTopNavigation extends StatelessWidget {
  const DLTopNavigation({
    super.key,
    required this.title,
    this.size = DLTopNavigationSize.md,

    // Figma toggles
    this.iconLeft = true,
    this.iconRight = true,
    this.separator = true,

    // Optional custom icons (otherwise placeholder)
    this.left,
    this.right,

    // Optional taps
    this.onLeftTap,
    this.onRightTap,

    this.backgroundColor = DLColors.white,
  });

  final String title;
  final DLTopNavigationSize size;

  final bool iconLeft;
  final bool iconRight;
  final bool separator;

  final Widget? left;
  final Widget? right;

  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  final Color backgroundColor;

  // Shared
  static const _separatorH = 1.0;
  static const _separatorColor = DLColors.grey200;

  // Icon sizing (your placeholder is ~22x22)
  static const _iconSize = 22.0;

  // MD: keep title perfectly centered by giving equal left/right slots
  static const _mdHeight = 56.0;
  static const _mdSlotW = 56.0; // balance
  static const _mdTitleStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 14, // font/size/3
    height: 1.2, // font/line-height/3 (approx, keep consistent)
    letterSpacing: 0.2, // font/letter-spacing/7 (approx)
    color: DLColors.black,
  );

  // LG: left aligned title, bold, bigger
  static const _lgHeight = 88.0;
  static const _lgSidePad = 16.0;
  static const _lgTitleStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 32, // font/size/8 (typical mapping)
    height: 1.1, // font/line-height/8 (approx)
    letterSpacing: -0.2, // font/letter-spacing/2 (approx)
    color: DLColors.black,
  );

  @override
  Widget build(BuildContext context) {
    switch (size) {
      case DLTopNavigationSize.md:
        return _buildMd();
      case DLTopNavigationSize.lg:
        return _buildLg();
    }
  }

  Widget _placeholderIcon() {
    // Replace with your real placeholder asset if you have it.
    // Using a simple box-corners icon-like placeholder.
    return const Icon(Icons.fullscreen, size: _iconSize, color: DLColors.black);
  }

  Widget _iconButton({
    required bool enabled,
    required VoidCallback? onTap,
    required Widget child,
  }) {
    if (!enabled) {
      return const SizedBox.shrink();
    }

    return InkResponse(
      onTap: onTap,
      radius: 24,
      child: SizedBox(width: 48, height: 48, child: Center(child: child)),
    );
  }

  // ----------------------------
  // MD: centered title
  // ----------------------------
  Widget _buildMd() {
    final leftWidget = left ?? _placeholderIcon();
    final rightWidget = right ?? _placeholderIcon();

    return Container(
      height: _mdHeight,
      color: backgroundColor,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: _mdSlotW,
                  child: Align(
                    alignment: Alignment.center,
                    child: _iconButton(
                      enabled: iconLeft,
                      onTap: onLeftTap,
                      child: leftWidget,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: _mdTitleStyle,
                    ),
                  ),
                ),
                SizedBox(
                  width: _mdSlotW,
                  child: Align(
                    alignment: Alignment.center,
                    child: _iconButton(
                      enabled: iconRight,
                      onTap: onRightTap,
                      child: rightWidget,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (separator)
            const SizedBox(
              height: _separatorH,
              child: ColoredBox(color: _separatorColor),
            ),
        ],
      ),
    );
  }

  // ----------------------------
  // LG: left-aligned title, icons on the right
  // ----------------------------
  Widget _buildLg() {
    final leftWidget = left ?? _placeholderIcon();
    final rightWidget = right ?? _placeholderIcon();

    // In your lg screenshot, both icons appear on the right.
    // We will keep iconLeft=true but render it on the right group (first icon),
    // and iconRight=true as the second icon. This matches the visual.
    return Container(
      height: _lgHeight,
      color: backgroundColor,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: _lgSidePad),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: _lgTitleStyle,
                      ),
                    ),
                  ),
                  // Right icon group (two icons)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _iconButton(
                        enabled: iconLeft,
                        onTap: onLeftTap,
                        child: leftWidget,
                      ),
                      _iconButton(
                        enabled: iconRight,
                        onTap: onRightTap,
                        child: rightWidget,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (separator)
            const SizedBox(
              height: _separatorH,
              child: ColoredBox(color: _separatorColor),
            ),
        ],
      ),
    );
  }
}
