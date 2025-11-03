import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

/// Demo page showing 3 Button Dock variants:
/// 1) 1 button, vertical (button fills the provided space)
/// 2) 2 buttons, horizontal (each takes half width with space between)
/// 3) 2 buttons, vertical (stacked full width)
class DemoButtonDockPage extends StatelessWidget {
  const DemoButtonDockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Dock — 3 Variants')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Section('1) 1 Button — Vertical (fills provided space)'),
          SizedBox(height: 8),
          _PreviewBox(child: _OneButtonVertical()),
          SizedBox(height: 24),

          _Section('2) 2 Buttons — Horizontal (split, space between)'),
          SizedBox(height: 8),
          _PreviewBox(child: _TwoButtonsHorizontal()),
          SizedBox(height: 24),

          _Section('3) 2 Buttons — Vertical (stacked full width)'),
          SizedBox(height: 8),
          _PreviewBox(child: _TwoButtonsVertical()),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Variant 1: 1 button, vertical. The single button fills the available area.
/// ---------------------------------------------------------------------------
class _OneButtonVertical extends StatelessWidget {
  const _OneButtonVertical();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 122,
      child: DynamicLayers.dock(
        buttons: [
          DLDockButton(
            label: 'Button',
            type: DLButtonType.primary,

            width: double.infinity,
            onPressed: () {},
          ),
        ],
        direction: Axis.vertical, // single button vertically
        showHomeIndicator: true,
        showSeparator: true,
        width: 375,
        height: 122,
        gap: 0,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Variant 2: 2 buttons, horizontal. Each takes half space with a gap.
/// ---------------------------------------------------------------------------
class _TwoButtonsHorizontal extends StatelessWidget {
  const _TwoButtonsHorizontal();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 122,
      child: DynamicLayers.dock(
        buttons: [
          DLDockButton(
            label: 'Button',
            type: DLButtonType.secondary,
            onPressed: () {},
          ),
          DLDockButton(
            label: 'Button',
            type: DLButtonType.primary,
            onPressed: () {},
          ),
        ],
        direction: Axis.horizontal, // split equally
        showHomeIndicator: true,
        showSeparator: true,
        width: 375,
        height: 122,
        gap: 12, // space between the two buttons
        padding: EdgeInsets.zero,
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Variant 3: 2 buttons, vertical full-width stacked.
/// ---------------------------------------------------------------------------
class _TwoButtonsVertical extends StatelessWidget {
  const _TwoButtonsVertical();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 122 * 2 / 1.4, // a bit taller to show two stacked buttons nicely
      child: DynamicLayers.dock(
        buttons: [
          DLDockButton(
            label: 'Button',
            type: DLButtonType.primary,
            width: double.infinity,
            onPressed: () {},
          ),
          DLDockButton(
            label: 'Button',
            type: DLButtonType.secondary,
            width: double.infinity,
            onPressed: () {},
          ),
        ],
        direction: Axis.vertical, // stacked one above the other
        showHomeIndicator: true,
        showSeparator: true,

        width: 375,
        height: 122 * 2 / 1.4,
        gap: 12, // vertical spacing between the stacked buttons
        padding: EdgeInsets.all(10),
      ),
    );
  }
}

/// ---------- UI helpers ----------
class _Section extends StatelessWidget {
  const _Section(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _PreviewBox extends StatelessWidget {
  const _PreviewBox({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}
