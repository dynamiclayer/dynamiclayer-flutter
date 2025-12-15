// lib/demo/demo_coach_mark_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/coachmark/dl_coach_mark.dart';

class DemoCoachMarkPage extends StatefulWidget {
  const DemoCoachMarkPage({super.key});

  @override
  State<DemoCoachMarkPage> createState() => _DemoCoachMarkPageState();
}

class _DemoCoachMarkPageState extends State<DemoCoachMarkPage> {
  final _titleC = TextEditingController(text: 'Title');
  final _messageC = TextEditingController(
    text: 'Pack my box with five dozen liquor jugs.\nHow vexingly quick draft.',
  );

  @override
  void dispose() {
    _titleC.dispose();
    _messageC.dispose();
    super.dispose();
  }

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
          _SectionHeader('Interactive (pagination + editable text)'),
          SizedBox(height: 8),
          _InteractiveCoachMarkBlock(),
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
          DLCoachMark(
            title: 'Title',
            message:
                'Pack my box with five dozen liquor jugs.\n'
                'How vexingly quick draft.',
            totalSteps: 2,
            initialStep: 0,
            direction: DLCoachMarkDirection.bottom,
          ),
          const SizedBox(height: 24),

          DLCoachMark(
            title: 'Title',
            message:
                'Pack my box with five dozen liquor jugs.\n'
                'How vexingly quick draft.',
            totalSteps: 2,
            initialStep: 0,
            direction: DLCoachMarkDirection.right,
          ),
          const SizedBox(height: 24),

          DLCoachMark(
            title: 'Title',
            message:
                'Pack my box with five dozen liquor jugs.\n'
                'How vexingly quick draft.',
            totalSteps: 2,
            initialStep: 0,
            direction: DLCoachMarkDirection.left,
          ),
          const SizedBox(height: 24),

          DLCoachMark(
            title: 'Title',
            message:
                'Pack my box with five dozen liquor jugs.\n'
                'How vexingly quick draft.',
            totalSteps: 2,
            initialStep: 0,
            direction: DLCoachMarkDirection.top,
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// INTERACTIVE – pagination changes with Next/Back + editable title/message
/// ---------------------------------------------------------------------------

class _InteractiveCoachMarkBlock extends StatefulWidget {
  const _InteractiveCoachMarkBlock({super.key});

  @override
  State<_InteractiveCoachMarkBlock> createState() =>
      _InteractiveCoachMarkBlockState();
}

class _InteractiveCoachMarkBlockState
    extends State<_InteractiveCoachMarkBlock> {
  late final TextEditingController _titleC;
  late final TextEditingController _messageC;

  @override
  void initState() {
    super.initState();
    _titleC = TextEditingController(text: 'Welcome');
    _messageC = TextEditingController(
      text:
          'This is an editable coach mark.\n'
          'Tap Next/Back to see pagination update.',
    );
  }

  @override
  void dispose() {
    _titleC.dispose();
    _messageC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DLColors.violet400, width: 1),
      ),
      child: DLCoachMark(
        totalSteps: 4,
        initialStep: 0,
        direction: DLCoachMarkDirection.bottom,

        // editable title + message
        editable: true,
        titleController: _titleC,
        messageController: _messageC,
        onTitleChanged: (v) {},
        onMessageChanged: (v) {},

        // If you later use Overlay and need to reposition per step, use this:
        onStepChanged: (step) {
          // debugPrint('Step changed => $step');
        },
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

const String _coachMarkUsageCode = '''
// Use DLCoachMark inside an OverlayEntry and reposition it as needed.
// The updated DLCoachMark manages step internally:
// - Next/Back updates the pagination automatically.
// - Use onStepChanged(step) if you need to move the overlay per step.
// - Use editable: true + controllers to allow editing title/message.
''';
