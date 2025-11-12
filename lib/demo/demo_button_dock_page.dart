// lib/demo/DemoButtonDockPage.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart'; // exposes DLButtonDock, DlButtonDock, tokens

class DemoButtonDockPage extends StatelessWidget {
  const DemoButtonDockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Dock — 3 Variants')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Section('1) 1 Button — Vertical (fills width)'),
          SizedBox(height: 8),
          _PreviewBox(child: _OneButtonVertical()),
          SizedBox(height: 24),

          _Section('2) 2 Buttons — Horizontal (split 50/50)'),
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

/// Variant 1: Single button, vertical (full width)
class _OneButtonVertical extends StatelessWidget {
  const _OneButtonVertical();

  @override
  Widget build(BuildContext context) {
    return DLButtonDock(
      buttons: [
        DlButtonDock(
          label: 'Button',
          type: DLButtonType.primary,
          onPressed: () {},
        ),
      ],
      direction: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      showSeparator: true,
    );
  }
}

/// Variant 2: Two buttons, horizontal (split 50/50)
class _TwoButtonsHorizontal extends StatelessWidget {
  const _TwoButtonsHorizontal();

  @override
  Widget build(BuildContext context) {
    return DLButtonDock(
      buttons: [
        DlButtonDock(
          label: 'Button',
          type: DLButtonType.secondary,
          onPressed: () {},
        ),
        DlButtonDock(
          label: 'Button',
          type: DLButtonType.primary,
          onPressed: () {},
        ),
      ],
      direction: Axis.horizontal,
      // Force equal width
      horizontalSplitEvenly: true, // <- ensures 50/50 (both Expanded)
      // keep default horizontalGap=16 from the dock, or set it explicitly:
      // horizontalGap: 16,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      showSeparator: true,
    );
  }
}

/// Variant 3: Two buttons, vertical (stacked full width)
class _TwoButtonsVertical extends StatelessWidget {
  const _TwoButtonsVertical();

  @override
  Widget build(BuildContext context) {
    return DLButtonDock(
      buttons: [
        DlButtonDock(
          label: 'Button',
          type: DLButtonType.primary,
          onPressed: () {},
        ),
        DlButtonDock(
          label: 'Button',
          type: DLButtonType.secondary,
          onPressed: () {},
        ),
      ],
      direction: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      showSeparator: true,
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
      child: Padding(padding: const EdgeInsets.all(12), child: child),
    );
  }
}
