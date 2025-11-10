import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../generated/assets.dart';

class DemoAvatarPage extends StatelessWidget {
  const DemoAvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avatars — Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ONLINE — green dot
          const _Section('Online'),
          _Grid(
            _variants(presence: DLAvatarPresence.online, showPresence: true),
          ),

          const SizedBox(height: 24),

          // OFFLINE — grey dot
          const _Section('Offline'),
          _Grid(
            _variants(presence: DLAvatarPresence.offline, showPresence: true),
          ),

          const SizedBox(height: 24),

          // DEFAULT — no dot
          const _Section('Default (no badge)'),
          _Grid(
            _variants(
              presence: DLAvatarPresence.defaultState,
              showPresence: false,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _variants({
    required DLAvatarPresence presence,
    required bool showPresence,
  }) {
    final memoji = const AssetImage(Assets.avatarAvatar);

    Widget tile(String label, Widget child) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 8),
        Text(label, style: DLTypos.textXsRegular(color: DLColors.grey600)),
      ],
    );

    List<Widget> items = [];

    for (final size in DLAvatarSize.values) {
      items.addAll([
        // Type: icon
        tile(
          'icon · ${_s(size)}',
          DynamicLayers.avatar(
            type: DLAvatarType.icon,
            size: size,
            presence: presence,
            showPresence: showPresence,
          ),
        ),

        // Type: initials
        tile(
          'initials · ${_s(size)}',
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
          'image · ${_s(size)}',
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
    return items;
  }

  String _s(DLAvatarSize s) => switch (s) {
    DLAvatarSize.lg => 'lg',
    DLAvatarSize.md => 'md',
    DLAvatarSize.sm => 'sm',
    DLAvatarSize.xs => 'xs',
    DLAvatarSize.xxs => 'xxs',
  };
}

class _Grid extends StatelessWidget {
  const _Grid(this.children);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(label, style: DLTypos.textBaseBold(color: DLColors.grey800)),
    );
  }
}
