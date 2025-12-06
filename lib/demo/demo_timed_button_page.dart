// lib/demo/demo_timed_button_page.dart
import 'package:flutter/material.dart';

import '../dynamiclayers.dart';
import '../src/components/buttons/dl_timed_button.dart';

class DemoTimedButtonPage extends StatelessWidget {
  const DemoTimedButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timed Buttons — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Timed buttons — default & disabled'),
          SizedBox(height: 8),
          _PreviewBlock(child: _TimedButtonsGrid(), code: _timedButtonsCode),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW GRID
/// ---------------------------------------------------------------------------

class _TimedButtonsGrid extends StatelessWidget {
  const _TimedButtonsGrid();

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 20);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SizeLabel('LG (144×56)'),
        SizedBox(height: 8),
        _TimedRow(size: DLTimedButtonSize.lg),
        spacer,
        _SizeLabel('MD (128×48)'),
        SizedBox(height: 8),
        _TimedRow(size: DLTimedButtonSize.md),
        spacer,
        _SizeLabel('SM (128×40)'),
        SizedBox(height: 8),
        _TimedRow(size: DLTimedButtonSize.sm),
        spacer,
        _SizeLabel('XS (108×32)'),
        SizedBox(height: 8),
        _TimedRow(size: DLTimedButtonSize.xs),
      ],
    );
  }
}

class _SizeLabel extends StatelessWidget {
  const _SizeLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

/// Helper to keep widths consistent with the token widths
double _buttonWidth(DLTimedButtonSize size) {
  switch (size) {
    case DLTimedButtonSize.lg:
      return 144;
    case DLTimedButtonSize.md:
    case DLTimedButtonSize.sm:
      return 128;
    case DLTimedButtonSize.xs:
      return 108;
  }
}

/// One logical “row”: default timed + disabled visual.
class _TimedRow extends StatelessWidget {
  const _TimedRow({super.key, required this.size});

  final DLTimedButtonSize size;

  @override
  Widget build(BuildContext context) {
    final width = _buttonWidth(size);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Default (timed) button – 1 minute, autostarts.
        SizedBox(
          width: width,
          child: DLTimedButton(
            size: size,
            duration: const Duration(minutes: 1),
            label: 'Label',
            autostart: true,
            onCompleted: () {},
          ),
        ),
        const SizedBox(width: 16),
        // Disabled visual – static 0:00, no animation.
        SizedBox(
          width: width,
          child: DLTimedButton(
            size: size,
            duration: const Duration(minutes: 1),
            label: 'Label',
            disabled: true,
            autostart: false,
            onCompleted: () {},
          ),
        ),
      ],
    );
  }
}

/// ---------- DOC UI helpers ----------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {super.key});
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
  const _PreviewBlock({super.key, required this.child, required this.code});
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
  const _SubHeader(this.title, {super.key});
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
  const _CodeBox({super.key, required this.code});
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

/// ---------- Code sample shown in the docs (1-minute default) --------------

const _timedButtonsCode =
    '''// 1-minute timed button (autostarts, shows progress bar + mm:ss)
DLTimedButton(
  size: DLTimedButtonSize.lg,
  duration: const Duration(minutes: 1),
  label: 'Label',
  autostart: true,
  onCompleted: () {},
);

// Disabled visual (static 0:00)
DLTimedButton(
  size: DLTimedButtonSize.lg,
  duration: const Duration(minutes: 1),
  label: 'Label',
  disabled: true,
  autostart: false,
  onCompleted: () {},
);
''';
