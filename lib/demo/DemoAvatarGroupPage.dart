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
      appBar: AppBar(title: const Text('Avatar Group — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionHeader('Large (lg)'),
          const SizedBox(height: 8),
          _PreviewBlock(
            child: _AvatarGroupRow(
              groupSize: DLAvatarGroupSize.lg,
              img1: img1,
              img2: img2,
            ),
            code: _avatarGroupLgCode,
          ),
          const SizedBox(height: 24),

          const _SectionHeader('Extra Small (xs)'),
          const SizedBox(height: 8),
          _PreviewBlock(
            child: _AvatarGroupRow(
              groupSize: DLAvatarGroupSize.xs,
              img1: img1,
              img2: img2,
            ),
            code: _avatarGroupXsCode,
          ),
        ],
      ),
    );
  }
}

/// Row of 4 avatar group variants for a given size
class _AvatarGroupRow extends StatelessWidget {
  const _AvatarGroupRow({
    required this.groupSize,
    required this.img1,
    required this.img2,
  });

  final DLAvatarGroupSize groupSize;
  final ImageProvider img1;
  final ImageProvider img2;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 28,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _duoImage(groupSize: groupSize, img1: img1, img2: img2),
        _duoInitials(groupSize: groupSize),
        _duoIcon(groupSize: groupSize),
        _imageInitialsWithCounter(groupSize: groupSize, img: img1, count: 2),
      ],
    );
  }
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

/// ---------- DOC UI helpers (same pattern as other catalog pages) ----------
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _PreviewBlock extends StatelessWidget {
  const _PreviewBlock({required this.child, required this.code});
  final Widget child;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SubHeader('Preview'),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: _surface(context),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 740),
              child: child,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _SubHeader('Code'),
        const SizedBox(height: 8),
        _CodeBox(code: code),
      ],
    );
  }

  BoxDecoration _surface(BuildContext context) => BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    border: Border.all(color: Colors.black12),
    borderRadius: BorderRadius.circular(12),
  );
}

class _SubHeader extends StatelessWidget {
  const _SubHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).colorScheme.surfaceVariant;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
      ),
    );
  }
}

/// ---------- Code Samples ----------
const _avatarGroupLgCode = '''
// Large (lg) avatar groups
final img1 = const AssetImage(Assets.avatarAvatar);
final img2 = const AssetImage(Assets.avatarAvatar1);

Wrap(
  spacing: 28,
  runSpacing: 12,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    // 1) Two images with custom borders & ring
    DLAvatarGroup(
      groupSize: DLAvatarGroupSize.lg,
      items: [
        DLAvatarItem.image(
          img1,
          backgroundColor: DLColors.violet50,
          borderColor: Color(0xFFECE8FF),
          borderWidth: 2,
        ),
        DLAvatarItem.image(
          img2,
          backgroundColor: Color(0xFFE6F6FF),
          borderColor: Color(0xFFE6F6FF),
          borderWidth: 2,
        ),
      ],
      ringColor: Color(0xFFECE8FF),
      overlapFraction: 0.60,
    ),

    // 2) Initials
    DLAvatarGroup(
      groupSize: DLAvatarGroupSize.lg,
      items: [
        DLAvatarItem.initials('A'),
        DLAvatarItem.initials('Aa'),
      ],
      overlapFraction: 0.60,
    ),

    // 3) Icons
    DLAvatarGroup(
      groupSize: DLAvatarGroupSize.lg,
      items: [
        DLAvatarItem.icon(),
        DLAvatarItem.icon(),
      ],
      overlapFraction: 0.60,
    ),

    // 4) Image + initials + counter bubble
    DLAvatarGroup(
      groupSize: DLAvatarGroupSize.lg,
      items: [
        DLAvatarItem.image(
          img1,
          backgroundColor: DLColors.violet50,
          borderColor: Color(0xFFECE8FF),
          borderWidth: 2,
        ),
        DLAvatarItem.initials('Aa'),
      ],
      maxVisible: 2,
      showCounterBubble: true,
      overflowCount: 2,
      overlapFraction: 0.60,
    ),
  ],
);
''';

const _avatarGroupXsCode = '''
// Extra Small (xs) avatar groups
final img1 = const AssetImage(Assets.avatarAvatar);
final img2 = const AssetImage(Assets.avatarAvatar1);

Wrap(
  spacing: 28,
  runSpacing: 12,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    // 1) Two images
    DLAvatarGroup(
      groupSize: DLAvatarGroupSize.xs,
      items: [
        DLAvatarItem.image(
          img1,
          backgroundColor: DLColors.violet50,
          borderColor: Color(0xFFECE8FF),
          borderWidth: 2,
        ),
        DLAvatarItem.image(
          img2,
          backgroundColor: Color(0xFFE6F6FF),
          borderColor: Color(0xFFE6F6FF),
          borderWidth: 2,
        ),
      ],
      ringColor: Color(0xFFECE8FF),
      overlapFraction: 0.60,
    ),

    // 2) Initials
    DLAvatarGroup(
      groupSize: DLAvatarGroupSize.xs,
      items: [
        DLAvatarItem.initials('A'),
        DLAvatarItem.initials('Aa'),
      ],
      overlapFraction: 0.60,
    ),

    // 3) Icons
    DLAvatarGroup(
      groupSize: DLAvatarGroupSize.xs,
      items: [
        DLAvatarItem.icon(),
        DLAvatarItem.icon(),
      ],
      overlapFraction: 0.60,
    ),

    // 4) Image + initials + counter bubble
    DLAvatarGroup(
      groupSize: DLAvatarGroupSize.xs,
      items: [
        DLAvatarItem.image(
          img1,
          backgroundColor: DLColors.violet50,
          borderColor: Color(0xFFECE8FF),
          borderWidth: 2,
        ),
        DLAvatarItem.initials('Aa'),
      ],
      maxVisible: 2,
      showCounterBubble: true,
      overflowCount: 2,
      overlapFraction: 0.60,
    ),
  ],
);
''';
