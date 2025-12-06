// lib/demo/demo_coach_mark_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/coachmark/dl_coach_mark.dart';

class DemoCoachMarkPage extends StatelessWidget {
  const DemoCoachMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coach Mark — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Coach mark directions'),
          SizedBox(height: 8),
          _CoachMarkPreview(),
          SizedBox(height: 24),
          _SubHeader('How to use'),
          SizedBox(height: 8),
          _CodeBox(code: _coachMarkUsageCode),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW – 4 marks stacked vertically (bottom, right, left, top)
/// ---------------------------------------------------------------------------

class _CoachMarkPreview extends StatelessWidget {
  const _CoachMarkPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DLColors.violet400, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bottom pointer
          DLCoachMark(
            title: 'Title',
            message:
                'Pack my box with five dozen liquor jugs.\n'
                'How vexingly quick draft.',
            currentStep: 0,
            totalSteps: 2,
            direction: DLCoachMarkDirection.bottom,
            onBack: () {},
            onNext: () {},
          ),
          const SizedBox(height: 24),

          // Right pointer
          DLCoachMark(
            title: 'Title',
            message:
                'Pack my box with five dozen liquor jugs.\n'
                'How vexingly quick draft.',
            currentStep: 0,
            totalSteps: 2,
            direction: DLCoachMarkDirection.right,
            onBack: () {},
            onNext: () {},
          ),
          const SizedBox(height: 24),

          // Left pointer
          DLCoachMark(
            title: 'Title',
            message:
                'Pack my box with five dozen liquor jugs.\n'
                'How vexingly quick draft.',
            currentStep: 0,
            totalSteps: 2,
            direction: DLCoachMarkDirection.left,
            onBack: () {},
            onNext: () {},
          ),
          const SizedBox(height: 24),

          // Top pointer
          DLCoachMark(
            title: 'Title',
            message:
                'Pack my box with five dozen liquor jugs.\n'
                'How vexingly quick draft.',
            currentStep: 0,
            totalSteps: 2,
            direction: DLCoachMarkDirection.top,
            onBack: () {},
            onNext: () {},
          ),
        ],
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

/// ---------- "How to use" snippet shown in the docs ------------------------

const String _coachMarkUsageCode = '''
// 1. Define a list of steps
final steps = [
  const DLCoachMark(
    title: 'Welcome',
    message: 'This is your dashboard. Here you can see an overview.',
    currentStep: 0,
    totalSteps: 3,
    direction: DLCoachMarkDirection.bottom,
    onBack: _noop,
    onNext: _noop,
  ),
  const DLCoachMark(
    title: 'Filter',
    message: 'Use this filter to narrow down the results.',
    currentStep: 1,
    totalSteps: 3,
    direction: DLCoachMarkDirection.right,
    onBack: _noop,
    onNext: _noop,
  ),
  const DLCoachMark(
    title: 'Action button',
    message: 'Tap here to create a new item.',
    currentStep: 2,
    totalSteps: 3,
    direction: DLCoachMarkDirection.top,
    onBack: _noop,
    onNext: _noop,
  ),
];

// 2. Show a coach mark using an OverlayEntry
void showCoachMark(BuildContext context, DLCoachMark mark) {
  final overlay = Overlay.of(context);
  if (overlay == null) return;

  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) => Positioned(
      left: 16,
      right: 16,
      bottom: 120, // position near the target widget
      child: mark,
    ),
  );

  overlay.insert(entry);

  // In your real code, pass onBack/onNext callbacks that remove
  // the current entry and insert the next/previous one.
}

// 3. Basic example
ElevatedButton(
  onPressed: () {
    showCoachMark(
      context,
      DLCoachMark(
        title: 'Title',
        message: 'Pack my box with five dozen liquor jugs.\\n'
                 'How vexingly quick draft.',
        currentStep: 0,
        totalSteps: 2,
        direction: DLCoachMarkDirection.bottom,
        onBack: () {},
        onNext: () {},
      ),
    );
  },
  child: const Text('Start tutorial'),
);
''';
