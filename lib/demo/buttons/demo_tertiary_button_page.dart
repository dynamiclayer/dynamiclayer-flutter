import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';

/// ----------------------------------------------------------------------------
/// DemoTertiaryButtonPage – Tertiary Button Showcase
/// ----------------------------------------------------------------------------
/// Demonstrates:
/// 1) Sizes (xs, sm, md, lg) × states (normal, hover, pressed, disabled, active)
/// 2) Icons (left / right / both)
/// 3) Custom overrides (bg/fg/border)
///
/// Default tertiary spec (from component):
/// - normal   : bg white,     fg black,   border grey-200 (1.0)
/// - hover    : bg grey-50,   fg black,   border grey-200 (1.0)
/// - pressed  : bg grey-200,  fg black,   border grey-200 (1.0)
/// - disabled : bg white,     fg grey-600,border grey-100 (1.0)
/// - active   : bg white,     fg black,   border black (1.5)
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
          children: const [
            _SectionTitle('1) Sizes × States'),
            SizedBox(height: 8),
            _TertiarySizesAndStatesGallery(),

            SizedBox(height: 24),
            _SectionTitle('2) Icons (Left / Right / Both)'),
            SizedBox(height: 8),
            _TertiaryIconsGallery(),

            SizedBox(height: 24),
            _SectionTitle('3) Custom Overrides (bg/fg/border)'),
            SizedBox(height: 8),
            _TertiaryColorsGallery(),
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
            return DynamicLayers.buttons.tertiary(
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
class _TertiaryIconsGallery extends StatelessWidget {
  const _TertiaryIconsGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GalleryRow(
          title: 'Icons — Left',
          children: [
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Add file',
              size: DLButtonSize.md,
              iconLeft: const Icon(Icons.add),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Add file (hover)',
              size: DLButtonSize.md,
              state: DLButtonState.hover,
              iconLeft: const Icon(Icons.add),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Add file (disabled)',
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
              type: DLButtonType.tertiary,
              label: 'Next step',
              size: DLButtonSize.md,
              iconRight: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Next step (hover)',
              size: DLButtonSize.md,
              state: DLButtonState.hover,
              iconRight: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Next step (disabled)',
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
              type: DLButtonType.tertiary,
              label: 'Upload & confirm',
              size: DLButtonSize.md,
              iconLeft: const Icon(Icons.upload),
              iconRight: const Icon(Icons.check),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Upload & confirm (hover)',
              size: DLButtonSize.md,
              state: DLButtonState.hover,
              iconLeft: const Icon(Icons.upload),
              iconRight: const Icon(Icons.check),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Upload & confirm (disabled)',
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
// 3) Custom Overrides Gallery
// -----------------------------------------------------------------------------
class _TertiaryColorsGallery extends StatelessWidget {
  const _TertiaryColorsGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GalleryRow(
          title: 'Neutral tweaks',
          children: [
            // Softer border
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Soft border',
              size: DLButtonSize.md,
              borderColor: const Color(0xFFEAEAEA),
              onPressed: () {},
            ),
            // Stronger border
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Strong border',
              size: DLButtonSize.md,
              borderColor: Colors.black,
              borderWidth: 1.5,
              onPressed: () {},
            ),
            // Light grey background with dark text
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Light bg',
              size: DLButtonSize.md,
              backgroundColor: const Color(0xFFF6F6F6),
              onPressed: () {},
            ),
          ],
        ),
        _GalleryRow(
          title: 'Custom fg/bg',
          children: [
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Blue outline',
              size: DLButtonSize.md,
              state: DLButtonState.active,
              borderColor: Colors.blue,
              borderWidth: 1.5,
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Green text',
              size: DLButtonSize.md,
              foregroundColor: Colors.green.shade800,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Small layout helpers (same as your other demo pages)
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
