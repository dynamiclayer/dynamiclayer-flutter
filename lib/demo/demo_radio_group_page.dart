import 'package:flutter/material.dart';

import '../src/components/radio_group/dl_radio_group.dart';

class DemoRadioGroupPage extends StatelessWidget {
  const DemoRadioGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radio Group — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Radio Group variants (1 → 5)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _RadioGroupVariantsColumn(),
            code: _radioGroupCodeSample,
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Preview: Variants shown in a COLUMN (Variant 1..5 stacked vertically)
/// ---------------------------------------------------------------------------

class _RadioGroupVariantsColumn extends StatelessWidget {
  const _RadioGroupVariantsColumn();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _VariantBlock(title: 'Variant 1', variant: DLRadioGroupVariant.v1),
        SizedBox(height: 24),

        _VariantBlock(title: 'Variant 2', variant: DLRadioGroupVariant.v2),
        SizedBox(height: 24),

        _VariantBlock(title: 'Variant 3', variant: DLRadioGroupVariant.v3),
        SizedBox(height: 24),

        _VariantBlock(title: 'Variant 4', variant: DLRadioGroupVariant.v4),
        SizedBox(height: 24),

        _VariantBlock(title: 'Variant 5', variant: DLRadioGroupVariant.v5),
      ],
    );
  }
}

class _VariantBlock extends StatefulWidget {
  const _VariantBlock({required this.title, required this.variant});

  final String title;
  final DLRadioGroupVariant variant;

  @override
  State<_VariantBlock> createState() => _VariantBlockState();
}

class _VariantBlockState extends State<_VariantBlock> {
  int _selected = 0;

  static const _labels = [
    'Radio Group',
    'Radio Group',
    'Radio Group',
    'Radio Group',
    'Radio Group',
    'Radio Group',
    'Radio Group',
    'Radio Group',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        DLRadioGroup(
          labels: _labels,
          selectedIndex: _selected,
          onChanged: (i) => setState(() => _selected = i),
          variant: widget.variant,
        ),
      ],
    );
  }
}

/// ---------- DOC UI helpers (same pattern as your Chip catalog page) ----------

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
          child: Align(alignment: Alignment.centerLeft, child: child),
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

/// ---------- Code sample shown in the docs ---------------------------------

const _radioGroupCodeSample = '''// Radio Group (variant 5)
DLRadioGroup(
  labels: const [
    'Radio Group','Radio Group','Radio Group','Radio Group',
    'Radio Group','Radio Group','Radio Group','Radio Group',
  ],
  selectedIndex: 0,
  onChanged: (i) {},
  variant: DLRadioGroupVariant.v5,
);
''';
