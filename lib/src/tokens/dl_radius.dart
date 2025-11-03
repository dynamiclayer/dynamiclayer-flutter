import 'package:flutter/material.dart';

class DLRadii {
  DLRadii._();

  static const double none = 0;
  static const double sm = 2;
  static const double base = 4;
  static const double md = 8;
  static const double lg = 12;
  static const double xl = 16;
  static const double x2l = 20;
  static const double x3l = 24;
  static const double x4l = 28;
  static const double x5l = 32;
  static const double full = 9999;

  // Ready BorderRadius shortcuts
  static BorderRadius br(double r) => BorderRadius.circular(r);

  static final brNone = br(none);
  static final brSm = br(sm);
  static final brBase = br(base);
  static final brMd = br(md);
  static final brLg = br(lg);
  static final brXl = br(xl);
  static final br2xl = br(x2l);
  static final br3xl = br(x3l);
  static final br4xl = br(x4l);
  static final br5xl = br(x5l);
  static final brFull = br(full);
}
