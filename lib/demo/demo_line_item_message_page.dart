// lib/demo/demo_line_item_message_page.dart
import 'package:flutter/material.dart';

import '../dynamiclayers.dart';
import '../generated/assets.dart';
import '../src/components/line_item_message/dl_line_item_message.dart';
import '../src/components/avatar/dl_avatar_group.dart';

class DemoLineItemMessagePage extends StatelessWidget {
  const DemoLineItemMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    const shortText =
        'There is a new update: Your Reservation has been canceled.';
    const longText =
        'Hello Thomas, we are happy to meet you! Meeting Point See you in Lungard...';

    // Reusable group items
    final groupItems = [
      DLAvatarItem.image(
        const AssetImage(Assets.avatarAvatar),
        backgroundColor: DLColors.violet50,
      ),
      DLAvatarItem.image(
        const AssetImage(Assets.avatarAvatar1),
        backgroundColor: DLColors.blue50,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Line Item Message — Catalog')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text('Line Item Message', style: DLTypos.textSmBold()),
                const SizedBox(height: 8),
                Text(
                  'Messages list row with avatar / avatar group / badge and separators.',
                  style: DLTypos.textSmRegular(color: DLColors.grey600),
                ),
                const SizedBox(height: 32),

                // ----------------------------------------------------------------
                // Grid of examples (3 columns on wide screens, wrap on narrow)
                // ----------------------------------------------------------------
                Wrap(
                  spacing: 24,
                  runSpacing: 32,
                  children: [
                    // Column 1 — default
                    _ColumnBlock(
                      label: 'Default',
                      children: [
                        SizedBox(
                          width: 375,
                          child: DLLineItemMessage(
                            type: DLLineItemMessageType.single,
                            state: DLLineItemMessageState.normal,
                            title: 'Name',
                            message: shortText,
                            timeLabel: '17:32',
                            // single avatar uses default icon avatar
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 375,
                          child: DLLineItemMessage(
                            type: DLLineItemMessageType.group,
                            state: DLLineItemMessageState.normal,
                            title: 'Name',
                            message: shortText,
                            timeLabel: '17:32',
                            groupItems: groupItems,
                          ),
                        ),
                      ],
                    ),

                    // Column 2 — new (unread, bold message + badge)
                    _ColumnBlock(
                      label: 'New',
                      children: [
                        SizedBox(
                          width: 375,
                          child: DLLineItemMessage(
                            type: DLLineItemMessageType.single,
                            state: DLLineItemMessageState.newlyReceived,
                            title: 'Name',
                            message: longText,
                            timeLabel: '17:32',
                            unreadCount: 1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 375,
                          child: DLLineItemMessage(
                            type: DLLineItemMessageType.group,
                            state: DLLineItemMessageState.newlyReceived,
                            title: 'Name',
                            message: longText,
                            timeLabel: '17:32',
                            groupItems: groupItems,
                            unreadCount: 1,
                          ),
                        ),
                      ],
                    ),

                    // Column 3 — disabled
                    _ColumnBlock(
                      label: 'Disabled',
                      children: [
                        SizedBox(
                          width: 375,
                          child: DLLineItemMessage(
                            type: DLLineItemMessageType.single,
                            state: DLLineItemMessageState.disabled,
                            title: 'Name',
                            message: shortText,
                            timeLabel: '17:32',
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 375,
                          child: DLLineItemMessage(
                            type: DLLineItemMessageType.group,
                            state: DLLineItemMessageState.disabled,
                            title: 'Name',
                            message: shortText,
                            timeLabel: '17:32',
                            groupItems: groupItems,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColumnBlock extends StatelessWidget {
  const _ColumnBlock({required this.label, required this.children});

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: DLTypos.textSmSemibold(color: DLColors.grey600)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}
