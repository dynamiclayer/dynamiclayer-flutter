// dl_avatar_group.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers — AvatarGroup (diagonal with ~40% overlap)
/// ---------------------------------------------------------------------------
/// Group sizes:
/// • lg → each item is 40px (uses DLAvatarSize.sm)
/// • xs → each item is 24px (uses DLAvatarSize.xxs)
/// Overlap: default 0.40 for both X and Y
/// Layouts: row | diagonal (default: diagonal)
/// Optional numeric counter bubble as last circle
/// ---------------------------------------------------------------------------

class DLAvatarItem {
  DLAvatarItem.icon({
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.tooltip,
  }) : type = DLAvatarType.icon,
       initials = null,
       imageProvider = null;

  DLAvatarItem.initials(
    this.initials, {
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.tooltip,
  }) : type = DLAvatarType.initials,
       imageProvider = null;

  DLAvatarItem.image(
    this.imageProvider, {
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.tooltip,
  }) : type = DLAvatarType.image,
       initials = null;

  final DLAvatarType type;
  final String? initials;
  final ImageProvider? imageProvider;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final String? tooltip;
}

enum DLAvatarGroupLayout { row, diagonal }

enum DLAvatarGroupSize { lg, xs } // NEW: only two sizes as requested

class DLAvatarGroup extends StatelessWidget {
  const DLAvatarGroup({
    super.key,
    required this.groupSize,
    required this.items,

    this.maxVisible = 2,
    this.overflowCount,
    this.showCounterBubble = false,

    this.direction = TextDirection.ltr,
    this.layout = DLAvatarGroupLayout.diagonal,
    this.overlapFraction, // default 0.40 (40%)
    this.diagonalYOffsetFraction, // default 0.40 (40%)
    this.ringColor,
  });

  final DLAvatarGroupSize groupSize;
  final List<DLAvatarItem> items;

  final int maxVisible;
  final int? overflowCount;
  final bool showCounterBubble;

  final TextDirection direction;
  final DLAvatarGroupLayout layout;
  final double? overlapFraction;
  final double? diagonalYOffsetFraction;
  final Color? ringColor;

  // ---- per-item pixel + DLAvatar size mapping ------------------------------
  double get _itemPx => switch (groupSize) {
    DLAvatarGroupSize.lg => 40, // mapped to DLAvatarSize.sm
    DLAvatarGroupSize.xs => 24, // mapped to DLAvatarSize.xxs
  };

  DLAvatarSize get _avatarSizeEnum => switch (groupSize) {
    DLAvatarGroupSize.lg => DLAvatarSize.sm,
    DLAvatarGroupSize.xs => DLAvatarSize.xxs,
  };

  // Default overlap set to 0.40 for all sizes
  double get _defaultOverlap => 0.40;

  TextStyle _countStyle(Color color) {
    switch (groupSize) {
      case DLAvatarGroupSize.lg:
        return DLTypos.textSmSemibold(color: color);
      case DLAvatarGroupSize.xs:
        return DLTypos.textXsSemibold(color: color);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ov = overlapFraction ?? _defaultOverlap;

    // Horizontal step: remaining visible part after overlap
    final xStep = _itemPx * (1 - ov);

    // Vertical step (diagonal)
    final yStep = layout == DLAvatarGroupLayout.diagonal
        ? _itemPx * (1 - (diagonalYOffsetFraction ?? ov))
        : 0.0;

    final visible = items.take(maxVisible).toList();

    final needsCounterBecauseOverflow =
        overflowCount != null && items.length > maxVisible;

    final showCounter = showCounterBubble || needsCounterBecauseOverflow;

    final children = <Widget>[];

    final countForAvatars = showCounter ? visible.length - 1 : visible.length;
    final baseIndexes = List<int>.generate(countForAvatars, (i) => i);
    final ordered = direction == TextDirection.ltr
        ? baseIndexes
        : baseIndexes.reversed;

    // Build avatars (except last slot reserved when counter is shown)
    for (final i in ordered) {
      final item = visible[i];

      final dx = (direction == TextDirection.ltr ? 1 : -1) * (i * xStep);
      final dy = i * yStep;

      children.add(
        Positioned(
          left: direction == TextDirection.ltr ? dx : null,
          right: direction == TextDirection.rtl ? dx.abs() : null,
          top: dy,
          child: _buildAvatar(item),
        ),
      );
    }

    // Add counter bubble if requested (occupies the last slot)
    if (showCounter) {
      final lastIndex = countForAvatars.clamp(0, countForAvatars);
      final dx =
          (direction == TextDirection.ltr ? 1 : -1) * (lastIndex * xStep);
      final dy = lastIndex * yStep;

      children.add(
        Positioned(
          left: direction == TextDirection.ltr ? dx : null,
          right: direction == TextDirection.rtl ? dx.abs() : null,
          top: dy,
          child: _CounterCircle(
            size: _itemPx,
            text: '${overflowCount ?? 2}',
            style: _countStyle(DLColors.grey700),
          ),
        ),
      );
    }

    // Overall canvas size
    final totalColumns = (showCounter ? countForAvatars + 1 : countForAvatars);
    final totalWidth = totalColumns <= 0
        ? _itemPx
        : _itemPx + (xStep * ((totalColumns - 1).clamp(0, 999)));

    final totalHeight = layout == DLAvatarGroupLayout.diagonal
        ? (_itemPx + yStep * ((totalColumns - 1).clamp(0, 999)))
        : _itemPx;

    return SizedBox(
      width: totalWidth,
      height: totalHeight,
      child: Stack(clipBehavior: Clip.none, children: children),
    );
  }

  Widget _buildAvatar(DLAvatarItem item) {
    final withRing = item.type == DLAvatarType.image && ringColor != null;
    final borderClr = item.borderColor ?? (withRing ? ringColor : null);
    final borderW = item.borderWidth ?? (withRing ? 2.0 : 0.0);

    // For group xs (24px), default foreground to grey-500 if not supplied.
    final defaultFgForXxs = groupSize == DLAvatarGroupSize.xs
        ? (item.foregroundColor ?? DLColors.grey500)
        : item.foregroundColor;

    return DLAvatar(
      type: item.type,
      size: _avatarSizeEnum, // 40px → sm, 24px → xxs
      initials: item.initials ?? 'Aa',
      imageProvider: item.imageProvider,
      backgroundColor: item.backgroundColor,
      foregroundColor: defaultFgForXxs,
      borderColor: borderClr,
      borderWidth: borderW,
    );
  }
}

class _CounterCircle extends StatelessWidget {
  const _CounterCircle({
    required this.size,
    required this.text,
    required this.style,
  });

  final double size;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: DLColors.grey100,
        shape: BoxShape.circle,
      ),
      child: Text(text, style: style),
    );
  }
}
