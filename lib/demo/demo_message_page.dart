// lib/demo/demo_message_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/message/dl_message.dart';

class DemoMessagePage extends StatelessWidget {
  const DemoMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Message variants'),
          SizedBox(height: 8),
          _MessagePreview(),
          SizedBox(height: 24),
          _SubHeader('How to use'),
          SizedBox(height: 8),
          _CodeBox(code: _messageUsageCode),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW – 4 tiles (2×2) like the screenshot:
/// 1) Other single (light)
/// 2) Own single (dark)
/// 3) Other response with highlight (light)
/// 4) Own response with highlight (dark)
/// ---------------------------------------------------------------------------

class _MessagePreview extends StatelessWidget {
  const _MessagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return _BorderedContainer(
      child: Column(
        children: [
          // Row 1 -------------------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: DLMessage.otherSingle(
                    author: 'Thomas',
                    text: 'Lorem ipsum dolor sit amet.',
                  ),
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DLMessage.ownSingle(
                    text: 'Lorem ipsum dolor sit amet.',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Row 2 -------------------------------------------------------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: DLMessage.otherResponse(
                    author: 'Thomas',
                    text: 'Lorem ipsum dolor sit amet.',
                    highlightAuthor: 'Andrew',
                    highlightText:
                        'Lorem ipsum dolor sit amet, consetetur '
                        'sadipscing elitr.',
                  ),
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: DLMessage.ownResponse(
                    text: 'Lorem ipsum dolor sit amet.',
                    highlightAuthor: 'Thomas',
                    highlightText:
                        'Lorem ipsum dolor sit amet, consetetur '
                        'sadipscing elitr.',
                  ),
                ),
              ),
            ],
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

/// Simple rounded border container for the preview block.
class _BorderedContainer extends StatelessWidget {
  const _BorderedContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DLColors.violet400, width: 1),
      ),
      width: double.infinity,
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

const String _messageUsageCode = '''
// Other user's single message
const DLMessage.otherSingle(
  author: 'Thomas',
  text: 'Lorem ipsum dolor sit amet.',
);

// Your own single message
const DLMessage.ownSingle(
  text: 'Lorem ipsum dolor sit amet.',
);

// Other user response with quoted message
const DLMessage.otherResponse(
  author: 'Thomas',
  text: 'Lorem ipsum dolor sit amet.',
  highlightAuthor: 'Andrew',
  highlightText:
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
);

// Your own response with quoted message
const DLMessage.ownResponse(
  text: 'Lorem ipsum dolor sit amet.',
  highlightAuthor: 'Thomas',
  highlightText:
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
);

// Optional: custom max width for the bubbles (default: 240)
const DLMessage.ownSingle(
  text: 'This bubble can be wider.',
  maxWidth: 320,
);
''';
