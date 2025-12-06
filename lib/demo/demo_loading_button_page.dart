// lib/demo/demo_loading_button_page.dart
import 'package:dynamiclayer_flutter/src/components/buttons/dl_loading_button.dart';
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoLoadingButtonPage extends StatelessWidget {
  const DemoLoadingButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Buttons — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Size × Variant matrix'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _LoadingButtonsGrid(),
            code: _loadingButtonsCode,
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Loading Buttons Preview
/// ---------------------------------------------------------------------------

class _LoadingButtonsGrid extends StatelessWidget {
  const _LoadingButtonsGrid();

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SizeLabel('LG'),
        SizedBox(height: 8),
        _LoadingRow(size: DLButtonSize.lg),
        spacer,
        _SizeLabel('MD'),
        SizedBox(height: 8),
        _LoadingRow(size: DLButtonSize.md),
        spacer,
        _SizeLabel('SM'),
        SizedBox(height: 8),
        _LoadingRow(size: DLButtonSize.sm),
        spacer,
        _SizeLabel('XS'),
        SizedBox(height: 8),
        _LoadingRow(size: DLButtonSize.xs),
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

/// One row: primary, secondary, tertiary, ghost (dots only)
class _LoadingRow extends StatelessWidget {
  const _LoadingRow({super.key, required this.size});

  final DLButtonSize size;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        DLButtonLoading(type: DLButtonType.primary, size: size),
        DLButtonLoading(type: DLButtonType.secondary, size: size),
        DLButtonLoading(type: DLButtonType.tertiary, size: size),
        DLButtonLoading(type: DLButtonType.ghost, size: size),
      ],
    );
  }
}

/// ---------- DOC UI helpers (same pattern as other catalog pages) ----------
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

/// ---------- Code Sample ----------

const _loadingButtonsCode = '''
// Loading buttons matrix example

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // LG row
    Wrap(
      spacing: 16,
      runSpacing: 8,
      children: const [
        DLLoadingButton(
          type: DLButtonType.primary,
          size: DLButtonSize.lg,
        ),
        DLLoadingButton(
          type: DLButtonType.secondary,
          size: DLButtonSize.lg,
        ),
        DLLoadingButton(
          type: DLButtonType.tertiary,
          size: DLButtonSize.lg,
        ),
        DLLoadingButton(
          type: DLButtonType.ghost,
          size: DLButtonSize.lg,
        ),
      ],
    ),

    SizedBox(height: 16),

    // MD row, SM row, XS row ...
  ],
);
''';
