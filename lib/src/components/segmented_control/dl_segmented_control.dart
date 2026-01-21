import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';

/// ----------------------------------------------------------------------------
/// Segmented Control (pill container + sliding selected indicator)
/// ----------------------------------------------------------------------------

enum DLSegmentedControlState { defaultState, disabled }

class DLSegmentItem {
  const DLSegmentItem({required this.label, this.enabled = true});

  final String label;
  final bool enabled;
}

/// DynamicLayers Segmented Control
///
/// Spec (your Count=2/3/4 control):
/// - Outer: 343x36, radius full, padding 4, bg #EEEEEE
/// - Selected indicator: height 28, radius full
/// - Segments: equal width (Fill)
/// - Animated slide between segments
class DLSegmentedControl extends StatelessWidget {
  const DLSegmentedControl({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
    this.state = DLSegmentedControlState.defaultState,
    this.width = 343,
    this.height = 36,
    this.outerPadding = const EdgeInsets.all(4),
    this.innerHeight = 28,
    this.radius = 9999,
    this.backgroundColor,
    this.selectedColor,
    this.textColor,
    this.disabledOpacity = 0.45,
    this.animationDuration = const Duration(milliseconds: 220),
    this.animationCurve = Curves.easeOut,
  }) : assert(
         items.length >= 2 && items.length <= 4,
         'Segmented control supports 2..4 items.',
       );

  final List<DLSegmentItem> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  final DLSegmentedControlState state;

  final double? width;
  final double height;
  final EdgeInsets outerPadding;
  final double innerHeight;
  final double radius;

  final Color? backgroundColor; // default #EEEEEE
  final Color? selectedColor; // default white
  final Color? textColor; // default black

  final double disabledOpacity;

  final Duration animationDuration;
  final Curve animationCurve;

  bool get _isDisabled => state == DLSegmentedControlState.disabled;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? const Color(0xFFEEEEEE);
    final sel = selectedColor ?? Colors.white;
    final txt = textColor ?? Colors.black;

    // Typography you provided: Inter / Regular 400 / size-3 / line-height-3 / letter-spacing-7.
    // Map to a DLTypos style if available; otherwise this fallback is safe.
    final labelStyle = (DLTypos.textBaseRegular() ?? const TextStyle())
        .copyWith(fontWeight: FontWeight.w400, color: txt);

    final effectiveOpacity = _isDisabled ? disabledOpacity : 1.0;

    return Opacity(
      opacity: effectiveOpacity,
      child: IgnorePointer(
        ignoring: _isDisabled,
        child: SizedBox(
          width: width,
          height: height,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final totalW = constraints.maxWidth;
              final count = items.length;

              final innerW = totalW - outerPadding.horizontal;
              final segW = innerW / count;

              final clampedIndex = selectedIndex.clamp(0, count - 1);
              final left = outerPadding.left + (segW * clampedIndex);

              return ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: ColoredBox(
                  color: bg,
                  child: Stack(
                    children: [
                      // Selected sliding indicator
                      AnimatedPositioned(
                        duration: animationDuration,
                        curve: animationCurve,
                        left: left,
                        top: outerPadding.top,
                        width: segW,
                        height: innerHeight,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: sel,
                            borderRadius: BorderRadius.circular(radius),
                          ),
                        ),
                      ),

                      // Touch targets + labels
                      Row(
                        children: List.generate(count, (i) {
                          final item = items[i];
                          final enabled = item.enabled && !_isDisabled;

                          final effectiveTextColor = enabled
                              ? txt
                              : txt.withOpacity(0.35);

                          return Expanded(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(radius),
                              onTap: enabled ? () => onChanged(i) : null,
                              child: SizedBox(
                                height: height,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 16,
                                    ),
                                    child: Text(
                                      item.label,
                                      textAlign: TextAlign.center,
                                      style: labelStyle.copyWith(
                                        color: effectiveTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// ----------------------------------------------------------------------------
/// Segmented Control Tab (single pill item; selected/default/disabled)
/// ----------------------------------------------------------------------------

enum DLSegmentedControlTabState { defaultState, selected, disabled }

class DLSegmentedControlTab extends StatelessWidget {
  const DLSegmentedControlTab({
    super.key,
    required this.label,
    this.state = DLSegmentedControlTabState.defaultState,
    this.onTap,
    this.height = 28,
    this.radius = 9999,
    this.padding = const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
    this.gap = 8,
    this.backgroundColor, // selected only (default: white)
    this.textColor, // default: black
    this.disabledTextColor, // default: black with opacity
    this.disabledOpacity = 0.55,
  });

  final String label;
  final DLSegmentedControlTabState state;
  final VoidCallback? onTap;

  final double height;
  final double radius;
  final EdgeInsets padding;
  final double gap;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? disabledTextColor;
  final double disabledOpacity;

  bool get _isSelected => state == DLSegmentedControlTabState.selected;
  bool get _isDisabled => state == DLSegmentedControlTabState.disabled;

  @override
  Widget build(BuildContext context) {
    final txt = textColor ?? Colors.black;

    final labelStyle = (DLTypos.textBaseRegular() ?? const TextStyle())
        .copyWith(fontWeight: FontWeight.w400, color: txt);

    final effectiveTextColor = _isDisabled
        ? (disabledTextColor ?? txt.withOpacity(0.45))
        : txt;

    // Selected pill background is white per your screenshot/spec.
    // Default tab has no background (transparent).
    final bg = _isSelected
        ? (backgroundColor ?? Colors.white)
        : Colors.transparent;

    final child = Container(
      height: height,
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: labelStyle.copyWith(
          color: effectiveTextColor,
          decoration: _isDisabled
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          decorationThickness: 1.5, // optional; remove if you don’t want it
        ),
      ),
    );

    if (_isDisabled) {
      return Opacity(opacity: disabledOpacity, child: child);
    }

    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: child,
    );
  }
}
