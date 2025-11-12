// lib/demo/DemoSecondaryButtonPage.dart
import 'package:flutter/material.dart';
import '../../dynamiclayers.dart'; // or 'dynamiclayers.dart'

/// ----------------------------------------------------------------------------
/// DemoSecondaryButtonPage – Secondary Button Showcase
/// ----------------------------------------------------------------------------
/// Demonstrates:
/// 1) Sizes (xs, sm, md, lg) × states (Default, Pressed, Disabled)
///
/// Visual spec (secondary):
/// - default  : bg grey-100,  fg black,    no border
/// - pressed  : bg grey-300,  fg black,    no border
/// - disabled : bg grey-100,  fg grey-600, no border
///
/// Note: The demo forces `state:` on the button to preview each state.
/// ----------------------------------------------------------------------------
class DemoSecondaryButtonPage extends StatelessWidget {
  const DemoSecondaryButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DynamicLayers — Secondary Button Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _SectionTitle('1) Sizes × States'),
            SizedBox(height: 8),
            _SecondarySizesAndStatesGallery(),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1) Sizes × States
// -----------------------------------------------------------------------------
class _SecondarySizesAndStatesGallery extends StatelessWidget {
  const _SecondarySizesAndStatesGallery();

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
            return _SecondaryButtonTile(
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
    switch (s) {
      case DLButtonState.normal:
        return 'Default';
      case DLButtonState.pressed:
        return 'Pressed';
      case DLButtonState.disabled:
        return 'Disabled';
      // hover/active intentionally omitted
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

// Renders a Secondary DLButton with the desired forced state.
class _SecondaryButtonTile extends StatelessWidget {
  const _SecondaryButtonTile({
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
      type: DLButtonType.secondary,
      label: label,
      size: size,
      state: state, // force: default/pressed/disabled
      enabled: !isDisabled, // keeps semantics accurate
      onPressed: isDisabled ? null : () {},
    );
  }
}

// -----------------------------------------------------------------------------
// Shared small UI helpers (copied from your primary demo)
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
      color: DLColors.white,
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
