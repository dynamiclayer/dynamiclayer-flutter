// lib/demo/buttons/demo_tertiary_button_page.dart
import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';

/// ----------------------------------------------------------------------------
/// DemoTertiaryButtonPage – Tertiary Button Showcase
/// ----------------------------------------------------------------------------
/// Shows sizes (xs, sm, md, lg) across core states:
///   • Default (normal)  • Pressed  • Disabled
/// Note: hover/active are intentionally omitted in this demo.
/// ----------------------------------------------------------------------------
class DemoTertiaryButtonPage extends StatelessWidget {
  const DemoTertiaryButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(title: const Text('DynamicLayers — Tertiary Button Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle('1) Sizes × States', textStyle: textStyle),
            const SizedBox(height: 8),
            const _TertiarySizesAndStatesGallery(),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1) Sizes × States
// -----------------------------------------------------------------------------
class _TertiarySizesAndStatesGallery extends StatelessWidget {
  const _TertiarySizesAndStatesGallery();

  // Only show Default, Pressed, Disabled
  final List<DLButtonState> _states = const [
    DLButtonState.normal,
    DLButtonState.pressed,
    DLButtonState.disabled,
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
            return DLButton(
              type: DLButtonType.tertiary,
              label: _stateLabel(st),
              size: row.size,
              state: st,
              enabled: st != DLButtonState.disabled,
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
      case DLButtonState.pressed:
        return 'Pressed';
      case DLButtonState.disabled:
        return 'Disabled';
      // intentionally omitted:
      case DLButtonState.hover:
      case DLButtonState.active:
        return '';
    }
  }
}

class _SizeRow {
  const _SizeRow({required this.size, required this.label});
  final DLButtonSize size;
  final String label;
}

// -----------------------------------------------------------------------------
// Small layout helpers
// -----------------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {this.textStyle});
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: (textStyle ?? Theme.of(context).textTheme.titleMedium)?.copyWith(
        fontWeight: FontWeight.w700,
      ),
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
      color: DLColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black.withOpacity(0.08)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // keep left-aligned
          children: [
            Opacity(
              opacity: 0.7,
              child: Text(title, style: Theme.of(context).textTheme.labelLarge),
            ),
            const SizedBox(height: 10),
            // single Wrap (removed the placeholder/duplicate one)
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
