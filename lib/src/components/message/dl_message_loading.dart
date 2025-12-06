// lib/src/components/message/dl_message_loading.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// Animated 3-dot typing / loading indicator.
///
/// - Dot size: 8x8
/// - Gap: 8
/// - Colors cycle through grey300 → grey400 → grey500
class DLMessageLoadingDots extends StatefulWidget {
  const DLMessageLoadingDots({super.key, this.dotSize = 8, this.gap = 8});

  final double dotSize;
  final double gap;

  @override
  State<DLMessageLoadingDots> createState() => _DLMessageLoadingDotsState();
}

class _DLMessageLoadingDotsState extends State<DLMessageLoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  static const _steps = 3; // states 1 → 2 → 3

  final List<Color> _colors = const [
    DLColors.grey300,
    DLColors.grey400,
    DLColors.grey500,
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900), // 3 * 300ms
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Forward motion (left → right):
  /// phase 0: [c0, c1, c2]
  /// phase 1: [c2, c0, c1]
  /// phase 2: [c1, c2, c0]
  ///
  /// That makes the brightest color appear to move from the first dot
  /// toward the last dot.
  Color _colorForDot(int index, double t) {
    final int phase = (t * _steps).floor() % _steps;
    // NOTE: direction flipped to "forward" by subtracting phase.
    final int colorIndex = (index - phase + _colors.length) % _colors.length;
    return _colors[colorIndex];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3 * 2 - 1, (i) {
            if (i.isOdd) {
              return SizedBox(width: widget.gap);
            }
            final dotIndex = i ~/ 2;
            return Container(
              width: widget.dotSize,
              height: widget.dotSize,
              decoration: BoxDecoration(
                color: _colorForDot(dotIndex, t),
                borderRadius: DLRadii.brFull,
              ),
            );
          }),
        );
      },
    );
  }
}

/// Message loading bubble – same dots inside a light bubble.
class DLMessageLoadingBubble extends StatelessWidget {
  const DLMessageLoadingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DLSpacing.p8,
        vertical: DLSpacing.p12,
      ),
      decoration: BoxDecoration(
        color: DLColors.grey100,
        borderRadius: BorderRadius.circular(DLRadii.lg),
      ),
      child: const DLMessageLoadingDots(),
    );
  }
}
