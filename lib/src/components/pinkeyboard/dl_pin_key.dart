// lib/src/components/pinkeyboard/dl_pin_key.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../dynamiclayers.dart';
import '../../../generated/assets.dart';

/// Asset for back arrow key
/// (make sure you have this somewhere globally, or keep this const here)
const String pinkeyboardArrowBack = Assets.pinkeyboardArrowBack;

enum DLPinKeyType {
  text, // number + optional alphabet (e.g. "2" / "ABC")
  icon, // icon only (e.g. backspace)
}

class DLPinKey extends StatefulWidget {
  const DLPinKey.text({
    super.key,
    required this.number,
    this.alphabet,
    this.showAlphabet = true,
    this.onPressed,
  }) : type = DLPinKeyType.text,
       iconAsset = null,
       icon = null;

  const DLPinKey.icon({
    super.key,
    this.onPressed,
    this.iconAsset = pinkeyboardArrowBack,
    this.icon,
  }) : type = DLPinKeyType.icon,
       number = null,
       alphabet = null,
       showAlphabet = false;

  /// Kind of key – text or icon.
  final DLPinKeyType type;

  /// Text key content
  final String? number;
  final String? alphabet;
  final bool showAlphabet;

  /// Icon key content
  final String? iconAsset;
  final Widget? icon;

  /// Called when key is tapped.
  final VoidCallback? onPressed;

  @override
  State<DLPinKey> createState() => _DLPinKeyState();
}

class _DLPinKeyState extends State<DLPinKey> {
  bool _pressed = false;

  static const double _size = 80.0;

  bool get _interactive => widget.onPressed != null;

  void _handleTapDown(TapDownDetails _) {
    if (!_interactive) return;
    setState(() => _pressed = true);
  }

  void _handleTapUp(TapUpDetails _) {
    if (!_interactive) return;
    setState(() => _pressed = false);
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    if (!_interactive) return;
    setState(() => _pressed = false);
  }

  Color get _backgroundColor => _pressed ? DLColors.grey200 : DLColors.grey100;

  Widget _buildContent() {
    switch (widget.type) {
      case DLPinKeyType.text:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.number != null)
              Text(
                widget.number!,
                style: DLTypos.text3xlRegular(color: DLColors.black),
              ),
            if (widget.showAlphabet && widget.alphabet != null) ...[
              const SizedBox(height: 4),
              Text(
                widget.alphabet!,
                style: DLTypos.textSmRegular(color: DLColors.grey500),
              ),
            ],
          ],
        );

      case DLPinKeyType.icon:
        final iconWidget =
            widget.icon ??
            (widget.iconAsset != null
                ? SvgPicture.asset(
                    widget.iconAsset!,
                    width: 8,
                    height: 14,
                    color: DLColors.black,
                  )
                : const SizedBox());
        return Center(child: SizedBox(child: iconWidget));
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: DLRadii.brFull,
      ),
      child: _buildContent(),
    );

    final interactive = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _interactive ? _handleTapDown : null,
      onTapUp: _interactive ? _handleTapUp : null,
      onTapCancel: _interactive ? _handleTapCancel : null,
      child: content,
    );

    return Semantics(button: true, enabled: _interactive, child: interactive);
  }
}
