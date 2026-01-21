import 'dart:async';
import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';

enum DLProgressState {
  /// Empty track.
  one,

  /// Fill to 100% after delay (linear).
  two,
}

/// Two-state progress bar matching your Figma:
/// - State "one": empty (0%)
/// - State "two": after [animationDelay], fill to 100% over [animationDuration]
class DLProgress extends StatefulWidget {
  const DLProgress({
    super.key,
    this.state = DLProgressState.one,
    this.width = 343,
    this.height = 8,
    this.radius = 9999,
    this.trackColor,
    this.fillColor,
    this.animationDelay = const Duration(milliseconds: 300),
    this.animationDuration = const Duration(milliseconds: 2400),
  });

  final DLProgressState state;

  /// If null, expands to available width. If provided, used for width calc.
  final double? width;

  final double height;
  final double radius;

  final Color? trackColor;
  final Color? fillColor;

  final Duration animationDelay;
  final Duration animationDuration;

  @override
  State<DLProgress> createState() => _DLProgressState();
}

class _DLProgressState extends State<DLProgress> {
  Timer? _delayTimer;
  double _value = 0.0; // 0..1

  @override
  void initState() {
    super.initState();
    _applyState();
  }

  @override
  void didUpdateWidget(covariant DLProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state ||
        oldWidget.animationDelay != widget.animationDelay ||
        oldWidget.animationDuration != widget.animationDuration) {
      _applyState();
    }
  }

  void _applyState() {
    _delayTimer?.cancel();

    if (widget.state == DLProgressState.one) {
      if (!mounted) return;
      setState(() => _value = 0.0);
      return;
    }

    // state == two: reset to 0, then after delay animate to 1
    if (!mounted) return;
    setState(() => _value = 0.0);

    _delayTimer = Timer(widget.animationDelay, () {
      if (!mounted) return;
      setState(() => _value = 1.0);
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final track = widget.trackColor ?? DLColors.grey200;
    final fill = widget.fillColor ?? DLColors.violet600;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth; // works for fixed width or expanded

            return ColoredBox(
              color: track,
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  curve: Curves.linear,
                  width: w * _value,
                  height: widget.height,
                  color: fill,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
