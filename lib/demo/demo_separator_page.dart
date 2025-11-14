import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoSeparatorPage extends StatelessWidget {
  const DemoSeparatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Separator — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Horizontal (length: 80, thickness: 2)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: Center(
              child: DLSeparator(
                direction: DLSeparatorDirection.horizontal,
                length: 80, // width: 80, height: 0 (visually)
                thickness: 2,
              ),
            ),
            code: _horizontalSeparatorCode,
          ),
          SizedBox(height: 24),

          _SectionHeader('Vertical (length: 80, thickness: 2)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: SizedBox(
              height: 100,
              child: Center(
                child: DLSeparator(
                  direction: DLSeparatorDirection.vertical,
                  length: 80, // height: 80, width: 0 (visually)
                  thickness: 2,
                ),
              ),
            ),
            code: _verticalSeparatorCode,
          ),
          SizedBox(height: 24),

          _SectionHeader('Full-width horizontal (expand)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: DLSeparator(
              direction: DLSeparatorDirection.horizontal,
              length: null, // expands to parent constraints
              thickness: 1,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),
            code: _fullWidthSeparatorCode,
          ),
        ],
      ),
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
const _horizontalSeparatorCode = '''
// Horizontal (length: 80, thickness: 2)
DLSeparator(
  direction: DLSeparatorDirection.horizontal,
  length: 80, // width: 80, height: 0 (visually)
  thickness: 2,
);
''';

const _verticalSeparatorCode = '''
// Vertical (length: 80, thickness: 2)
SizedBox(
  height: 100,
  child: Center(
    child: DLSeparator(
      direction: DLSeparatorDirection.vertical,
      length: 80, // height: 80, width: 0 (visually)
      thickness: 2,
    ),
  ),
);
''';

const _fullWidthSeparatorCode = '''
// Full-width horizontal (expand)
DLSeparator(
  direction: DLSeparatorDirection.horizontal,
  length: null, // expands to parent constraints
  thickness: 1,
  margin: const EdgeInsets.symmetric(vertical: 8),
);
''';
