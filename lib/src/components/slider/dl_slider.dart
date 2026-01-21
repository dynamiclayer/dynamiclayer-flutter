import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

enum DLSliderState {
  defaultState, // thumb at start, 0%
  filled, // thumb at end, 100%
}

/// DynamicLayers Slider (two-state)
///
/// Visual spec:
/// - width: 343 (default)
/// - trackHeight: 4
/// - thumb: circle (outlined), positioned at 0% or 100% depending on [state]
///
/// If [onChanged] is provided, slider becomes interactive (drag to set value 0..1).
/// Otherwise it is purely visual (two-state).
class DLSlider extends StatefulWidget {
  const DLSlider({
    super.key,
    this.state = DLSliderState.defaultState,
    this.width = 343,
    this.trackHeight = 4,
    this.value,
    this.onChanged,
    this.trackColor,
    this.fillColor,
    this.thumbBorderColor,
    this.thumbFillColor,
    this.thumbSize = 24,
    this.radius = 9999,
  });

  final DLSliderState state;

  /// Fixed width like the Figma component (343 by default).
  final double width;

  /// Track thickness (4 by default).
  final double trackHeight;

  /// Optional controlled value 0..1. If null, value is derived from [state].
  final double? value;

  /// If non-null, enables dragging and emits 0..1.
  final ValueChanged<double>? onChanged;

  /// Colors (default to DL tokens)
  final Color? trackColor;
  final Color? fillColor;
  final Color? thumbBorderColor;
  final Color? thumbFillColor;

  /// Thumb diameter
  final double thumbSize;

  /// Track corner radius
  final double radius;

  bool get _interactive => onChanged != null;

  @override
  State<DLSlider> createState() => _DLSliderState();
}

class _DLSliderState extends State<DLSlider> {
  late double _internalValue;

  double get _derivedValue {
    if (widget.value != null) return widget.value!.clamp(0.0, 1.0);
    return widget.state == DLSliderState.filled ? 1.0 : 0.0;
  }

  @override
  void initState() {
    super.initState();
    _internalValue = _derivedValue;
  }

  @override
  void didUpdateWidget(covariant DLSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If controlled externally, follow widget.value/state changes.
    final next = _derivedValue;
    if ((next - _internalValue).abs() > 0.0001) {
      _internalValue = next;
    }
  }

  void _setFromLocalDx(double dx) {
    final w = widget.width;
    final thumbR = widget.thumbSize / 2;

    // Clamp motion so thumb never goes out of bounds.
    final clampedDx = dx.clamp(thumbR, w - thumbR);
    final t = ((clampedDx - thumbR) / (w - 2 * thumbR)).clamp(0.0, 1.0);

    setState(() => _internalValue = t);
    widget.onChanged?.call(t);
  }

  @override
  Widget build(BuildContext context) {
    final track = widget.trackColor ?? DLColors.grey200;
    final fill = widget.fillColor ?? DLColors.black;

    final thumbBorder = widget.thumbBorderColor ?? DLColors.grey200;
    final thumbFill = widget.thumbFillColor ?? DLColors.white;

    final w = widget.width;
    final h = widget.trackHeight;
    final thumb = widget.thumbSize;
    final thumbR = thumb / 2;

    // Thumb center position along the track width.
    final thumbCx = thumbR + _internalValue * (w - 2 * thumbR);

    return SizedBox(
      width: w,
      height: thumb, // overall height accommodates thumb
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: widget._interactive
            ? (d) => _setFromLocalDx(d.localPosition.dx)
            : null,
        onPanUpdate: widget._interactive
            ? (d) => _setFromLocalDx(d.localPosition.dx)
            : null,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Base track
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: h,
                width: w,
                decoration: BoxDecoration(
                  color: track,
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
              ),
            ),

            // Filled portion (0..thumbCx)
            Align(
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.radius),
                child: SizedBox(
                  height: h,
                  width: thumbCx, // fill up to thumb
                  child: ColoredBox(color: fill),
                ),
              ),
            ),

            // Thumb
            Positioned(
              left: thumbCx - thumbR,
              child: Container(
                width: thumb,
                height: thumb,
                decoration: BoxDecoration(
                  color: thumbFill,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: thumbBorder,
                    width: DLBorderWidth.w1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
