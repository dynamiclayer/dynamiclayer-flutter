import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens aligned with AppText
/// - Inter family
/// - Exact sizes, line-heights, letter-spacing
/// - Light/Regular/Medium/Semibold/Bold + Link/Strike variants
///
/// Usage:
///   Text('Hello', style: DLTypos.textSmSemibold(color: Colors.black))
///   Text('Link',  style: DLTypos.textBaseLink())
class DLTypos {
  DLTypos._();

  // Core helper: Inter with px-based line-height + px-based letter-spacing
  static TextStyle _inter({
    required double size,
    required double heightPx,
    required double letterSpacingPx,
    FontWeight weight = FontWeight.w400,
    TextDecoration? decoration,
    Color? color,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      height: heightPx / size,
      fontWeight: weight,
      decoration: decoration,
      decorationColor: color,
      color: color,
      letterSpacing: letterSpacingPx,
    );
  }

  // ------------------------------ XS (12 / 16, ls 0.04) ---------------------
  static TextStyle textXsLight({Color? color}) => _inter(
    size: 12,
    heightPx: 16,
    letterSpacingPx: 0.04,
    weight: FontWeight.w300,
    color: color,
  );
  static TextStyle textXsRegular({Color? color}) => _inter(
    size: 12,
    heightPx: 16,
    letterSpacingPx: 0.04,
    weight: FontWeight.w400,
    color: color,
  );
  static TextStyle textXsMedium({Color? color}) => _inter(
    size: 12,
    heightPx: 16,
    letterSpacingPx: 0.04,
    weight: FontWeight.w500,
    color: color,
  );
  static TextStyle textXsSemibold({Color? color}) => _inter(
    size: 12,
    heightPx: 16,
    letterSpacingPx: 0.04,
    weight: FontWeight.w600,
    color: color,
  );
  static TextStyle textXsBold({Color? color}) => _inter(
    size: 12,
    heightPx: 16,
    letterSpacingPx: 0.04,
    weight: FontWeight.w700,
    color: color,
  );
  static TextStyle textXsLink({Color? color}) => _inter(
    size: 12,
    heightPx: 16,
    letterSpacingPx: 0.04,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.underline,
  );
  static TextStyle textXsStrike({Color? color}) => _inter(
    size: 12,
    heightPx: 16,
    letterSpacingPx: 0.04,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.lineThrough,
  );

  // ------------------------------ SM (14 / 20, ls 0) ------------------------
  static TextStyle textSmLight({Color? color}) => _inter(
    size: 14,
    heightPx: 20,
    letterSpacingPx: 0,
    weight: FontWeight.w300,
    color: color,
  );
  static TextStyle textSmRegular({Color? color}) => _inter(
    size: 14,
    heightPx: 20,
    letterSpacingPx: 0,
    weight: FontWeight.w400,
    color: color,
  );
  static TextStyle textSmMedium({Color? color}) => _inter(
    size: 14,
    heightPx: 20,
    letterSpacingPx: 0,
    weight: FontWeight.w500,
    color: color,
  );
  static TextStyle textSmSemibold({Color? color}) => _inter(
    size: 14,
    heightPx: 20,
    letterSpacingPx: 0,
    weight: FontWeight.w600,
    color: color,
  );
  static TextStyle textSmBold({Color? color}) => _inter(
    size: 14,
    heightPx: 20,
    letterSpacingPx: 0,
    weight: FontWeight.w700,
    color: color,
  );
  static TextStyle textSmLink({Color? color}) => _inter(
    size: 14,
    heightPx: 20,
    letterSpacingPx: 0,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.underline,
  );
  static TextStyle textSmStrike({Color? color}) => _inter(
    size: 14,
    heightPx: 20,
    letterSpacingPx: 0,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.lineThrough,
  );

  // ------------------------------ Base (16 / 24, ls 0) ----------------------
  static TextStyle textBaseLight({Color? color}) => _inter(
    size: 16,
    heightPx: 24,
    letterSpacingPx: 0,
    weight: FontWeight.w300,
    color: color,
  );
  static TextStyle textBaseRegular({Color? color}) => _inter(
    size: 16,
    heightPx: 24,
    letterSpacingPx: 0,
    weight: FontWeight.w400,
    color: color,
  );
  static TextStyle textBaseMedium({Color? color}) => _inter(
    size: 16,
    heightPx: 24,
    letterSpacingPx: 0,
    weight: FontWeight.w500,
    color: color,
  );
  static TextStyle textBaseSemibold({Color? color}) => _inter(
    size: 16,
    heightPx: 24,
    letterSpacingPx: 0,
    weight: FontWeight.w600,
    color: color,
  );
  static TextStyle textBaseBold({Color? color}) => _inter(
    size: 16,
    heightPx: 24,
    letterSpacingPx: 0,
    weight: FontWeight.w700,
    color: color,
  );
  static TextStyle textBaseLink({Color? color}) => _inter(
    size: 16,
    heightPx: 24,
    letterSpacingPx: 0,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.underline,
  );
  static TextStyle textBaseStrike({Color? color}) => _inter(
    size: 16,
    heightPx: 24,
    letterSpacingPx: 0,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.lineThrough,
  );

  // ------------------------------ LG (18 / 28, ls -0.04) --------------------
  static TextStyle textLgLight({Color? color}) => _inter(
    size: 18,
    heightPx: 28,
    letterSpacingPx: -0.04,
    weight: FontWeight.w300,
    color: color,
  );
  static TextStyle textLgRegular({Color? color}) => _inter(
    size: 18,
    heightPx: 28,
    letterSpacingPx: -0.04,
    weight: FontWeight.w400,
    color: color,
  );
  static TextStyle textLgMedium({Color? color}) => _inter(
    size: 18,
    heightPx: 28,
    letterSpacingPx: -0.04,
    weight: FontWeight.w500,
    color: color,
  );
  static TextStyle textLgSemibold({Color? color}) => _inter(
    size: 18,
    heightPx: 28,
    letterSpacingPx: -0.04,
    weight: FontWeight.w600,
    color: color,
  );
  static TextStyle textLgBold({Color? color}) => _inter(
    size: 18,
    heightPx: 28,
    letterSpacingPx: -0.04,
    weight: FontWeight.w700,
    color: color,
  );
  static TextStyle textLgLink({Color? color}) => _inter(
    size: 18,
    heightPx: 28,
    letterSpacingPx: -0.04,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.underline,
  );
  static TextStyle textLgStrike({Color? color}) => _inter(
    size: 18,
    heightPx: 28,
    letterSpacingPx: -0.04,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.lineThrough,
  );

  // ------------------------------ XL (20 / 28, ls -0.08) --------------------
  static TextStyle textXlLight({Color? color}) => _inter(
    size: 20,
    heightPx: 28,
    letterSpacingPx: -0.08,
    weight: FontWeight.w300,
    color: color,
  );
  static TextStyle textXlRegular({Color? color}) => _inter(
    size: 20,
    heightPx: 28,
    letterSpacingPx: -0.08,
    weight: FontWeight.w400,
    color: color,
  );
  static TextStyle textXlMedium({Color? color}) => _inter(
    size: 20,
    heightPx: 28,
    letterSpacingPx: -0.08,
    weight: FontWeight.w500,
    color: color,
  );
  static TextStyle textXlSemibold({Color? color}) => _inter(
    size: 20,
    heightPx: 28,
    letterSpacingPx: -0.08,
    weight: FontWeight.w600,
    color: color,
  );
  static TextStyle textXlBold({Color? color}) => _inter(
    size: 20,
    heightPx: 28,
    letterSpacingPx: -0.08,
    weight: FontWeight.w700,
    color: color,
  );
  static TextStyle textXlLink({Color? color}) => _inter(
    size: 20,
    heightPx: 28,
    letterSpacingPx: -0.08,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.underline,
  );
  static TextStyle textXlStrike({Color? color}) => _inter(
    size: 20,
    heightPx: 28,
    letterSpacingPx: -0.08,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.lineThrough,
  );

  // ------------------------------ 2XL (24 / 32, ls -0.10) -------------------
  static TextStyle text2xlLight({Color? color}) => _inter(
    size: 24,
    heightPx: 32,
    letterSpacingPx: -0.10,
    weight: FontWeight.w300,
    color: color,
  );
  static TextStyle text2xlRegular({Color? color}) => _inter(
    size: 24,
    heightPx: 32,
    letterSpacingPx: -0.10,
    weight: FontWeight.w400,
    color: color,
  );
  static TextStyle text2xlMedium({Color? color}) => _inter(
    size: 24,
    heightPx: 32,
    letterSpacingPx: -0.10,
    weight: FontWeight.w500,
    color: color,
  );
  static TextStyle text2xlSemibold({Color? color}) => _inter(
    size: 24,
    heightPx: 32,
    letterSpacingPx: -0.10,
    weight: FontWeight.w600,
    color: color,
  );
  static TextStyle text2xlBold({Color? color}) => _inter(
    size: 24,
    heightPx: 32,
    letterSpacingPx: -0.10,
    weight: FontWeight.w700,
    color: color,
  );
  static TextStyle text2xlLink({Color? color}) => _inter(
    size: 24,
    heightPx: 32,
    letterSpacingPx: -0.10,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.underline,
  );
  static TextStyle text2xlStrike({Color? color}) => _inter(
    size: 24,
    heightPx: 32,
    letterSpacingPx: -0.10,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.lineThrough,
  );

  // ------------------------------ 3XL (28 / 36, ls -0.12) -------------------
  static TextStyle text3xlLight({Color? color}) => _inter(
    size: 28,
    heightPx: 36,
    letterSpacingPx: -0.12,
    weight: FontWeight.w300,
    color: color,
  );
  static TextStyle text3xlRegular({Color? color}) => _inter(
    size: 28,
    heightPx: 36,
    letterSpacingPx: -0.12,
    weight: FontWeight.w400,
    color: color,
  );
  static TextStyle text3xlMedium({Color? color}) => _inter(
    size: 28,
    heightPx: 36,
    letterSpacingPx: -0.12,
    weight: FontWeight.w500,
    color: color,
  );
  static TextStyle text3xlSemibold({Color? color}) => _inter(
    size: 28,
    heightPx: 36,
    letterSpacingPx: -0.12,
    weight: FontWeight.w600,
    color: color,
  );
  static TextStyle text3xlBold({Color? color}) => _inter(
    size: 28,
    heightPx: 36,
    letterSpacingPx: -0.12,
    weight: FontWeight.w700,
    color: color,
  );
  static TextStyle text3xlLink({Color? color}) => _inter(
    size: 28,
    heightPx: 36,
    letterSpacingPx: -0.12,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.underline,
  );
  static TextStyle text3xlStrike({Color? color}) => _inter(
    size: 28,
    heightPx: 36,
    letterSpacingPx: -0.12,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.lineThrough,
  );

  // ------------------------------ 4XL (32 / 40, ls -0.16) -------------------
  static TextStyle text4xlLight({Color? color}) => _inter(
    size: 32,
    heightPx: 40,
    letterSpacingPx: -0.16,
    weight: FontWeight.w300,
    color: color,
  );
  static TextStyle text4xlRegular({Color? color}) => _inter(
    size: 32,
    heightPx: 40,
    letterSpacingPx: -0.16,
    weight: FontWeight.w400,
    color: color,
  );
  static TextStyle text4xlMedium({Color? color}) => _inter(
    size: 32,
    heightPx: 40,
    letterSpacingPx: -0.16,
    weight: FontWeight.w500,
    color: color,
  );
  static TextStyle text4xlSemibold({Color? color}) => _inter(
    size: 32,
    heightPx: 40,
    letterSpacingPx: -0.16,
    weight: FontWeight.w600,
    color: color,
  );
  static TextStyle text4xlBold({Color? color}) => _inter(
    size: 32,
    heightPx: 40,
    letterSpacingPx: -0.16,
    weight: FontWeight.w700,
    color: color,
  );
  static TextStyle text4xlLink({Color? color}) => _inter(
    size: 32,
    heightPx: 40,
    letterSpacingPx: -0.16,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.underline,
  );
  static TextStyle text4xlStrike({Color? color}) => _inter(
    size: 32,
    heightPx: 40,
    letterSpacingPx: -0.16,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.lineThrough,
  );

  // ------------------------------ 5XL (40 / 48, ls -0.40) -------------------
  static TextStyle text5xlLight({Color? color}) => _inter(
    size: 40,
    heightPx: 48,
    letterSpacingPx: -0.40,
    weight: FontWeight.w300,
    color: color,
  );
  static TextStyle text5xlRegular({Color? color}) => _inter(
    size: 40,
    heightPx: 48,
    letterSpacingPx: -0.40,
    weight: FontWeight.w400,
    color: color,
  );
  static TextStyle text5xlMedium({Color? color}) => _inter(
    size: 40,
    heightPx: 48,
    letterSpacingPx: -0.40,
    weight: FontWeight.w500,
    color: color,
  );
  static TextStyle text5xlSemibold({Color? color}) => _inter(
    size: 40,
    heightPx: 48,
    letterSpacingPx: -0.40,
    weight: FontWeight.w600,
    color: color,
  );
  static TextStyle text5xlBold({Color? color}) => _inter(
    size: 40,
    heightPx: 48,
    letterSpacingPx: -0.40,
    weight: FontWeight.w700,
    color: color,
  );
  static TextStyle text5xlLink({Color? color}) => _inter(
    size: 40,
    heightPx: 48,
    letterSpacingPx: -0.40,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.underline,
  );
  static TextStyle text5xlStrike({Color? color}) => _inter(
    size: 40,
    heightPx: 48,
    letterSpacingPx: -0.40,
    weight: FontWeight.w700,
    color: color,
    decoration: TextDecoration.lineThrough,
  );

  // ------------------------------ Button label helper -----------------------
  /// 16 / 20, w700 — legacy helper kept for convenience.
  static TextStyle labelLgBold(Color color) => _inter(
    size: 16,
    heightPx: 20,
    letterSpacingPx: 0,
    weight: FontWeight.w700,
    color: color,
  );
}
