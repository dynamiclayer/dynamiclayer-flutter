import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';

/// ----------------------------------------------------------------------------
/// DemoGhostButtonPage – Ghost Button Showcase
/// ----------------------------------------------------------------------------
/// Demonstrates:
/// 1) Sizes (xs, sm, md, lg) × states (normal, hover, pressed, disabled, active)
///
/// Default ghost spec (from component):
/// - transparent bg
/// - underlined text (always visible)
/// - disabled: grey500 text + lighter underline
/// - active: bolder text + thicker underline
class DemoGhostButtonPage extends StatelessWidget {
  const DemoGhostButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DynamicLayers — Ghost Button Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SectionTitle('1) Sizes × States'),
            SizedBox(height: 8),
            _GhostSizesAndStatesGallery(),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1) Sizes × States
// -----------------------------------------------------------------------------
class _GhostSizesAndStatesGallery extends StatelessWidget {
  const _GhostSizesAndStatesGallery();

  final List<DLButtonState> _states = const [
    DLButtonState.normal,
    DLButtonState.hover,
    DLButtonState.pressed,
    DLButtonState.disabled,
    DLButtonState.active,
  ];

  final List<_SizeRow> _sizeRows = const [
    _SizeRow(size: DLButtonSize.lg, label: 'Size lg'),
    _SizeRow(size: DLButtonSize.md, label: 'Size md'),
    _SizeRow(size: DLButtonSize.sm, label: 'Size sm'),
    _SizeRow(size: DLButtonSize.xs, label: 'Size xs'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _sizeRows.map((row) {
        return _GalleryRow(
          title: row.label,
          children: _states.map((st) {
            return DynamicLayers.buttons.ghost(
              label: _stateLabel(st),
              size: row.size,
              state: st,
              onPressed: st == DLButtonState.disabled ? null : () {},
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  String _stateLabel(DLButtonState s) {
    switch (s) {
      case DLButtonState.normal:
        return 'Default';
      case DLButtonState.hover:
        return 'Hover';
      case DLButtonState.pressed:
        return 'Pressed';
      case DLButtonState.disabled:
        return 'Disabled';
      case DLButtonState.active:
        return 'Active';
    }
  }
}

class _SizeRow {
  const _SizeRow({required this.size, required this.label});
  final DLButtonSize size;
  final String label;
}

// -----------------------------------------------------------------------------
// Small layout helpers (shared style with other demo pages)
// -----------------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {this.textStyle});
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}

class _GalleryRow extends StatelessWidget {
  const _GalleryRow({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black.withOpacity(0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0.7,
              child: Text(title, style: Theme.of(context).textTheme.labelLarge),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: children
                  .map(
                    (w) =>
                        Padding(padding: const EdgeInsets.all(4.0), child: w),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
