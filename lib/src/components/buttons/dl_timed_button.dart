// lib/src/components/buttons/dl_timed_button.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';

enum DLTimedButtonSize { lg, md, sm, xs }

class DLTimedButton extends StatefulWidget {
  const DLTimedButton({
    super.key,
    required this.duration,
    required this.onCompleted,
    this.onPressed,
    this.size = DLTimedButtonSize.lg,
    this.label,
    this.autostart = true,
    this.expanded = false,
    this.disabled = false,
  });

  /// Total time the button counts down.
  final Duration duration;

  /// Called exactly once when time reaches zero.
  final VoidCallback onCompleted;

  /// Optional tap handler while button is active.
  final VoidCallback? onPressed;

  /// Size token.
  final DLTimedButtonSize size;

  /// Label prefix. Example:
  ///  label: 'Label' -> "Label (1:00)"
  ///  label: null    -> "1:00"
  final String? label;

  /// If true, countdown starts immediately.
  final bool autostart;

  /// If true, button can take maximum width from parent
  /// (but not smaller than token width).
  final bool expanded;

  /// Static disabled visual (0:00). No animation / taps.
  final bool disabled;

  @override
  State<DLTimedButton> createState() => _DLTimedButtonState();
}

class _DLTimedButtonState extends State<DLTimedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _completed = false;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (mounted) setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_completed) {
          setState(() => _completed = true);
          widget.onCompleted();
        }
      });

    if (widget.autostart && !widget.disabled) {
      _start();
    }
  }

  @override
  void didUpdateWidget(covariant DLTimedButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      if (widget.autostart && !_started && !widget.disabled) {
        _start();
      }
    }

    // disabled -> enabled: reset timer
    if (oldWidget.disabled && !widget.disabled) {
      _completed = false;
      _started = false;
      _controller.reset();
      if (widget.autostart) {
        _start();
      }
    }
  }

  void _start() {
    if (_started || _completed || widget.disabled) return;
    _started = true;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------- TOKENS ----------

  double get _fixedWidth {
    switch (widget.size) {
      case DLTimedButtonSize.lg:
        return 144;
      case DLTimedButtonSize.md:
      case DLTimedButtonSize.sm:
        return 128;
      case DLTimedButtonSize.xs:
        return 108;
    }
  }

  double get _height {
    switch (widget.size) {
      case DLTimedButtonSize.lg:
        return 56;
      case DLTimedButtonSize.md:
        return 48;
      case DLTimedButtonSize.sm:
        return 40;
      case DLTimedButtonSize.xs:
        return 32;
    }
  }

  EdgeInsets get _padding {
    switch (widget.size) {
      case DLTimedButtonSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p24,
          vertical: DLSpacing.p16,
        );
      case DLTimedButtonSize.md:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p16,
          vertical: DLSpacing.p12,
        );
      case DLTimedButtonSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: DLSpacing.p16,
          vertical: DLSpacing.p8,
        );
      case DLTimedButtonSize.xs:
        return const EdgeInsets.fromLTRB(DLSpacing.p12, 6, DLSpacing.p12, 6);
    }
  }

  TextStyle _baseTextStyle() {
    switch (widget.size) {
      case DLTimedButtonSize.xs:
        return DLTypos.textSmSemibold();
      case DLTimedButtonSize.lg:
      case DLTimedButtonSize.md:
      case DLTimedButtonSize.sm:
        return DLTypos.textBaseSemibold();
    }
  }

  // ---------- LABEL / TIME FORMAT ----------

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String _buildLabel(int remainingSec) {
    final timeStr = _formatTime(remainingSec);

    if (widget.label != null && widget.label!.isNotEmpty) {
      return '${widget.label} ($timeStr)';
    }
    return timeStr;
  }

  void _handleTap() {
    final isDisabled = widget.disabled;
    final isCompleted = _completed && !widget.disabled;

    if (isDisabled || isCompleted) return;

    if (!_started) _start();
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.disabled;
    final bool isCompleted = _completed && !widget.disabled;

    // 0→1 (time passed)
    final rawProgress = _controller.value.clamp(0.0, 1.0);
    final remainingFraction = (isDisabled || isCompleted)
        ? 0.0
        : (1.0 - rawProgress);

    final totalSec = math.max(1, widget.duration.inSeconds);
    final remainingSec = (isDisabled || isCompleted)
        ? 0
        : math.max(0, totalSec - (totalSec * rawProgress).round());

    final labelText = _buildLabel(remainingSec);

    // Colors for the 3 states
    final Color baseColor;
    final Color overlayColor;
    final Color textColor;

    if (isDisabled) {
      // Disabled
      // background: grey-100 #EEEEEE, label: grey-600 #545454
      baseColor = DLColors.grey100;
      overlayColor = DLColors.grey100; // not used
      textColor = DLColors.grey600;
    } else if (isCompleted) {
      // Filled (time up)
      // background: grey-500 #757575, label: white
      baseColor = DLColors.grey500;
      overlayColor = DLColors.grey500; // not used
      textColor = DLColors.white;
    } else {
      // Default counting
      // base: black #000000
      // overlay: grey-800 #1F1F1F
      baseColor = DLColors.black;
      overlayColor = DLColors.grey800;
      textColor = DLColors.white;
    }

    final textStyle = _baseTextStyle().copyWith(color: textColor);

    final bool isTimingState = !isDisabled && !isCompleted;

    // Split position for gradient:
    // - At start (progress=0): split=1 → 100% baseColor
    // - At end   (progress=1): split=0 → 100% overlayColor
    final double split = isTimingState ? (1.0 - rawProgress) : 1.0;
    final double clampedSplit = split.clamp(0.0, 1.0);

    final buttonBody = SizedBox(
      height: _height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: DLRadii.brMd,
          color: isTimingState ? null : baseColor,
          gradient: isTimingState
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [baseColor, baseColor, overlayColor, overlayColor],
                  stops: [0.0, clampedSplit, clampedSplit, 1.0],
                )
              : null,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Label
            Padding(
              padding: _padding,
              child: Center(
                child: Text(
                  labelText,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.clip,
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Width behaviour: minimum token width, can grow with text.
    Widget content;
    if (widget.expanded) {
      content = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: _fixedWidth,
          minHeight: _height,
          maxHeight: _height,
        ),
        child: SizedBox(width: double.infinity, child: buttonBody),
      );
    } else {
      content = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: _fixedWidth,
          minHeight: _height,
          maxHeight: _height,
        ),
        child: buttonBody,
      );
    }

    final canTap =
        !isDisabled &&
        !isCompleted &&
        (widget.onPressed != null || !widget.autostart);

    Widget result = Semantics(
      button: true,
      enabled: !isDisabled && !isCompleted,
      label: labelText,
      child: content,
    );

    if (canTap) {
      result = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _handleTap,
        child: result,
      );
    }

    return result;
  }
}
