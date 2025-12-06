// lib/src/components/line_item_message/dl_line_item_message.dart
import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';
import '../../../generated/assets.dart';
// import '../avatar/dl_avatar.dart';
// import '../avatar/dl_avatar_group.dart';
import '../badge/dl_badge.dart';
import '../separator/dl_separator.dart';

enum DLLineItemMessageType { single, group }

enum DLLineItemMessageState { normal, newlyReceived, disabled }

class DLLineItemMessage extends StatelessWidget {
  const DLLineItemMessage({
    super.key,
    this.width = 375,
    required this.type,
    required this.state,
    required this.title,
    required this.message,
    required this.timeLabel,

    // Single avatar
    this.avatarImage,

    // Group avatars
    this.groupItems,

    // Badge
    this.unreadCount = 0,
    this.badgeColor,

    // Separators
    this.showTopSeparator = false,
    this.showBottomSeparator = true,

    // Tap
    this.onTap,
  });

  /// Fixed width of the row (defaults to 375).
  final double width;

  final DLLineItemMessageType type;
  final DLLineItemMessageState state;

  final String title;
  final String message;
  final String timeLabel;

  /// Optional single avatar image. If null we fall back to
  /// `Assets.avatarAvatar`.
  final ImageProvider? avatarImage;

  /// Optional avatar group items. If null we fall back to a group created from
  /// `Assets.avatarAvatar` and `Assets.avatarAvatar1`.
  final List<DLAvatarItem>? groupItems;

  /// Number of unread messages. When > 0 and [state] == newlyReceived,
  /// a badge is shown.
  final int unreadCount;

  /// Badge color. Defaults to **red** (DLColors.red500) if null.
  final Color? badgeColor;

  final bool showTopSeparator;
  final bool showBottomSeparator;

  final VoidCallback? onTap;

  bool get _isDisabled => state == DLLineItemMessageState.disabled;

  TextStyle get _titleStyle {
    if (_isDisabled) {
      return DLTypos.textBaseRegular(color: DLColors.grey500);
    }
    return DLTypos.textBaseSemibold(color: DLColors.black);
  }

  TextStyle get _messageStyle {
    switch (state) {
      case DLLineItemMessageState.normal:
        return DLTypos.textSmRegular(color: DLColors.grey500);
      case DLLineItemMessageState.newlyReceived:
        return DLTypos.textSmSemibold(color: DLColors.black);
      case DLLineItemMessageState.disabled:
        return DLTypos.textSmRegular(
          color: DLColors.grey500,
        ).copyWith(decoration: TextDecoration.lineThrough);
    }
  }

  TextStyle get _timeStyle => DLTypos.textXsRegular(color: DLColors.grey500);

  Color? get _rowBackground {
    // We keep background mostly null (transparent / scaffold) to match spec.
    // Disabled keeps same background but with dimmed text.
    return null;
  }

  bool get _showBadge =>
      state == DLLineItemMessageState.newlyReceived && unreadCount > 0;

  Color get _badgeColor => badgeColor ?? DLColors.red500;

  Widget _buildLeading() {
    if (type == DLLineItemMessageType.single) {
      final img = avatarImage ?? const AssetImage(Assets.avatarAvatar);
      return DLAvatar(
        type: DLAvatarType.image,
        size: DLAvatarSize.sm, // 40px
        imageProvider: img,
        backgroundColor: DLColors.violet50,
      );
    }

    // group
    final items =
        groupItems ??
        [
          DLAvatarItem.image(
            const AssetImage(Assets.avatarAvatar),
            backgroundColor: DLColors.violet50,
          ),
          DLAvatarItem.image(
            const AssetImage(Assets.avatarAvatar1),
            backgroundColor: DLColors.blue50,
          ),
        ];

    return DLAvatarGroup(
      groupSize: DLAvatarGroupSize.lg,
      items: items,
      maxVisible: 2,
      showCounterBubble: false,
    );
  }

  Widget? _buildBadge() {
    if (!_showBadge) return null;
    return DLBadge(
      size: DLBadgeSize.md,
      count: unreadCount,
      backgroundColor: _badgeColor,
      foregroundColor: DLColors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final row = ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 76, // height is hug; can grow with text
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(color: _rowBackground),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DLSpacing.p16,
            vertical: DLSpacing.p12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLeading(),
              const SizedBox(width: DLSpacing.p12),
              // Texts
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: _titleStyle),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: _messageStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: DLSpacing.p8),
              // Time + badge
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(timeLabel, style: _timeStyle),
                  const SizedBox(height: 4),
                  if (_buildBadge() != null) _buildBadge()!,
                ],
              ),
            ],
          ),
        ),
      ),
    );

    Widget content = SizedBox(
      width: width, // fixed width
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTopSeparator)
            const DLSeparator(
              direction: DLSeparatorDirection.horizontal,
              thickness: 1,
              color: DLColors.grey200,
            ),
          row,
          if (showBottomSeparator)
            const DLSeparator(
              direction: DLSeparatorDirection.horizontal,
              thickness: 1,
              color: DLColors.grey200,
            ),
        ],
      ),
    );

    if (onTap != null) {
      content = InkWell(onTap: _isDisabled ? null : onTap, child: content);
    }

    return content;
  }
}
