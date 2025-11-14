import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../generated/assets.dart';

class DemoAvatarPage extends StatelessWidget {
  const DemoAvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avatars — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Online'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _AvatarGrid(
              presence: DLAvatarPresence.online,
              showPresence: true,
            ),
            code: _onlineAvatarsCode,
          ),

          SizedBox(height: 24),
          _SectionHeader('Offline'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _AvatarGrid(
              presence: DLAvatarPresence.offline,
              showPresence: true,
            ),
            code: _offlineAvatarsCode,
          ),

          SizedBox(height: 24),
          _SectionHeader('Default (no badge)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _AvatarGrid(
              presence: DLAvatarPresence.defaultState,
              showPresence: false,
            ),
            code: _defaultAvatarsCode,
          ),
        ],
      ),
    );
  }
}

/// Grid for one presence state (online / offline / default)
class _AvatarGrid extends StatelessWidget {
  const _AvatarGrid({required this.presence, required this.showPresence});

  final DLAvatarPresence presence;
  final bool showPresence;

  @override
  Widget build(BuildContext context) {
    final memoji = const AssetImage(Assets.avatarAvatar);

    Widget tile(String label, Widget child) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 8),
        Text(label, style: DLTypos.textXsRegular(color: DLColors.grey600)),
      ],
    );

    final List<Widget> children = [];

    for (final size in DLAvatarSize.values) {
      final sizeLabel = _sizeLabel(size);
      children.addAll([
        // Type: icon
        tile(
          'icon · $sizeLabel',
          DynamicLayers.avatar(
            type: DLAvatarType.icon,
            size: size,
            presence: presence,
            showPresence: showPresence,
          ),
        ),

        // Type: initials
        tile(
          'initials · $sizeLabel',
          DynamicLayers.avatar(
            type: DLAvatarType.initials,
            size: size,
            presence: presence,
            showPresence: showPresence,
            initials: 'Aa',
          ),
        ),

        // Type: image (with subtle lavender ring to match mock)
        tile(
          'image · $sizeLabel',
          DynamicLayers.avatar(
            type: DLAvatarType.image,
            size: size,
            presence: presence,
            showPresence: showPresence,
            imageProvider: memoji,
            borderColor: const Color(0xFFECE8FF), // violet100
            borderWidth: 2.0,
            backgroundColor: DLColors.violet50,
          ),
        ),
      ]);
    }

    return Wrap(
      spacing: 24,
      runSpacing: 24,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }

  String _sizeLabel(DLAvatarSize s) => switch (s) {
    DLAvatarSize.lg => 'lg',
    DLAvatarSize.md => 'md',
    DLAvatarSize.sm => 'sm',
    DLAvatarSize.xs => 'xs',
    DLAvatarSize.xxs => 'xxs',
  };
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
const _onlineAvatarsCode = '''
// Online avatars (green presence dot)
final memoji = const AssetImage(Assets.avatarAvatar);

Wrap(
  spacing: 24,
  runSpacing: 24,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    for (final size in DLAvatarSize.values) ...[
      // Icon
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DynamicLayers.avatar(
            type: DLAvatarType.icon,
            size: size,
            presence: DLAvatarPresence.online,
            showPresence: true,
          ),
          const SizedBox(height: 8),
          Text(
            'icon · \${size.name}',
            style: DLTypos.textXsRegular(color: DLColors.grey600),
          ),
        ],
      ),

      // Initials
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DynamicLayers.avatar(
            type: DLAvatarType.initials,
            size: size,
            presence: DLAvatarPresence.online,
            showPresence: true,
            initials: 'Aa',
          ),
          const SizedBox(height: 8),
          Text(
            'initials · \${size.name}',
            style: DLTypos.textXsRegular(color: DLColors.grey600),
          ),
        ],
      ),

      // Image
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DynamicLayers.avatar(
            type: DLAvatarType.image,
            size: size,
            presence: DLAvatarPresence.online,
            showPresence: true,
            imageProvider: memoji,
            borderColor: const Color(0xFFECE8FF),
            borderWidth: 2.0,
            backgroundColor: DLColors.violet50,
          ),
          const SizedBox(height: 8),
          Text(
            'image · \${size.name}',
            style: DLTypos.textXsRegular(color: DLColors.grey600),
          ),
        ],
      ),
    ],
  ],
);
''';

const _offlineAvatarsCode = '''
// Offline avatars (grey presence dot)
final memoji = const AssetImage(Assets.avatarAvatar);

Wrap(
  spacing: 24,
  runSpacing: 24,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    for (final size in DLAvatarSize.values) ...[
      DynamicLayers.avatar(
        type: DLAvatarType.icon,
        size: size,
        presence: DLAvatarPresence.offline,
        showPresence: true,
      ),
      DynamicLayers.avatar(
        type: DLAvatarType.initials,
        size: size,
        presence: DLAvatarPresence.offline,
        showPresence: true,
        initials: 'Aa',
      ),
      DynamicLayers.avatar(
        type: DLAvatarType.image,
        size: size,
        presence: DLAvatarPresence.offline,
        showPresence: true,
        imageProvider: memoji,
        borderColor: const Color(0xFFECE8FF),
        borderWidth: 2.0,
        backgroundColor: DLColors.violet50,
      ),
    ],
  ],
);
''';

const _defaultAvatarsCode = '''
// Default avatars (no presence badge)
final memoji = const AssetImage(Assets.avatarAvatar);

Wrap(
  spacing: 24,
  runSpacing: 24,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    for (final size in DLAvatarSize.values) ...[
      DynamicLayers.avatar(
        type: DLAvatarType.icon,
        size: size,
        presence: DLAvatarPresence.defaultState,
        showPresence: false,
      ),
      DynamicLayers.avatar(
        type: DLAvatarType.initials,
        size: size,
        presence: DLAvatarPresence.defaultState,
        showPresence: false,
        initials: 'Aa',
      ),
      DynamicLayers.avatar(
        type: DLAvatarType.image,
        size: size,
        presence: DLAvatarPresence.defaultState,
        showPresence: false,
        imageProvider: memoji,
        borderColor: const Color(0xFFECE8FF),
        borderWidth: 2.0,
        backgroundColor: DLColors.violet50,
      ),
    ],
  ],
);
''';
