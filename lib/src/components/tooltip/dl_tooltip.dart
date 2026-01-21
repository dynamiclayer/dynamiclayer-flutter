import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

enum DLTooltipDirection { top, bottom, left, right }

class DLTooltip extends StatelessWidget {
  const DLTooltip({super.key, required this.label, required this.direction});

  final String label;
  final DLTooltipDirection direction;

  static const Color _bg = Color(0xFF1F1F1F);

  // Figma-ish
  static const double _radius = 12; // rounded_md-ish
  static const double _arrowDepth = 10;
  static const double _arrowBase = 18;

  // Keep same text padding as earlier tokens you used
  static const EdgeInsets _contentPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  Size get _size {
    switch (direction) {
      case DLTooltipDirection.top:
      case DLTooltipDirection.bottom:
        return const Size(130, 50);
      case DLTooltipDirection.left:
      case DLTooltipDirection.right:
        return const Size(140, 40);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = _size;

    // Content area excludes the arrow space on the arrow side
    final EdgeInsets pad = () {
      switch (direction) {
        case DLTooltipDirection.top:
          return _contentPadding.copyWith(
            top: _contentPadding.top + _arrowDepth,
          );
        case DLTooltipDirection.bottom:
          return _contentPadding.copyWith(
            bottom: _contentPadding.bottom + _arrowDepth,
          );
        case DLTooltipDirection.left:
          return _contentPadding.copyWith(
            left: _contentPadding.left + _arrowDepth,
          );
        case DLTooltipDirection.right:
          return _contentPadding.copyWith(
            right: _contentPadding.right + _arrowDepth,
          );
      }
    }();

    return SizedBox(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        painter: _DLTooltipPainter(
          color: _bg,
          radius: _radius,
          direction: direction,
          arrowDepth: _arrowDepth,
          arrowBase: _arrowBase,
        ),
        child: Padding(
          padding: pad,
          child: Center(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              // use your system typo; keep it smaller than before
              style: DLTypos.textBaseRegular(color: DLColors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _DLTooltipPainter extends CustomPainter {
  _DLTooltipPainter({
    required this.color,
    required this.radius,
    required this.direction,
    required this.arrowDepth,
    required this.arrowBase,
  });

  final Color color;
  final double radius;
  final DLTooltipDirection direction;
  final double arrowDepth;
  final double arrowBase;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    // Rect excluding arrow space
    final Rect r = () {
      switch (direction) {
        case DLTooltipDirection.top:
          return Rect.fromLTWH(
            0,
            arrowDepth,
            size.width,
            size.height - arrowDepth,
          );
        case DLTooltipDirection.bottom:
          return Rect.fromLTWH(0, 0, size.width, size.height - arrowDepth);
        case DLTooltipDirection.left:
          return Rect.fromLTWH(
            arrowDepth,
            0,
            size.width - arrowDepth,
            size.height,
          );
        case DLTooltipDirection.right:
          return Rect.fromLTWH(0, 0, size.width - arrowDepth, size.height);
      }
    }();

    final rr = RRect.fromRectAndRadius(r, Radius.circular(radius));

    // Arrow tip position (centered)
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Build a single continuous path: rounded rect + arrow triangle
    final path = Path()..addRRect(rr);

    // Add arrow as a triangle attached to the rect edge
    switch (direction) {
      case DLTooltipDirection.top:
        {
          final halfBase = arrowBase / 2;
          path
            ..moveTo(cx - halfBase, arrowDepth)
            ..lineTo(cx, 0)
            ..lineTo(cx + halfBase, arrowDepth)
            ..close();
          break;
        }
      case DLTooltipDirection.bottom:
        {
          final halfBase = arrowBase / 2;
          final y = size.height - arrowDepth;
          path
            ..moveTo(cx - halfBase, y)
            ..lineTo(cx, size.height)
            ..lineTo(cx + halfBase, y)
            ..close();
          break;
        }
      case DLTooltipDirection.left:
        {
          final halfBase = arrowBase / 2;
          // Arrow points LEFT, attached at x = arrowDepth
          path
            ..moveTo(arrowDepth, cy - halfBase)
            ..lineTo(0, cy)
            ..lineTo(arrowDepth, cy + halfBase)
            ..close();
          break;
        }
      case DLTooltipDirection.right:
        {
          final halfBase = arrowBase / 2;
          final x = size.width - arrowDepth;
          // Arrow points RIGHT, attached at x = size.width - arrowDepth
          path
            ..moveTo(x, cy - halfBase)
            ..lineTo(size.width, cy)
            ..lineTo(x, cy + halfBase)
            ..close();
          break;
        }
    }

    // Draw combined shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _DLTooltipPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.direction != direction ||
        oldDelegate.arrowDepth != arrowDepth ||
        oldDelegate.arrowBase != arrowBase;
  }
}
