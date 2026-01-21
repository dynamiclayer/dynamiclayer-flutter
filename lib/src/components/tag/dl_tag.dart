// lib/src/components/tag/dl_tag.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// Figma:
/// - height: lg=28, md=24, sm=20
/// - padding: vertical 2, horizontal 8
/// - gap: 2
/// - radius: rounded
/// - font: Inter, 600, size token 3 (mapped to 14 here), centered
///
/// Variants (Type + Mode) colors you provided:
/// default/light: bg #EEEEEE, text #545454
/// default/dark : bg #757575, text #FFFFFF
/// warning/light: bg #FFF441, text #A67102
/// warning/dark : bg #FFD600, text #000000
/// success/light: bg #CBFFC5, text #028907
/// success/dark : bg #00B505, text #FFFFFF
/// error/light  : bg #FFE1DF, text #ED2115
/// error/dark   : bg #FF2C20, text #FFFFFF

enum DLTagType { defaultTag, warning, success, error }

enum DLTagSize { lg, md, sm }

enum DLTagMode { light, dark }

class DLTag extends StatelessWidget {
  const DLTag({
    super.key,
    required this.value,
    this.type = DLTagType.defaultTag,
    this.size = DLTagSize.lg,
    this.mode = DLTagMode.light,
    this.iconLeft,
    this.iconRight,
  });

  final String value;
  final DLTagType type;
  final DLTagSize size;
  final DLTagMode mode;

  /// Optional left icon widget (e.g. SvgPicture.asset(...))
  final Widget? iconLeft;

  /// Optional right icon widget (e.g. SvgPicture.asset(...))
  final Widget? iconRight;

  double get _height {
    switch (size) {
      case DLTagSize.lg:
        return 28;
      case DLTagSize.md:
        return 24;
      case DLTagSize.sm:
        return 20;
    }
  }

  EdgeInsets get _padding =>
      const EdgeInsets.symmetric(horizontal: 8, vertical: 2);

  // Figma says "rounded" (not rounded_full). Keep modest pill rounding.
  BorderRadius get _radius => BorderRadius.circular(8);

  // Gap between items is 2.
  static const double _gap = 2;

  // Icon size not provided; keep proportional and unobtrusive.
  double get _iconSize {
    switch (size) {
      case DLTagSize.lg:
        return 16;
      case DLTagSize.md:
        return 14;
      case DLTagSize.sm:
        return 12;
    }
  }

  ({Color bg, Color fg}) _colors() {
    switch (type) {
      case DLTagType.defaultTag:
        return mode == DLTagMode.light
            ? (bg: const Color(0xFFEEEEEE), fg: const Color(0xFF545454))
            : (bg: const Color(0xFF757575), fg: const Color(0xFFFFFFFF));
      case DLTagType.warning:
        return mode == DLTagMode.light
            ? (bg: const Color(0xFFFFF441), fg: const Color(0xFFA67102))
            : (bg: const Color(0xFFFFD600), fg: const Color(0xFF000000));
      case DLTagType.success:
        return mode == DLTagMode.light
            ? (bg: const Color(0xFFCBFFC5), fg: const Color(0xFF028907))
            : (bg: const Color(0xFF00B505), fg: const Color(0xFFFFFFFF));
      case DLTagType.error:
        return mode == DLTagMode.light
            ? (bg: const Color(0xFFFFE1DF), fg: const Color(0xFFED2115))
            : (bg: const Color(0xFFFF2C20), fg: const Color(0xFFFFFFFF));
    }
  }

  TextStyle _textStyle(Color color) {
    return TextStyle(
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600, // Semi Bold
      fontSize: 14, // token font/size/3 (mapped)
      height: 1.2, // token line-height/3 (mapped)
      letterSpacing: 0.2, // token letter-spacing/7 (mapped)
      color: color,
    );
  }

  Widget _iconWrapper(Widget icon, Color color) {
    // If caller passes SvgPicture with its own color handling, it will ignore this.
    // We keep sizing only, no forced tinting.
    return SizedBox(
      width: _iconSize,
      height: _iconSize,
      child: FittedBox(
        fit: BoxFit.contain,
        child: IconTheme(
          data: IconThemeData(size: _iconSize, color: color),
          child: icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = _colors();

    return Container(
      height: _height,
      padding: _padding,
      decoration: BoxDecoration(color: c.bg, borderRadius: _radius),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconLeft != null) ...[
              _iconWrapper(iconLeft!, c.fg),
              const SizedBox(width: _gap),
            ],
            Text(value, textAlign: TextAlign.center, style: _textStyle(c.fg)),
            if (iconRight != null) ...[
              const SizedBox(width: _gap),
              _iconWrapper(iconRight!, c.fg),
            ],
          ],
        ),
      ),
    );
  }
}
