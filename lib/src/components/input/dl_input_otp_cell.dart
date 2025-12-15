// lib/src/components/input/dl_input_otp_cell.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    /// If you don't pass a controller, [value] will be used for rendering.
    required this.value,

    this.state = DLOtpCellState.normal,
    this.obscure = false,
    this.size = 48,

    // Keyboard / input (optional)
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.onBackspaceWhenEmpty,
    this.autofocus = false,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
  });

  final String value;
  final DLOtpCellState state;
  final bool obscure;
  final double size;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  /// Called when backspace is pressed while this cell is focused AND empty.
  final VoidCallback? onBackspaceWhenEmpty;

  final bool autofocus;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;

  bool get _isDisabled => state == DLOtpCellState.disabled;

  String get _text => controller?.text ?? value;
  bool get _hasValue => _text.isNotEmpty;

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

  Widget _buildCaret() =>
      _BlinkingCaret(height: size * 0.5, color: _digitColor());

  Widget _buildDot(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildDash(Color color) =>
      Text('-', style: DLTypos.textSmRegular(color: color));

  Widget _buildDigit(String char, Color color) =>
      Text(char, style: DLTypos.textLgRegular(color: color));

  Widget _content() {
    if (_isDisabled && !_hasValue) return _buildDash(DLColors.grey500);
    if (state == DLOtpCellState.active && !_hasValue) return _buildCaret();

    if (_hasValue) {
      final useDot = obscure || state == DLOtpCellState.invisible;
      return useDot
          ? _buildDot(_dotColor())
          : _buildDigit(_text, _digitColor());
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasTextField = controller != null;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: _background(),
                borderRadius: BorderRadius.circular(DLRadii.md),
                border: Border.all(
                  color: _borderColor(),
                  width: _borderWidth(),
                ),
              ),
              alignment: Alignment.center,
              child: _content(),
            ),
          ),

          if (hasTextField)
            Positioned.fill(
              child: CallbackShortcuts(
                bindings: {
                  const SingleActivator(LogicalKeyboardKey.backspace): () {
                    if (_isDisabled) return;
                    if (controller!.text.isEmpty) {
                      onBackspaceWhenEmpty?.call();
                    }
                  },
                },
                child: _InvisibleOtpTextField(
                  enabled: !_isDisabled,
                  controller: controller!,
                  focusNode: focusNode,
                  autofocus: autofocus,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  inputFormatters:
                      inputFormatters ??
                      [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                  onChanged: onChanged,
                  onTap: () {
                    final node = focusNode;
                    if (node != null && !node.hasFocus) node.requestFocus();
                    onTap?.call();
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InvisibleOtpTextField extends StatelessWidget {
  const _InvisibleOtpTextField({
    required this.enabled,
    required this.controller,
    required this.focusNode,
    required this.autofocus,
    required this.keyboardType,
    required this.textInputAction,
    required this.inputFormatters,
    required this.onChanged,
    required this.onTap,
  });

  final bool enabled;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      maxLength: 1,
      showCursor: false,
      enableInteractiveSelection: false,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.transparent, height: 1, fontSize: 1),
      decoration: const InputDecoration(
        border: InputBorder.none,
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
        counterText: '',
      ),
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}

/// ---------------------------------------------------------------------------
/// Blinking caret
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
