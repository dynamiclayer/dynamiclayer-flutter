import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../generated/assets.dart';

class DemoAvatarGroupPage extends StatelessWidget {
  const DemoAvatarGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final img1 = const AssetImage(Assets.avatarAvatar);
    final img2 = const AssetImage(Assets.avatarAvatar1);

    return Scaffold(
      appBar: AppBar(title: const Text('Avatar Group — Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Line(
            label: 'Large (lg)',
            children: [
              _duoImage(
                groupSize: DLAvatarGroupSize.lg,
                img1: img1,
                img2: img2,
              ),
              _duoInitials(groupSize: DLAvatarGroupSize.lg),
              _duoIcon(groupSize: DLAvatarGroupSize.lg),
              _imageInitialsWithCounter(
                groupSize: DLAvatarGroupSize.lg,
                img: img1,
                count: 2,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _Line(
            label: 'Extra Small (xs)',
            children: [
              _duoImage(
                groupSize: DLAvatarGroupSize.xs,
                img1: img1,
                img2: img2,
              ),
              _duoInitials(groupSize: DLAvatarGroupSize.xs),
              _duoIcon(groupSize: DLAvatarGroupSize.xs),
              _imageInitialsWithCounter(
                groupSize: DLAvatarGroupSize.xs,
                img: img1,
                count: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // === Builders ==============================================================
  Widget _duoImage({
    required DLAvatarGroupSize groupSize,
    required ImageProvider img1,
    required ImageProvider img2,
  }) {
    return DLAvatarGroup(
      groupSize: groupSize,
      items: [
        DLAvatarItem.image(
          img1,
          backgroundColor: DLColors.violet50,
          borderColor: const Color(0xFFECE8FF),
          borderWidth: 2,
        ),
        DLAvatarItem.image(
          img2,
          backgroundColor: const Color(0xFFE6F6FF),
          borderColor: const Color(0xFFE6F6FF),
          borderWidth: 2,
        ),
      ],
      ringColor: const Color(0xFFECE8FF),
      overlapFraction: 0.60,
    );
  }

  Widget _duoInitials({required DLAvatarGroupSize groupSize}) {
    return DLAvatarGroup(
      groupSize: groupSize,
      items: [DLAvatarItem.initials('A'), DLAvatarItem.initials('Aa')],
      overlapFraction: 0.60,
    );
  }

  Widget _duoIcon({required DLAvatarGroupSize groupSize}) {
    return DLAvatarGroup(
      groupSize: groupSize,
      items: [DLAvatarItem.icon(), DLAvatarItem.icon()],
      overlapFraction: 0.60,
    );
  }

  Widget _imageInitialsWithCounter({
    required DLAvatarGroupSize groupSize,
    required ImageProvider img,
    required int count,
  }) {
    return DLAvatarGroup(
      groupSize: groupSize,
      items: [
        DLAvatarItem.image(
          img,
          backgroundColor: DLColors.violet50,
          borderColor: const Color(0xFFECE8FF),
          borderWidth: 2,
        ),
        DLAvatarItem.initials('Aa'),
      ],
      maxVisible: 2, // image + initials
      showCounterBubble: true, // plus bubble
      overflowCount: count, // exactly 2
      overlapFraction: 0.60,
    );
  }
}

// === Small helpers ===========================================================
class _Line extends StatelessWidget {
  const _Line({required this.label, required this.children});
  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: DLTypos.textBaseBold(color: DLColors.grey800),
          ),
        ),
        Expanded(
          child: Wrap(
            spacing: 28,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          ),
        ),
      ],
    );
  }
}
