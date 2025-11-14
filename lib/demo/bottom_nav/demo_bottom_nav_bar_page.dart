import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';
import '../../generated/assets.dart';

class DemoBottomNavBarPage extends StatelessWidget {
  const DemoBottomNavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Navigation — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Count = 2'),
          SizedBox(height: 8),
          _PreviewBlock(child: _BarPreview(count: 2), code: _bottomNav2Code),
          SizedBox(height: 32),

          _SectionHeader('Count = 3'),
          SizedBox(height: 8),
          _PreviewBlock(child: _BarPreview(count: 3), code: _bottomNav3Code),
          SizedBox(height: 32),

          _SectionHeader('Count = 4'),
          SizedBox(height: 8),
          _PreviewBlock(child: _BarPreview(count: 4), code: _bottomNav4Code),
          SizedBox(height: 32),

          _SectionHeader('Count = 5'),
          SizedBox(height: 8),
          _PreviewBlock(child: _BarPreview(count: 5), code: _bottomNav5Code),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

/// A self-contained demo row that builds a DLBottomNavBar with [count] items
/// and allows tapping any tab to change the selected index.
class _BarPreview extends StatefulWidget {
  const _BarPreview({required this.count});
  final int count;

  @override
  State<_BarPreview> createState() => _BarPreviewState();
}

class _BarPreviewState extends State<_BarPreview> {
  // each preview row maintains its own selection
  int _selectedIndex = 0;

  DLBottomNavTab _tab({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return DLBottomNavTab(
      label: label,
      showLabel: true,
      selected: selected,
      badge: DLBnavBadge.none,
      onTap: onTap, // <-- enables tap
      // keep original icon colors (unselected dim via opacity)
      // iconStyle: DLBnavIconStyle.tint, // <- use if you want mono tint
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = List<Widget>.generate(widget.count, (i) {
      return _tab(
        label: 'Label',
        selected: i == _selectedIndex,
        onTap: () => setState(() => _selectedIndex = i),
      );
    });

    return DLBottomNavigation(
      items: items,
      showSeparator: true,
      elevation: 0,
      backgroundColor: DLColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
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
const _bottomNav2Code = '''
// Bottom navigation with 2 items
class TwoItemBottomNavPreview extends StatefulWidget {
  const TwoItemBottomNavPreview({super.key});

  @override
  State<TwoItemBottomNavPreview> createState() =>
      _TwoItemBottomNavPreviewState();
}

class _TwoItemBottomNavPreviewState extends State<TwoItemBottomNavPreview> {
  int _selectedIndex = 0;

  DLBottomNavTab _tab({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return DLBottomNavTab(
      label: label,
      showLabel: true,
      selected: selected,
      badge: DLBnavBadge.none,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _tab(
        label: 'Label',
        selected: _selectedIndex == 0,
        onTap: () => setState(() => _selectedIndex = 0),
      ),
      _tab(
        label: 'Label',
        selected: _selectedIndex == 1,
        onTap: () => setState(() => _selectedIndex = 1),
      ),
    ];

    return DLBottomNavigation(
      items: items,
      showSeparator: true,
      elevation: 0,
      backgroundColor: DLColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}
''';

const _bottomNav3Code = '''
// Bottom navigation with 3 items
DLBottomNavigation(
  items: List<Widget>.generate(3, (index) {
    final selected = index == 0; // e.g. first selected
    return DLBottomNavTab(
      label: 'Label',
      showLabel: true,
      selected: selected,
      badge: DLBnavBadge.none,
      onTap: () {
        // setState to update index in a StatefulWidget
      },
    );
  }),
  showSeparator: true,
  elevation: 0,
  backgroundColor: DLColors.white,
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
);
''';

const _bottomNav4Code = '''
// Bottom navigation with 4 items
DLBottomNavigation(
  items: List<Widget>.generate(4, (index) {
    return DLBottomNavTab(
      label: 'Label',
      showLabel: true,
      selected: index == 0,
      badge: DLBnavBadge.none,
      onTap: () {
        // handle tap
      },
    );
  }),
  showSeparator: true,
  elevation: 0,
  backgroundColor: DLColors.white,
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
);
''';

const _bottomNav5Code = '''
// Bottom navigation with 5 items
DLBottomNavigation(
  items: List<Widget>.generate(5, (index) {
    return DLBottomNavTab(
      label: 'Label',
      showLabel: true,
      selected: index == 0,
      badge: DLBnavBadge.none,
      onTap: () {
        // handle tap
      },
    );
  }),
  showSeparator: true,
  elevation: 0,
  backgroundColor: DLColors.white,
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
);
''';
