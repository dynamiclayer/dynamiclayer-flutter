// lib/demo/demo_search_field_page.dart
import 'package:flutter/material.dart';

import '../dynamiclayers.dart';
import '../src/components/search/dl_search_field.dart';

class DemoSearchFieldPage extends StatelessWidget {
  const DemoSearchFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DLColors.white,
      appBar: AppBar(title: const Text('Search Field — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('LG'),
          SizedBox(height: 12),
          _LgRow(),
          SizedBox(height: 24),

          _SectionHeader('MD'),
          SizedBox(height: 12),
          _MdRow(),
          SizedBox(height: 24),

          _SectionHeader('SM'),
          SizedBox(height: 12),
          _SmRow(),
          SizedBox(height: 24),

          _SectionHeader('Disabled'),
          SizedBox(height: 12),
          _DisabledRow(),
          SizedBox(height: 24),

          _SubHeader('How to use'),
          SizedBox(height: 8),
          _CodeBox(code: _usage),
        ],
      ),
    );
  }
}

class _LgRow extends StatelessWidget {
  const _LgRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        const DLSearchField(size: DLSearchFieldSize.lg),
        DLSearchField(
          size: DLSearchFieldSize.lg,
          controller: TextEditingController(text: 'Search Field'),
        ),
      ],
    );
  }
}

class _MdRow extends StatelessWidget {
  const _MdRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        const DLSearchField(size: DLSearchFieldSize.md),
        DLSearchField(
          size: DLSearchFieldSize.md,
          controller: TextEditingController(text: 'Search Field'),
        ),
      ],
    );
  }
}

class _SmRow extends StatelessWidget {
  const _SmRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: [
        const DLSearchField(size: DLSearchFieldSize.sm),
        DLSearchField(
          size: DLSearchFieldSize.sm,
          controller: TextEditingController(text: 'Search Field'),
        ),
      ],
    );
  }
}

class _DisabledRow extends StatelessWidget {
  const _DisabledRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: const [
        DLSearchField(size: DLSearchFieldSize.lg, enabled: false),
        DLSearchField(size: DLSearchFieldSize.md, enabled: false),
        DLSearchField(size: DLSearchFieldSize.sm, enabled: false),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
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

const String _usage = '''
// Default (lg, fixed width 320)
const DLSearchField(
  size: DLSearchFieldSize.lg,
  placeholder: 'Search Field',
);

// With initial text (clear icon shows when hasText)
DLSearchField(
  size: DLSearchFieldSize.lg,
  controller: TextEditingController(text: 'Search Field'),
  onChanged: print,
);

// Disabled (line-through text)
const DLSearchField(
  size: DLSearchFieldSize.lg,
  enabled: false,
);
''';
