import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../generated/assets.dart';

class DemoAvatarGroupPage extends StatelessWidget {
  const DemoAvatarGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final img1 = const AssetImage(Assets.iconMemoji);
    final img2 = const AssetImage(Assets.iconMemoji);

    return Scaffold(
      appBar: AppBar(title: const Text('Avatar Group — Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Large (lg)
          _Section('Large (lg)'),
          _RowWrap(
            children: [
              _tile(
                'image',
                _duoImage(size: DLAvatarSize.lg, img1: img1, img2: img2),
              ),
              _tile('initials', _duoInitials(size: DLAvatarSize.lg)),
              _tile('icon', _duoIcon(size: DLAvatarSize.lg)),
              _tile(
                'imageInitials',
                _imageInitials(size: DLAvatarSize.lg, img: img1),
              ),
              _tile(
                'image + 2',
                _withCounter(
                  size: DLAvatarSize.lg,
                  leading: _img(img1, DLAvatarSize.lg),
                  count: 2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ── Extra Small (xs)
          _Section('Extra Small (xs)'),
          _RowWrap(
            children: [
              _tile(
                'image',
                _duoImage(size: DLAvatarSize.xs, img1: img1, img2: img2),
              ),
              _tile('initials', _duoInitials(size: DLAvatarSize.xs)),
              _tile('icon', _duoIcon(size: DLAvatarSize.xs)),
              _tile(
                'imageInitials',
                _imageInitials(size: DLAvatarSize.xs, img: img1),
              ),
              _tile(
                'image + 2',
                _withCounter(
                  size: DLAvatarSize.xs,
                  leading: _img(img1, DLAvatarSize.xs),
                  count: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- tiles & layout --------------------------------------------------------
  Widget _tile(String label, Widget child) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      child,
      const SizedBox(height: 8),
      Text(label, style: DLTypos.textXsRegular(color: DLColors.grey600)),
    ],
  );

  // --- builders --------------------------------------------------------------
  Widget _duoImage({
    required DLAvatarSize size,
    required ImageProvider img1,
    required ImageProvider img2,
  }) {
    return DynamicLayers.avatarGroup(
      size: size,
      items: [
        DLAvatarItem.image(
          img1,
          backgroundColor: DLColors.violet50,
          borderColor: const Color(0xFFECE8FF),
          borderWidth: 2,
        ),
        DLAvatarItem.image(
          img2,
          backgroundColor: const Color(0xFFE6F6FF), // light blue
          borderColor: const Color(0xFFE6F6FF),
          borderWidth: 2,
        ),
      ],
      ringColor: const Color(0xFFECE8FF),
      overlapFraction: 0.6,
    );
  }

  Widget _duoInitials({required DLAvatarSize size}) {
    return DynamicLayers.avatarGroup(
      size: size,
      items: [DLAvatarItem.initials('A'), DLAvatarItem.initials('Aa')],
      overlapFraction: 0.60,
    );
  }

  Widget _duoIcon({required DLAvatarSize size}) {
    return DynamicLayers.avatarGroup(
      size: size,
      items: [DLAvatarItem.icon(), DLAvatarItem.icon()],
      overlapFraction: 0.6,
    );
  }

  Widget _imageInitials({
    required DLAvatarSize size,
    required ImageProvider img,
  }) {
    return DynamicLayers.avatarGroup(
      size: size,
      items: [
        DLAvatarItem.image(
          img,
          backgroundColor: DLColors.violet50,
          borderColor: const Color(0xFFECE8FF),
          borderWidth: 2,
        ),
        DLAvatarItem.initials('Aa'),
      ],
      overlapFraction: 0.6,
    );
  }

  Widget _withCounter({
    required DLAvatarSize size,
    required Widget leading,
    required int count,
  }) {
    return DynamicLayers.avatarGroup(
      size: size,
      items: [
        DLAvatarItem.image(
          (leading as DLAvatar).imageProvider!,
          backgroundColor: DLColors.violet50,
          borderColor: const Color(0xFFECE8FF),
          borderWidth: 2,
        ),
      ],
      maxVisible: 2,
      showCounterBubble: true,
      overflowCount: count,
      overlapFraction: 0.60,
    );
  }

  static DLAvatar _img(ImageProvider img, DLAvatarSize size) =>
      DLAvatar(type: DLAvatarType.image, size: size, imageProvider: img);
}

class _RowWrap extends StatelessWidget {
  const _RowWrap({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 28,
      runSpacing: 28,
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
