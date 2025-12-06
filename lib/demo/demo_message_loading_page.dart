// lib/demo/demo_message_loading_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/message/dl_message_loading.dart';

class DemoMessageLoadingPage extends StatelessWidget {
  const DemoMessageLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages Loading — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Messages Loading Dots'),
          SizedBox(height: 8),
          _DotsPreview(),
          SizedBox(height: 32),
          _SectionHeader('Messages Loading'),
          SizedBox(height: 8),
          _BubblePreview(),
          SizedBox(height: 24),
          _SubHeader('How to use'),
          SizedBox(height: 8),
          _CodeBox(code: _usageCode),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW 1 – dots only (three groups, centered)
/// ---------------------------------------------------------------------------

class _DotsPreview extends StatelessWidget {
  const _DotsPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return _BorderedContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          DLMessageLoadingDots(),
          DLMessageLoadingDots(),
          DLMessageLoadingDots(),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW 2 – message loading bubble (single bubble, left-aligned)
/// ---------------------------------------------------------------------------

class _BubblePreview extends StatelessWidget {
  const _BubblePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: _BorderedContainer(
        width: 160,
        child: const Center(child: DLMessageLoadingBubble()),
      ),
    );
  }
}

/// ---------- Shared demo helpers -------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {super.key});
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

/// Simple rounded violet border container (used for both previews)
class _BorderedContainer extends StatelessWidget {
  const _BorderedContainer({super.key, required this.child, this.width});

  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DLColors.violet400, width: 1),
      ),
      child: child,
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

/// ---------- "How to use" snippet ------------------------------------------

const String _usageCode = '''
// Inline typing indicator (dots only)
const DLMessageLoadingDots();

// Inside a chat bubble
const DLMessageLoadingBubble();

// Custom dot size / spacing
const DLMessageLoadingDots(
  dotSize: 10,
  gap: 10,
);
''';
