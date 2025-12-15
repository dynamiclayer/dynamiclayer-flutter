// lib/src/components/line_item_message/dl_line_item_message.dart
import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';
import '../../../generated/assets.dart';
import '../badge/dl_badge.dart';
import '../separator/dl_separator.dart';

enum DLLineItemMessageType { single, group }

enum DLLineItemMessageState { normal, newlyReceived, disabled }

class DLLineItemMessage extends StatelessWidget {
  const DLLineItemMessage({
    super.key,
    this.width,
    required this.type,
    required this.state,
    required this.title,
    required this.message,
    required this.timeLabel,
    this.avatarImage,
    this.groupItems,
    this.unreadCount = 0,
    this.badgeColor,
    this.showTopSeparator = false,
    this.showBottomSeparator = true,
    this.onTap,
  });

  /// If provided, constrains the component width. If null => "hug"/expand.
  final double? width;

  final DLLineItemMessageType type;
  final DLLineItemMessageState state;

  final String title;
  final String message;
  final String timeLabel;

  final ImageProvider? avatarImage;
  final List<DLAvatarItem>? groupItems;

  final int unreadCount;
  final Color? badgeColor;

  final bool showTopSeparator;
  final bool showBottomSeparator;

  final VoidCallback? onTap;

  bool get _isDisabled => state == DLLineItemMessageState.disabled;

  bool get _showBadge =>
      !_isDisabled &&
      state == DLLineItemMessageState.newlyReceived &&
      unreadCount > 0;

  Color get _badgeColor => badgeColor ?? DLColors.red500;

  TextStyle get _titleStyle {
    if (_isDisabled) {
      return DLTypos.textBaseStrike(color: DLColors.grey500);
    }
    return DLTypos.textBaseSemibold(color: DLColors.black);
  }

  TextStyle get _messageStyle {
    if (_isDisabled) {
      return DLTypos.textSmStrike(color: DLColors.grey500);
    }

    switch (state) {
      case DLLineItemMessageState.normal:
        return DLTypos.textSmRegular(color: DLColors.grey500);
      case DLLineItemMessageState.newlyReceived:
        return DLTypos.textSmSemibold(color: DLColors.black);
      case DLLineItemMessageState.disabled:
        return DLTypos.textSmStrike(color: DLColors.grey500);
    }
  }

  TextStyle get _timeStyle => DLTypos.textXsRegular(color: DLColors.grey500);

  Widget _buildLeading() {
    if (type == DLLineItemMessageType.single) {
      final img = avatarImage ?? const AssetImage(Assets.avatarAvatar);
      return DLAvatar(
        type: DLAvatarType.image,
        size: DLAvatarSize.lg,
        imageProvider: img,
        backgroundColor: DLColors.violet50,
      );
    }

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

  Widget _buildBadge() {
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
      constraints: const BoxConstraints(minHeight: 76),
      child: Padding(
        // no side spacing
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: DLSpacing.p12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Disabled visuals: dim avatars + text block (matches screenshot feel)
            Opacity(opacity: _isDisabled ? 0.55 : 1, child: _buildLeading()),
            const SizedBox(width: DLSpacing.p12),

            Expanded(
              child: Opacity(
                opacity: _isDisabled ? 0.85 : 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + time in one container
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: _titleStyle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: DLSpacing.p8),
                        // keep time not struck-through (as in screenshot)
                        Text(timeLabel, style: _timeStyle),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Message + (optional) badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: _showBadge ? 22 : 0),
                          child: Text(
                            message,
                            style: _messageStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (_showBadge)
                          Positioned(
                            right: 0,
                            bottom: -2,
                            child: _buildBadge(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Widget content = Column(
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
    );

    if (width != null) {
      content = SizedBox(width: width, child: content);
    }

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(onTap: _isDisabled ? null : onTap, child: content),
      );
    }

    return content;
  }
}
