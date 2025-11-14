// lib/demo/DemoButtonDockPage.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart'; // exposes DLButtonDock, DLButton, tokens

class DemoButtonDockPage extends StatelessWidget {
  const DemoButtonDockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Dock — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('1) 1 Button — Vertical (fills width)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _OneButtonVertical(),
            code: _oneButtonVerticalCode,
          ),
          SizedBox(height: 24),

          _SectionHeader('2) 2 Buttons — Horizontal (split 50/50)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _TwoButtonsHorizontal(),
            code: _twoButtonsHorizontalCode,
          ),
          SizedBox(height: 24),

          _SectionHeader('3) 2 Buttons — Vertical (stacked full width)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _TwoButtonsVertical(),
            code: _twoButtonsVerticalCode,
          ),
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
        DLButton(label: 'Button', type: DLButtonType.primary, onPressed: () {}),
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
        DLButton(
          label: 'Button',
          type: DLButtonType.secondary,
          onPressed: () {},
        ),
        DLButton(label: 'Button', type: DLButtonType.primary, onPressed: () {}),
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
        DLButton(label: 'Button', type: DLButtonType.primary, onPressed: () {}),
        DLButton(
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

/// ---------- DOC UI helpers (same pattern as DemoButtonsCatalogPage) ----------
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _PreviewBlock extends StatelessWidget {
  const _PreviewBlock({required this.child, required this.code});
  final Widget child;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SubHeader('Preview'),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: _surface(context),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 740),
              child: child,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _SubHeader('Code'),
        const SizedBox(height: 8),
        _CodeBox(code: code),
      ],
    );
  }

  BoxDecoration _surface(BuildContext context) => BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    border: Border.all(color: Colors.black12),
    borderRadius: BorderRadius.circular(12),
  );
}

class _SubHeader extends StatelessWidget {
  const _SubHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).colorScheme.surfaceVariant;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
      ),
    );
  }
}

/// ---------- Code Samples ----------
const _oneButtonVerticalCode = '''
// 1) 1 Button — Vertical (fills width)
DLButtonDock(
  buttons: [
    DLButton(
      label: 'Button',
      type: DLButtonType.primary,
      onPressed: () {},
    ),
  ],
  direction: Axis.vertical,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  showSeparator: true,
);
''';

const _twoButtonsHorizontalCode = '''
// 2) 2 Buttons — Horizontal (split 50/50)
DLButtonDock(
  buttons: [
    DLButton(
      label: 'Button',
      type: DLButtonType.secondary,
      onPressed: () {},
    ),
    DLButton(
      label: 'Button',
      type: DLButtonType.primary,
      onPressed: () {},
    ),
  ],
  direction: Axis.horizontal,
  horizontalSplitEvenly: true, // ensures 50/50 split
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  showSeparator: true,
);
''';

const _twoButtonsVerticalCode = '''
// 3) 2 Buttons — Vertical (stacked full width)
DLButtonDock(
  buttons: [
    DLButton(
      label: 'Button',
      type: DLButtonType.primary,
      onPressed: () {},
    ),
    DLButton(
      label: 'Button',
      type: DLButtonType.secondary,
      onPressed: () {},
    ),
  ],
  direction: Axis.vertical,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  showSeparator: true,
);
''';
