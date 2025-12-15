import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';

class DemoBottomNavTabPage extends StatelessWidget {
  const DemoBottomNavTabPage({super.key});

  Widget _tile({
    required bool showLabel,
    required bool selected,
    required DLBnavBadge badge,
    int badgeCount = 1,
  }) {
    return SizedBox(
      width: 160,
      height: 84, // stable height for icon + optional label + spacing
      child: Center(
        child: DLBottomNavTab(
          label: 'Label',
          showLabel: showLabel,
          selected: selected,
          badge: badge,
          badgeCount: badgeCount,
          selectedColor: DLColors.black,
          unselectedColor: DLColors.grey400,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      // Label=true, Selected=true
      _tile(showLabel: true, selected: true, badge: DLBnavBadge.none),
      _tile(showLabel: true, selected: true, badge: DLBnavBadge.sm),
      _tile(
        showLabel: true,
        selected: true,
        badge: DLBnavBadge.md,
        badgeCount: 1,
      ),

      // Label=false, Selected=true
      _tile(showLabel: false, selected: true, badge: DLBnavBadge.none),
      _tile(showLabel: false, selected: true, badge: DLBnavBadge.sm),
      _tile(
        showLabel: false,
        selected: true,
        badge: DLBnavBadge.md,
        badgeCount: 1,
      ),

      // Label=true, Selected=false
      _tile(showLabel: true, selected: false, badge: DLBnavBadge.none),
      _tile(showLabel: true, selected: false, badge: DLBnavBadge.sm),
      _tile(
        showLabel: true,
        selected: false,
        badge: DLBnavBadge.md,
        badgeCount: 1,
      ),

      // Label=false, Selected=false
      _tile(showLabel: false, selected: false, badge: DLBnavBadge.none),
      _tile(showLabel: false, selected: false, badge: DLBnavBadge.sm),
      _tile(
        showLabel: false,
        selected: false,
        badge: DLBnavBadge.md,
        badgeCount: 1,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Nav Tab — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionHeader('Combinations: label × selected × badge'),
          const SizedBox(height: 8),
          _PreviewBlock(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Wrap(
                  spacing: 48,
                  runSpacing: 48,
                  alignment: WrapAlignment.center,
                  children: items,
                ),
              ),
            ),
            code: _bottomNavTabCode,
          ),
        ],
      ),
    );
  }
}

/// ---------- DOC UI helpers ----------
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
          child: child,
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

const _bottomNavTabCode = '''
// Basic DLBottomNavTab usage with variations

DLBottomNavTab(
  label: 'Label',
  showLabel: true,
  selected: true,
  badge: DLBnavBadge.none,
);

DLBottomNavTab(
  label: 'Label',
  showLabel: true,
  selected: true,
  badge: DLBnavBadge.sm,
);

DLBottomNavTab(
  label: 'Label',
  showLabel: true,
  selected: true,
  badge: DLBnavBadge.md,
  badgeCount: 1,
);

DLBottomNavTab(
  label: 'Label',
  showLabel: false,
  selected: false,
  badge: DLBnavBadge.sm,
);

DLBottomNavTab(
  label: 'Label',
  showLabel: false,
  selected: false,
  badge: DLBnavBadge.md,
  badgeCount: 1,
);
''';
