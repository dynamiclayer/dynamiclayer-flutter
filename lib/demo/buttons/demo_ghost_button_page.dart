import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';

/// ----------------------------------------------------------------------------
/// DemoGhostButtonPage – Ghost Button Showcase
/// ----------------------------------------------------------------------------
/// Demonstrates:
/// 1) Sizes (xs, sm, md, lg) × states (normal, hover, pressed, disabled, active)
/// 2) Icons (left / right / both)
/// 3) Custom overrides (underline color/thickness + foreground)
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

            SizedBox(height: 24),
            _SectionTitle('2) Icons (Left / Right / Both)'),
            SizedBox(height: 8),
            _GhostIconsGallery(),

            SizedBox(height: 24),
            _SectionTitle('3) Custom Overrides'),
            SizedBox(height: 8),
            _GhostCustomsGallery(),
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
// 2) Icons Gallery
// -----------------------------------------------------------------------------
class _GhostIconsGallery extends StatelessWidget {
  const _GhostIconsGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GalleryRow(
          title: 'Icons — Left',
          children: [
            DLButton(
              type: DLButtonType.ghost,
              label: 'Add item',
              size: DLButtonSize.md,
              iconLeft: const Icon(Icons.add),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.ghost,
              label: 'Add item (hover)',
              size: DLButtonSize.md,
              state: DLButtonState.hover,
              iconLeft: const Icon(Icons.add),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.ghost,
              label: 'Add item (disabled)',
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
              type: DLButtonType.ghost,
              label: 'Next step',
              size: DLButtonSize.md,
              iconRight: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.ghost,
              label: 'Next step (hover)',
              size: DLButtonSize.md,
              state: DLButtonState.hover,
              iconRight: const Icon(Icons.chevron_right),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.ghost,
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
              type: DLButtonType.ghost,
              label: 'Upload & confirm',
              size: DLButtonSize.md,
              iconLeft: const Icon(Icons.upload),
              iconRight: const Icon(Icons.check),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.ghost,
              label: 'Upload & confirm (hover)',
              size: DLButtonSize.md,
              state: DLButtonState.hover,
              iconLeft: const Icon(Icons.upload),
              iconRight: const Icon(Icons.check),
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.ghost,
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
class _GhostCustomsGallery extends StatelessWidget {
  const _GhostCustomsGallery();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GalleryRow(
          title: 'Underline customization',
          children: [
            DLButton(
              type: DLButtonType.ghost,
              label: 'Thicker line',
              size: DLButtonSize.md,
              underlineThickness: 2.0,
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.ghost,
              label: 'Blue underline',
              size: DLButtonSize.md,
              underlineColor: Colors.blue,
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.ghost,
              label: 'Green text',
              size: DLButtonSize.md,
              foregroundColor: Colors.green.shade800,
              onPressed: () {},
            ),
          ],
        ),
        _GalleryRow(
          title: 'Sizing & fixed width',
          children: [
            DLButton(
              type: DLButtonType.ghost,
              label: 'Fixed 140px',
              size: DLButtonSize.md,
              width: 140,
              height: 40,
              // keeps width fixed (instead of minWidth behavior)
              // note: pass fixedWidth: true in your ghost factory if supported; otherwise remove this example
              // fixedWidth: true,
              onPressed: () {},
            ),
            DLButton(
              type: DLButtonType.ghost,
              label: 'Compact (xs)',
              size: DLButtonSize.xs,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
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
