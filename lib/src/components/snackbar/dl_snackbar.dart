import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../dynamiclayers.dart';

enum DLSnackbarType { success, error, warning, info }

class DLSnackbar extends StatelessWidget {
  const DLSnackbar({
    super.key,
    required this.type,
    required this.label,
    this.width,
    this.height = 48,
    this.onTap,
  });

  final DLSnackbarType type;
  final String label;

  /// Figma shows Hug(106px). We let it hug by default.
  /// If you want fixed width, pass 106.
  final double? width;

  final double height;

  /// Optional interaction (tap on whole snackbar)
  final VoidCallback? onTap;

  // Figma tokens (from your spec)
  static const double _radius = 12; // rounded_md (adjust if your token differs)
  static const double _borderWidth = 1;
  static const EdgeInsets _padding = EdgeInsets.fromLTRB(
    12,
    12,
    20,
    12,
  ); // left 12, top 12, right 20, bottom 12
  static const double _gap = 8;

  static const double _iconSize = 22;

  String _assetForType() {
    switch (type) {
      case DLSnackbarType.success:
        return 'assets/snackbar/success.svg';
      case DLSnackbarType.error:
        return 'assets/snackbar/error.svg';
      case DLSnackbarType.warning:
        return 'assets/snackbar/warning.svg';
      case DLSnackbarType.info:
        return 'assets/snackbar/info.svg';
    }
  }

  /// Border + icon color should come from the SVG itself if your SVG is colored.
  /// If your SVG is monochrome, you can apply a color filter here.
  Color _borderColor() {
    // In the screenshot, the container border is a light grey.
    // Keep consistent with your system border token.
    return DLColors.grey200;
  }

  TextStyle _labelStyle() {
    // Your typography: Inter regular, size 3, line-height 3, letter-spacing 7, centered.
    // In DynamicLayers you likely map that to something like DLTypos.body3Regular.
    // If you have a specific token, swap this to it.
    return DLTypos.textBaseSemibold();
  }

  @override
  Widget build(BuildContext context) {
    final border = Border.all(color: _borderColor(), width: _borderWidth);

    final content = Container(
      width: width, // null => hug
      height: height,
      padding: _padding,
      decoration: BoxDecoration(
        color: DLColors.white,
        border: border,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Row(
        mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon (22x22)
          SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: SvgPicture.asset(_assetForType(), fit: BoxFit.contain),
          ),
          const SizedBox(width: _gap),

          // Label
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _labelStyle(),
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return content;

    return InkWell(
      borderRadius: BorderRadius.circular(_radius),
      onTap: onTap,
      child: content,
    );
  }
}
