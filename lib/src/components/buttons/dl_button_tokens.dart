// lib/src/components/buttons/dl_button_tokens.dart
import 'package:flutter/material.dart';
import '../../tokens/dl_colors.dart';
import '../../tokens/dl_radius.dart';
import '../../tokens/dl_spacing.dart';
import '../../tokens/dl_typography.dart';
import 'dl_button_enums.dart';

class DLButtonTokens {
  DLButtonTokens._();

  // Default gap & corner radius
  static const double defaultGap = 8;
  static const double defaultRadius = DLRadii.md;

  /// Width by size (tweak as you like)
  static double widthOf(DLButtonSize size) {
    switch (size) {
      case DLButtonSize.lg:
        return 138;
      case DLButtonSize.md:
        return 124;
      case DLButtonSize.sm:
        return 110;
      case DLButtonSize.xs:
        return 96;
    }
  }

  /// Height by size
  static double heightOf(DLButtonSize size) {
    switch (size) {
      case DLButtonSize.lg:
        return 56;
      case DLButtonSize.md:
        return 48;
      case DLButtonSize.sm:
        return 40;
      case DLButtonSize.xs:
        return 32;
    }
  }

  /// Padding by size
  static EdgeInsets padding(DLButtonSize size) {
    switch (size) {
      case DLButtonSize.lg: // p_24 left/right, p_16 top/bottom
        return DLSpacing.symmetric(h: DLSpacing.p24, v: DLSpacing.p16);
      case DLButtonSize.md:
        return DLSpacing.symmetric(h: DLSpacing.p20, v: DLSpacing.p12);
      case DLButtonSize.sm:
        return DLSpacing.symmetric(h: DLSpacing.p16, v: DLSpacing.p10);
      case DLButtonSize.xs:
        return DLSpacing.symmetric(h: DLSpacing.p12, v: DLSpacing.p8);
    }
  }

  // Colors for PRIMARY across states (kept as earlier)
  static Color primaryBg(DLButtonState state) {
    switch (state) {
      case DLButtonState.hover:
      case DLButtonState.pressed:
        return DLColors.grey800; // #1F1F1F
      case DLButtonState.disabled:
        return DLColors.grey100; // #EEEEEE
      case DLButtonState.normal:
      case DLButtonState.active:
      default:
        return DLColors.black; // #000000
    }
  }

  static Color primaryFg(DLButtonState state) {
    switch (state) {
      case DLButtonState.disabled:
        return DLColors.grey600; // #545454
      default:
        return Colors.white;
    }
  }

  // Label style (you can make this size-dependent later if needed)
  static TextStyle primaryLabel(DLButtonState state) =>
      DLTypos.labelLgBold(primaryFg(state));
}
