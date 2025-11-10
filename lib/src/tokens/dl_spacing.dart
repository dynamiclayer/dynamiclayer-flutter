import 'package:flutter/widgets.dart';

class DLSpacing {
  DLSpacing._();

  static const double p0 = 0;
  static const double p2 = 2;
  static const double p4 = 4;
  static const double p6 = 6;
  static const double p8 = 8;
  static const double p10 = 10;
  static const double p12 = 12;
  static const double p16 = 16;
  static const double p20 = 20;
  static const double p24 = 24;
  static const double p28 = 28;
  static const double p32 = 32;
  static const double p36 = 36;
  static const double p40 = 40;
  static const double p44 = 44;
  static const double p48 = 48;
  static const double p56 = 56;
  static const double p64 = 64;
  static const double p80 = 80;
  static const double p96 = 96;

  // EdgeInsets helpers
  static EdgeInsets all(double v) => EdgeInsets.all(v);
  static EdgeInsets symmetric({double h = 0, double v = 0}) =>
      EdgeInsets.symmetric(horizontal: h, vertical: v);
  static EdgeInsets only({
    double l = 0,
    double t = 0,
    double r = 0,
    double b = 0,
  }) => EdgeInsets.only(left: l, top: t, right: r, bottom: b);

  // Common presets
  static final a8 = all(p8);
  static final a12 = all(p12);
  static final a16 = all(p16);
  static final a24 = all(p24);
  static final a32 = all(p32);

  static final h16v8 = symmetric(h: p16, v: p8);
  static final h12v12 = symmetric(h: p12, v: p12);
}
