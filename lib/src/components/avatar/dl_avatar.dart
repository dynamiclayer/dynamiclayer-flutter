// dl_avatar.dart
import 'package:dynamiclayer_flutter/src/tokens/dl_font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../dynamiclayers.dart';
import '../../../generated/assets.dart';

enum DLAvatarType { icon, initials, image }

enum DLAvatarPresence { online, offline, defaultState }

// ADDED: xxs (24px)
enum DLAvatarSize { lg, md, sm, xs, xxs }

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
      case DLAvatarSize.xxs:
        return 24; // NEW
    }
  }

  double get _fontSize {
    switch (size) {
      case DLAvatarSize.lg:
        return DlFontSize.f5;
      case DLAvatarSize.md:
        return DlFontSize.f4;
      case DLAvatarSize.sm:
        return DlFontSize.f2;
      case DLAvatarSize.xs:
        return DlFontSize.f1;
      case DLAvatarSize.xxs:
        return DlFontSize.f1; // reuse the smallest token
    }
  }

  double get _presenceDot {
    switch (size) {
      case DLAvatarSize.lg:
        return 18;
      case DLAvatarSize.md:
        return 16;
      case DLAvatarSize.sm:
        return 14;
      case DLAvatarSize.xs:
        return 12;
      case DLAvatarSize.xxs:
        return 10;
    }
  }

  Color _defaultBackground() {
    switch (type) {
      case DLAvatarType.icon:
      case DLAvatarType.initials:
        return DLColors.grey100;
      case DLAvatarType.image:
        return DLColors.violet50;
    }
  }

  Color _defaultForeground() {
    switch (type) {
      case DLAvatarType.icon:
      case DLAvatarType.initials:
        return DLColors.grey500; // NOTE: matches your request for small sizes
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
        return Padding(
          padding: EdgeInsets.all(_iconInnerPadding()),
          child: SvgPicture.asset(
            Assets.avatarUser,
            width: _iconSize(),
            height: _iconSize(),
            color: fg,
          ),
        );

      case DLAvatarType.initials:
        return Text(
          initials.length > 2 ? initials.substring(0, 2) : initials,
          style: _initialsStyle(fg),
          maxLines: 1,
          overflow: TextOverflow.clip,
        );

      case DLAvatarType.image:
        if (imageProvider == null) {
          return SvgPicture.asset(
            Assets.avatarUser,
            width: _iconSize(),
            height: _iconSize(),
            color: fg,
          );
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
      case DLAvatarSize.md:
      case DLAvatarSize.sm:
        return 24;
      case DLAvatarSize.xs:
        return 16;
      case DLAvatarSize.xxs:
        return 12; // NEW
    }
  }

  double _iconInnerPadding() {
    switch (size) {
      case DLAvatarSize.lg:
        return 16;
      case DLAvatarSize.md:
        return 12;
      case DLAvatarSize.sm:
        return 8;
      case DLAvatarSize.xs:
        return 8;
      case DLAvatarSize.xxs:
        return 6; // NEW
    }
  }

  TextStyle _initialsStyle(Color color) {
    TextStyle base;
    switch (size) {
      case DLAvatarSize.lg:
      case DLAvatarSize.md:
      case DLAvatarSize.sm:
      case DLAvatarSize.xs:
      case DLAvatarSize.xxs:
        base = DLTypos.textXlSemibold(color: color);
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
