// lib/demo/demo_loading_dots_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/loaders/dl_loading_dots.dart'; // make sure DLLoadingDots is exported here

class DemoLoadingDotsPage extends StatelessWidget {
  const DemoLoadingDotsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading Dots — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Standalone loading dots'),
          SizedBox(height: 8),
          _PreviewBlock(child: _LoadingDotsPreview(), code: _loadingDotsCode),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW
/// ---------------------------------------------------------------------------

class _LoadingDotsPreview extends StatelessWidget {
  const _LoadingDotsPreview();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Light surface (auto uses black dots) – NO BORDER
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: DLColors.white,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const DLLoadingDots(), // auto color (light → black)
                ),
                const SizedBox(height: 8),
                Text('Light surface', style: textStyle),
              ],
            ),
            const SizedBox(width: 40),
            // Dark surface (force white dots) – NO BORDER
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: DLColors.black,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const DLLoadingDots(color: DLColors.white),
                ),
                const SizedBox(height: 8),
                Text('Dark surface', style: textStyle),
              ],
            ),
          ],
        ),
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

/// ---------- Code Sample (no borders around dots containers) ----------

const _loadingDotsCode = '''
// Standalone DLLoadingDots on light & dark surfaces (no borders)

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // Light surface (auto uses black dots)
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: DLColors.white,
        borderRadius: BorderRadius.circular(999),
      ),
      child: const DLLoadingDots(), // auto dark/light color
    ),

    SizedBox(width: 40),

    // Dark surface (force white dots)
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: DLColors.black,
        borderRadius: BorderRadius.circular(999),
      ),
      child: const DLLoadingDots(color: DLColors.white),
    ),
  ],
);
''';
