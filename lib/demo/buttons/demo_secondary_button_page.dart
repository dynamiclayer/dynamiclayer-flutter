import 'package:flutter/material.dart';

import '../../dynamiclayers.dart'; // or 'dynamiclayers.dart'

/// ----------------------------------------------------------------------------
/// DemoSecondaryButtonPage – Secondary Button Showcase
/// ----------------------------------------------------------------------------
/// Demonstrates:
/// 1) Sizes (xs, sm, md, lg) × states (normal, hover, pressed, disabled, active)
/// 2) Icons (left / right / both)
/// 3) Custom color overrides (bg/fg/border)
///
/// Visual spec (default secondary):
/// - normal   : bg grey-100,  fg black,   no border
/// - hover    : bg grey-200,  fg black,   no border
/// - pressed  : bg grey-300,  fg black,   no border
/// - disabled : bg grey-100,  fg grey-600,no border
/// - active   : bg white,     fg black,   1px black border
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

            SizedBox(height: 24),
            _SectionTitle('2) Icons (Left / Right / Both)'),
            SizedBox(height: 8),
            _SecondaryIconsGallery(),

            SizedBox(height: 24),
            _SectionTitle('3) Custom Colors (per-call overrides)'),
            SizedBox(height: 8),
            _SecondaryColorsGallery(),
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
            return DynamicLayers.buttons.secondary(
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
// 2) Icons Gallery
// -----------------------------------------------------------------------------
class _SecondaryIconsGallery extends StatelessWidget {
  const _SecondaryIconsGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GalleryRow(
          title: 'Icons — Left',
          children: [
            DLButton(
              type: DLButtonType.secondary,
              label: 'Add',
              size: DLButtonSize.md,
              iconLeft: const Icon(Icons.add),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.secondary,
              label: 'Add (hover)',
              size: DLButtonSize.md,
              state: DLButtonState.hover,
              iconLeft: const Icon(Icons.add),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.secondary,
              label: 'Add (disabled)',
              size: DLButtonSize.md,
              state: DLButtonState.disabled,
              iconLeft: const Icon(Icons.add),
            ),
          ],
        ),
        _GalleryRow(
          title: 'Icons — Right',
          children: [
            DLButton(
              type: DLButtonType.secondary,
              label: 'Next',
              size: DLButtonSize.md,
              iconRight: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.secondary,
              label: 'Next (hover)',
              size: DLButtonSize.md,
              state: DLButtonState.hover,
              iconRight: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.secondary,
              label: 'Next (disabled)',
              size: DLButtonSize.md,
              state: DLButtonState.disabled,
              iconRight: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        _GalleryRow(
          title: 'Icons — Both',
          children: [
            DLButton(
              type: DLButtonType.secondary,
              label: 'Upload',
              size: DLButtonSize.md,
              iconLeft: const Icon(Icons.upload),
              iconRight: const Icon(Icons.check),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.secondary,
              label: 'Upload (hover)',
              size: DLButtonSize.md,
              state: DLButtonState.hover,
              iconLeft: const Icon(Icons.upload),
              iconRight: const Icon(Icons.check),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.secondary,
              label: 'Upload (disabled)',
              size: DLButtonSize.md,
              state: DLButtonState.disabled,
              iconLeft: const Icon(Icons.upload),
              iconRight: const Icon(Icons.check),
            ),
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 3) Color Overrides Gallery
// -----------------------------------------------------------------------------
class _SecondaryColorsGallery extends StatelessWidget {
  const _SecondaryColorsGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GalleryRow(
          title: 'Neutral overrides',
          children: [
            // Slightly darker neutral
            DLButton(
              type: DLButtonType.secondary,
              label: 'Neutral Darker',
              size: DLButtonSize.md,
              backgroundColor: const Color(0xFFE2E2E2), // grey-200
              onPressed: () {},
            ),
            // Lightest neutral with dark text
            DLButton(
              type: DLButtonType.secondary,
              label: 'Neutral Light',
              size: DLButtonSize.md,
              backgroundColor: const Color(0xFFF6F6F6), // grey-50
              foregroundColor: Colors.black,
              onPressed: () {},
            ),
            // Active outline variant via overrides if needed
            DLButton(
              type: DLButtonType.secondary,
              label: 'Outline',
              size: DLButtonSize.md,
              state: DLButtonState.active, // shows default black outline
              onPressed: () {},
            ),
          ],
        ),
        _GalleryRow(
          title: 'Custom borders',
          children: [
            DLButton(
              type: DLButtonType.secondary,
              label: 'Blue outline',
              size: DLButtonSize.md,
              state: DLButtonState.active,
              borderColor: Colors.blue,
              borderWidth: 1.5,
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.secondary,
              label: 'Red outline',
              size: DLButtonSize.md,
              state: DLButtonState.active,
              borderColor: Colors.red,
              borderWidth: 2,
              onPressed: () {},
            ),
          ],
        ),
      ],
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
