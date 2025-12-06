// lib/src/components/input/dl_input_otp_cell.dart
import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';

/// Visual state of one OTP cell.
enum DLOtpCellState {
  normal,
  active,
  filled,
  invisible,
  error,
  success,
  disabled,
}

class DLInputOtpCell extends StatelessWidget {
  const DLInputOtpCell({
    super.key,
    required this.value,
    this.state = DLOtpCellState.normal,
    this.obscure = false,
    this.size = 48,
  });

  /// Raw character in this cell (digit or anything).
  final String value;

  /// Visual state.
  final DLOtpCellState state;

  /// If true, shows a dot instead of the real value (when there is one).
  final bool obscure;

  /// Box size (width & height).
  final double size;

  bool get _hasValue => value.isNotEmpty;

  // ---------------------------------------------------------------------------
  // TOKENS
  // ---------------------------------------------------------------------------

  Color _background() {
    switch (state) {
      case DLOtpCellState.error:
        return DLColors.red50;
      case DLOtpCellState.success:
        return DLColors.green50;
      case DLOtpCellState.normal:
      case DLOtpCellState.active:
      case DLOtpCellState.filled:
      case DLOtpCellState.invisible:
      case DLOtpCellState.disabled:
        return DLColors.grey100;
    }
  }

  double _borderWidth() {
    switch (state) {
      case DLOtpCellState.active:
      case DLOtpCellState.error:
      case DLOtpCellState.success:
        return DLBorderWidth.w2;
      case DLOtpCellState.normal:
      case DLOtpCellState.filled:
      case DLOtpCellState.invisible:
      case DLOtpCellState.disabled:
        return DLBorderWidth.w0;
    }
  }

  Color _borderColor() {
    switch (state) {
      case DLOtpCellState.active:
        return DLColors.black;
      case DLOtpCellState.error:
        return DLColors.red500;
      case DLOtpCellState.success:
        return DLColors.green700;
      case DLOtpCellState.normal:
      case DLOtpCellState.filled:
      case DLOtpCellState.invisible:
      case DLOtpCellState.disabled:
        return Colors.transparent;
    }
  }

  Color _digitColor() {
    switch (state) {
      case DLOtpCellState.error:
        return DLColors.red500;
      case DLOtpCellState.success:
        return DLColors.green700;
      case DLOtpCellState.disabled:
        return DLColors.grey500;
      case DLOtpCellState.normal:
      case DLOtpCellState.active:
      case DLOtpCellState.filled:
      case DLOtpCellState.invisible:
        return DLColors.black;
    }
  }

  Color _dotColor() {
    switch (state) {
      case DLOtpCellState.error:
        return DLColors.red500;
      case DLOtpCellState.success:
        return DLColors.green700;
      case DLOtpCellState.disabled:
        return DLColors.grey500;
      case DLOtpCellState.normal:
      case DLOtpCellState.active:
      case DLOtpCellState.filled:
      case DLOtpCellState.invisible:
        return DLColors.black;
    }
  }

  // ---------------------------------------------------------------------------
  // CONTENT
  // ---------------------------------------------------------------------------

  Widget _buildCaret() {
    // Blinking caret instead of static bar
    return _BlinkingCaret(height: size * 0.5, color: _digitColor());
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildDash(Color color) {
    return Text('-', style: DLTypos.textSmRegular(color: color));
  }

  Widget _buildDigit(String char, Color color) {
    return Text(char, style: DLTypos.textLgRegular(color: color));
  }

  Widget _content() {
    // Disabled: always show a grey dash when empty.
    if (state == DLOtpCellState.disabled && !_hasValue) {
      return _buildDash(DLColors.grey500);
    }

    // Active & empty: show blinking caret.
    if (state == DLOtpCellState.active && !_hasValue) {
      return _buildCaret();
    }

    // If we have a value, decide digit vs dot
    if (_hasValue) {
      final useDot =
          obscure ||
          state == DLOtpCellState.invisible ||
          state == DLOtpCellState.error ||
          state == DLOtpCellState.success;

      if (useDot) {
        return _buildDot(_dotColor());
      } else {
        return _buildDigit(value, _digitColor());
      }
    }

    // Normal empty cell: nothing inside.
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _background(),
        borderRadius: BorderRadius.circular(DLRadii.md),
        border: Border.all(color: _borderColor(), width: _borderWidth()),
      ),
      alignment: Alignment.center,
      child: _content(),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Blinking caret used for the "active + empty" state
/// ---------------------------------------------------------------------------
class _BlinkingCaret extends StatefulWidget {
  const _BlinkingCaret({required this.height, required this.color});

  final double height;
  final Color color;

  @override
  State<_BlinkingCaret> createState() => _BlinkingCaretState();
}

class _BlinkingCaretState extends State<_BlinkingCaret>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: 2,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}
