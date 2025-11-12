// lib/demo/DemoPrimaryButtonPage.dart
import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';

/// ----------------------------------------------------------------------------
/// DemoPage – Primary Button Showcase
/// ----------------------------------------------------------------------------
/// Shows sizes (xs, sm, md, lg) across core states:
///   • Default (normal)  • Pressed  • Disabled
/// Note: hover/active are intentionally omitted.
/// ----------------------------------------------------------------------------
class DemoPrimaryButtonPage extends StatelessWidget {
  const DemoPrimaryButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(title: const Text('DynamicLayers — Primary Button Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle('1) Sizes × States', textStyle: textStyle),
            const SizedBox(height: 8),
            const _SizesAndStatesGallery(),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1) Sizes × States
// -----------------------------------------------------------------------------
class _SizesAndStatesGallery extends StatelessWidget {
  const _SizesAndStatesGallery();

  // Only the three requested states.
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
            return _PrimaryButtonTile(
              label: _stateLabel(st),
              size: row.size,
              state: st,
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  String _stateLabel(DLButtonState s) {
    if (s == DLButtonState.normal) return 'Default';
    if (s == DLButtonState.pressed) return 'Pressed';
    if (s == DLButtonState.disabled) return 'Disabled';
    return '';
  }
}

class _SizeRow {
  const _SizeRow({required this.size, required this.label});
  final DLButtonSize size;
  final String label;
}

// A small wrapper that renders a Primary DLButton with the desired state.
class _PrimaryButtonTile extends StatelessWidget {
  const _PrimaryButtonTile({
    required this.label,
    required this.size,
    required this.state,
  });

  final String label;
  final DLButtonSize size;
  final DLButtonState state;

  @override
  Widget build(BuildContext context) {
    final isDisabled = state == DLButtonState.disabled;

    return DLButton(
      type: DLButtonType.primary,
      label: label,
      size: size,
      state: state, // forced state for the showcase
      enabled: !isDisabled,
      onPressed: isDisabled ? null : () {},
    );
  }
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
    return Text(text, style: textStyle?.copyWith(fontWeight: FontWeight.w700));
  }
}

class _GalleryRow extends StatelessWidget {
  const _GalleryRow({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DLColors.white,
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
                    (w) => const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: SizedBox.shrink(),
                    ),
                  )
                  .toList(),
            ),
            Wrap(spacing: 10, runSpacing: 10, children: children),
          ],
        ),
      ),
    );
  }
}
