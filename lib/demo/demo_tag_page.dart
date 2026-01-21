// lib/demo/demo_tag_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/tag/dl_tag.dart';

class DemoTagPage extends StatelessWidget {
  const DemoTagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tag — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Tag variants (Type × Mode × Size)'),
          SizedBox(height: 8),
          _PreviewBlock(child: _TagPreview(), code: _tagCodeSample),
        ],
      ),
    );
  }
}

class _TagPreview extends StatelessWidget {
  const _TagPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SubHeader('Default'),
        SizedBox(height: 8),
        _TagTypeBlock(type: DLTagType.defaultTag),
        SizedBox(height: 20),

        _SubHeader('Warning'),
        SizedBox(height: 8),
        _TagTypeBlock(type: DLTagType.warning),
        SizedBox(height: 20),

        _SubHeader('Success'),
        SizedBox(height: 8),
        _TagTypeBlock(type: DLTagType.success),
        SizedBox(height: 20),

        _SubHeader('Error'),
        SizedBox(height: 8),
        _TagTypeBlock(type: DLTagType.error),
      ],
    );
  }
}

class _TagTypeBlock extends StatelessWidget {
  const _TagTypeBlock({required this.type});
  final DLTagType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _MiniLabel('Light'),
        const SizedBox(height: 8),
        _TagSizesRow(type: type, mode: DLTagMode.light),
        const SizedBox(height: 12),
        const _MiniLabel('Dark'),
        const SizedBox(height: 8),
        _TagSizesRow(type: type, mode: DLTagMode.dark),
      ],
    );
  }
}

class _TagSizesRow extends StatelessWidget {
  const _TagSizesRow({required this.type, required this.mode});
  final DLTagType type;
  final DLTagMode mode;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [_SizeLabel('lg'), _SizeLabel('md'), _SizeLabel('sm')]
          .asMap()
          .entries
          .map((entry) {
            final i = entry.key;
            final w = entry.value;

            DLTagSize size;
            switch (i) {
              case 0:
                size = DLTagSize.lg;
                break;
              case 1:
                size = DLTagSize.md;
                break;
              default:
                size = DLTagSize.sm;
            }

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                w,
                const SizedBox(width: 8),
                DLTag(value: 'Tag', type: type, mode: mode, size: size),
              ],
            );
          })
          .toList(),
    );
  }
}

class _SizeLabel extends StatelessWidget {
  const _SizeLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MiniLabel extends StatelessWidget {
  const _MiniLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}

/// ---------- DOC UI helpers (same pattern as other catalog pages) ----------

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

/// ---------- Code sample shown in the docs ---------------------------------

const _tagCodeSample = '''// Tag (default / light / lg)
const DLTag(
  value: 'Tag',
  type: DLTagType.defaultTag,
  mode: DLTagMode.light,
  size: DLTagSize.lg,
);

// Tag (warning / dark / md)
const DLTag(
  value: 'Tag',
  type: DLTagType.warning,
  mode: DLTagMode.dark,
  size: DLTagSize.md,
);

// Tag (success / light / sm)
const DLTag(
  value: 'Tag',
  type: DLTagType.success,
  mode: DLTagMode.light,
  size: DLTagSize.sm,
);''';
