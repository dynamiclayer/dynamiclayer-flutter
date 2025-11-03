import 'package:flutter/material.dart';

/// ---------- SHADOWS ----------
class DlShadow {
  DlShadow._();

  /// S: RN shadowColor:#000, offset(0,1), opacity 0.18, radius 1
  static final s = [
    const BoxShadow(
      color: Color(0x2E000000), // ~0.18 opacity black
      offset: Offset(0, 1),
      blurRadius: 1.0,
      spreadRadius: 0,
    ),
  ];

  /// M: offset(0,2), opacity 0.25, radius 3.84
  static final m = const [
    BoxShadow(
      color: Color(0x40000000), // 0.25
      offset: Offset(0, 2),
      blurRadius: 3.84,
      spreadRadius: 0,
    ),
  ];

  /// L: offset(0,4), opacity 0.30, radius 4.65
  static final l = const [
    BoxShadow(
      color: Color(0x4D000000), // 0.30
      offset: Offset(0, 4),
      blurRadius: 4.65,
      spreadRadius: 0,
    ),
  ];
}
