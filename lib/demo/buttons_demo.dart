import 'package:flutter/material.dart';

// Demo pages
import 'DemoButtonsCatalogPage.dart';
import 'buttons/demo_primary_button_page.dart';
import 'buttons/demo_secondary_button_page.dart';
import 'buttons/demo_ghost_button_page.dart';
import 'buttons/demo_tertiary_button_page.dart';

/// Simple hub screen to access all button demos, now using plain Flutter buttons.
class ButtonsDemoHome extends StatelessWidget {
  const ButtonsDemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = <_DemoTile>[
      _DemoTile(
        title: 'Primary Button Demo',
        subtitle: 'Sizes, states, icons, color overrides',
        builder: DemoPrimaryButtonPage.new,
      ),
      _DemoTile(
        title: 'Secondary Button Demo',
        subtitle: 'Neutral style with outline active state',
        builder: DemoSecondaryButtonPage.new,
      ),
      _DemoTile(
        title: 'Tertiary Button Demo',
        subtitle: 'Neutral style with outline active state',
        builder: DemoTertiaryButtonPage.new,
      ),
      _DemoTile(
        title: 'Ghost Button Demo',
        subtitle: 'Underline-only, transparent background',
        builder: DemoGhostButtonPage.new,
      ),
      _DemoTile(
        title: 'Buttons — Catalog',
        subtitle: 'Variants, sizes, disabled, icons',
        builder: DemoButtonsCatalogPage.new,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('DynamicLayers — Buttons Demos')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tiles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final t = tiles[i];
          return _NavBlock(
            title: t.title,
            subtitle: t.subtitle,
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => t.builder())),
          );
        },
      ),
    );
  }
}

class _NavBlock extends StatelessWidget {
  const _NavBlock({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: onTap, child: Text(title)),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoTile {
  const _DemoTile({
    required this.title,
    required this.subtitle,
    required this.builder,
  });

  final String title;
  final String subtitle;
  final Widget Function() builder;
}
