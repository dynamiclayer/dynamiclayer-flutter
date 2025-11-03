import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers — Avatar
/// ---------------------------------------------------------------------------
/// Types: icon | initials | image
/// Sizes: lg(56), md(48), sm(40), xs(32)
/// Presence: online | offline | default  (NOT rendered unless [showPresence]=true)
///
/// Notes:
/// • You requested "without online/offline badge": [showPresence] defaults to false.
/// • For [type=image], provide [imageProvider]. Falls back to icon/initials.
/// • For [type=initials], provide [initials] (2 chars recommended).
/// ---------------------------------------------------------------------------

enum DLAvatarType { icon, initials, image }

enum DLAvatarPresence { online, offline, defaultState }

enum DLAvatarSize { lg, md, sm, xs }

class DLAvatar extends StatelessWidget {
  const DLAvatar({
    super.key,
    this.type = DLAvatarType.icon,
    this.size = DLAvatarSize.lg,
    this.presence = DLAvatarPresence.defaultState,

    // Content
    this.initials = 'Aa',
    this.imageProvider,

    // Chrome
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth = DLBorderWidth.w0,

    // Presence
    this.showPresence = false,
    this.presenceOnlineColor = DLColors.green500,
    this.presenceOfflineColor = DLColors.grey300,

    // Misc
    this.tooltip,
  });

  final DLAvatarType type;
  final DLAvatarSize size;
  final DLAvatarPresence presence;

  final String initials;
  final ImageProvider? imageProvider;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderWidth;

  final bool showPresence;
  final Color presenceOnlineColor;
  final Color presenceOfflineColor;

  final String? tooltip;

  // --- Size map --------------------------------------------------------------
  double get _sizePx {
    switch (size) {
      case DLAvatarSize.lg:
        return 56;
      case DLAvatarSize.md:
        return 48;
      case DLAvatarSize.sm:
        return 40;
      case DLAvatarSize.xs:
        return 32;
    }
  }

  double get _fontSize {
    switch (size) {
      case DLAvatarSize.lg:
        return 18;
      case DLAvatarSize.md:
        return 16;
      case DLAvatarSize.sm:
        return 14;
      case DLAvatarSize.xs:
        return 12;
    }
  }

  // Presence dot size relative to avatar
  double get _presenceDot {
    switch (size) {
      case DLAvatarSize.lg:
        return 12;
      case DLAvatarSize.md:
        return 10;
      case DLAvatarSize.sm:
        return 8;
      case DLAvatarSize.xs:
        return 8;
    }
  }

  Color _defaultBackground() {
    switch (type) {
      case DLAvatarType.icon:
      case DLAvatarType.initials:
        return DLColors.grey100;
      case DLAvatarType.image:
        return DLColors.violet50; // subtle tint ring like your mock
    }
  }

  Color _defaultForeground() {
    switch (type) {
      case DLAvatarType.icon:
      case DLAvatarType.initials:
        return DLColors.grey700;
      case DLAvatarType.image:
        return DLColors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? _defaultBackground();
    final fg = foregroundColor ?? _defaultForeground();
    final hasBorder = borderWidth > 0 && (borderColor != null);

    Widget core = Container(
      width: _sizePx,
      height: _sizePx,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: hasBorder
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      child: _buildInner(fg),
    );

    if (showPresence) {
      core = Stack(
        clipBehavior: Clip.none,
        children: [
          core,
          Positioned(
            right: 0,
            bottom: 0,
            child: _PresenceDot(
              size: _presenceDot,
              color: switch (presence) {
                DLAvatarPresence.online => presenceOnlineColor,
                DLAvatarPresence.offline => presenceOfflineColor,
                DLAvatarPresence.defaultState => Colors.transparent,
              },
              strokeColor: DLColors.white,
            ),
          ),
        ],
      );
    }

    if (tooltip == null || tooltip!.isEmpty) return core;
    return Tooltip(message: tooltip!, child: core);
  }

  Widget _buildInner(Color fg) {
    switch (type) {
      case DLAvatarType.icon:
        return Icon(Icons.person, size: _iconSize(), color: fg);

      case DLAvatarType.initials:
        return Text(
          initials,
          style: _initialsStyle(fg),
          maxLines: 1,
          overflow: TextOverflow.clip,
        );

      case DLAvatarType.image:
        if (imageProvider == null) {
          // graceful fallback to icon
          return Icon(Icons.person, size: _iconSize(), color: fg);
        }
        return ClipOval(
          child: Image(
            image: imageProvider!,
            width: _sizePx,
            height: _sizePx,
            fit: BoxFit.cover,
          ),
        );
    }
  }

  double _iconSize() {
    switch (size) {
      case DLAvatarSize.lg:
        return 28;
      case DLAvatarSize.md:
        return 24;
      case DLAvatarSize.sm:
        return 20;
      case DLAvatarSize.xs:
        return 18;
    }
  }

  TextStyle _initialsStyle(Color color) {
    // Inter, semibold, proper line-height via DLTypos
    TextStyle base;
    switch (size) {
      case DLAvatarSize.lg:
        base = DLTypos.textLgSemibold(color: color);
        break;
      case DLAvatarSize.md:
        base = DLTypos.textBaseSemibold(color: color);
        break;
      case DLAvatarSize.sm:
        base = DLTypos.textSmSemibold(color: color);
        break;
      case DLAvatarSize.xs:
        base = DLTypos.textXsSemibold(color: color);
        break;
    }
    return base.copyWith(fontSize: _fontSize);
  }
}

class _PresenceDot extends StatelessWidget {
  const _PresenceDot({
    required this.size,
    required this.color,
    this.strokeColor = Colors.white,
  });

  final double size;
  final Color color;
  final Color strokeColor;

  @override
  Widget build(BuildContext context) {
    if (color.opacity == 0) return const SizedBox.shrink();
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: strokeColor, width: 2),
      ),
    );
  }
}
