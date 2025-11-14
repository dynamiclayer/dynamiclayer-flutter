import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';
import '../../generated/assets.dart';

class DemoBottomNavBarPage extends StatelessWidget {
  const DemoBottomNavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Navigation — Demo')),
      body: ListView(
        children: const [
          SizedBox(height: 16),
          _SectionLabel('Count = 2'),
          _BarPreview(count: 2),
          SizedBox(height: 32),

          _SectionLabel('Count = 3'),
          _BarPreview(count: 3),
          SizedBox(height: 32),

          _SectionLabel('Count = 4'),
          _BarPreview(count: 4),
          SizedBox(height: 32),

          _SectionLabel('Count = 5'),
          _BarPreview(count: 5),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(color: DLColors.grey700),
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

  ImageProvider get _icon => const AssetImage(Assets.iconLogo);

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
