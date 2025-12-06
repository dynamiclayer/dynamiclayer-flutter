import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/card/dl_card.dart';

class DemoCardPage extends StatelessWidget {
  const DemoCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cards — Catalog')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: const [
                _SectionHeader('Cards — default / active / disabled'),
                SizedBox(height: 8),
                _PreviewBlock(child: _CardsPreview(), code: _cardUsageCode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Preview content (what you see in the screenshot)
/// ---------------------------------------------------------------------------

class _CardsPreview extends StatelessWidget {
  const _CardsPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _CardRow(size: DLCardSize.md),
        SizedBox(height: 32),
        _CardRow(size: DLCardSize.lg),
      ],
    );
  }
}

class _CardRow extends StatelessWidget {
  const _CardRow({required this.size});

  final DLCardSize size;

  @override
  Widget build(BuildContext context) {
    const spacing = 24.0;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.start,
      children: [
        _DemoCard(size: size, state: DLCardState.normal),
        _DemoCard(size: size, state: DLCardState.active),
        _DemoCard(size: size, state: DLCardState.disabled),
      ],
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.size, required this.state});

  final DLCardSize size;
  final DLCardState state;

  @override
  Widget build(BuildContext context) {
    // Demo width ~ Figma (slightly wider to avoid text overflow).
    return SizedBox(
      width: 180,
      child: DLCard(
        size: size,
        state: state,
        title: 'Title',
        description: 'Description',
        icon: const Icon(Icons.crop_free, size: 24),
        onTap: state == DLCardState.disabled ? null : () {},
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Section header + preview block (preview + code)
/// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final style =
        Theme.of(context).textTheme.titleLarge ??
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: style),
    );
  }
}

class _PreviewBlock extends StatelessWidget {
  const _PreviewBlock({required this.child, required this.code});

  final Widget child;
  final String code;

  @override
  Widget build(BuildContext context) {
    final codeStyle =
        Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontFamily: 'monospace') ??
        const TextStyle(fontSize: 12, fontFamily: 'monospace');

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          child,
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Text(code, style: codeStyle),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// "How to use" code snippet
/// ---------------------------------------------------------------------------

const String _cardUsageCode = '''
// Import
import 'package:dynamiclayers/dynamiclayers.dart';

// Usage
DLCard(
  size: DLCardSize.md,            // or DLCardSize.lg
  state: DLCardState.normal,      // normal, active, disabled
  title: 'Title',
  description: 'Description',
  icon: Icon(Icons.crop_free),    // any 24x24 icon
  onTap: () {
    // Handle tap here
  },
);
''';
