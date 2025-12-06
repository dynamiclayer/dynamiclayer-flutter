// lib/src/components/loaders/dl_loading_dots.dart
import 'package:flutter/material.dart';

/// Animated 3-dot loader used in DynamicLayers buttons.
///
/// Layout:
/// - Max size: 48 x 16
/// - Each dot: 10 x 10
/// - If the parent gives less than 48px width, we keep dot size
///   and reduce the gaps so nothing overflows.
///
/// States:
///   State 1: a up,   b down, c up
///   State 2: a down, b up,   c down
///
/// Animation:
/// - Repeats between the two states
/// - Duration: 300ms
/// - Curve: easeOut
///
/// Dark / Light:
/// - If [color] is null, it uses:
///   - white in dark mode
///   - black in light mode
class DLLoadingDots extends StatefulWidget {
  const DLLoadingDots({
    super.key,
    this.color,
    this.duration = const Duration(milliseconds: 300),
  });

  /// Optional override for dot color.
  /// If null, it’s derived from the current theme brightness.
  final Color? color;

  /// Duration of one transition between state 1 and state 2.
  final Duration duration;

  @override
  State<DLLoadingDots> createState() => _DLLoadingDotsState();
}

class _DLLoadingDotsState extends State<DLLoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double>
  _offset; // shared offset for A & C (B is opposite)

  static const double _dotSize = 10.0;
  static const double _maxWidth = 48.0;
  static const double _height = 16.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    // Negative = up, positive = down.
    // We go from up (state 1 for A/C) to down (state 2 for A/C),
    // and because we repeat(reverse: true), it cycles:
    //   a up, b down, c up  ->  a down, b up, c down  -> back...
    const double lift = 4.0;

    _offset = Tween<double>(
      begin: -lift, // A/C up, B down
      end: lift, // A/C down, B up
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _effectiveColor(BuildContext context) {
    if (widget.color != null) return widget.color!;
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  Widget _buildDot(Color color, double dy) {
    return Transform.translate(
      offset: Offset(0, dy),
      child: Container(
        width: _dotSize,
        height: _dotSize,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = _effectiveColor(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // How much width do we really have?
        final double available = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : _maxWidth;

        // Clamp between 3*dots (no gap) and the spec max (48).
        final double width = available.clamp(3 * _dotSize, _maxWidth);

        // 3 dots → 2 gaps
        double gap = (width - (3 * _dotSize)) / 2;
        // Keep a reasonable visual range
        gap = gap.clamp(0.0, 9.0);

        return SizedBox(
          width: width,
          height: _height,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final dyAC = _offset.value; // dots A & C
              final dyB = -_offset.value; // dot B opposite

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDot(color, dyAC), // A
                  SizedBox(width: gap),
                  _buildDot(color, dyB), // B
                  SizedBox(width: gap),
                  _buildDot(color, dyAC), // C
                ],
              );
            },
          ),
        );
      },
    );
  }
}
