// lib/demo/demo_message_dock_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/message/dl_message_dock.dart';

class DemoMessageDockPage extends StatelessWidget {
  const DemoMessageDockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We handle the keyboard inset manually.
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Message Dock — Live Demo')),
      body: SafeArea(child: _DemoBody()),
    );
  }
}

class _DemoBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      children: [
        // -------------------------------------------------------------------
        // TOP: How to use + explanation (scrollable)
        // -------------------------------------------------------------------
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              _SectionHeader('How to use'),
              SizedBox(height: 8),
              _CodeBox(code: _usageCode),
              SizedBox(height: 24),
              _SectionHeader('Live demo'),
              SizedBox(height: 8),
              _DemoText(),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // BOTTOM: Dock that moves up with the keyboard
        // -------------------------------------------------------------------
        AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: bottomInset),
          child: DLMessageDock(
            onSend: (text) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Sent: $text')));
            },
          ),
        ),
      ],
    );
  }
}

/// Small helper text under "Live demo"
class _DemoText extends StatelessWidget {
  const _DemoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tap the input at the bottom to open the keyboard.\n\n'
      'When you start typing, the send button becomes active and the dock '
      'stays on top of the keyboard.',
      style: DLTypos.textBaseRegular(color: DLColors.grey700),
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

/// ---------- "How to use" snippet shown at top ------------------------------

const String _usageCode = '''
// Inside a chat screen
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Placeholder(), // your messages list here
      // IMPORTANT: Use DLMessageDock inside the body or as bottomNavigationBar.
      // For Android, put it in the body and use viewInsets.bottom to keep it
      // above the keyboard (see DemoMessageDockPage).
      bottomNavigationBar: DLMessageDock(
        onSend: (text) {
          // send message here
        },
      ),
    );
  }
}

// Custom hint text
DLMessageDock(
  hintText: 'Message',
  onSend: (text) { /* ... */ },
);

// Disabled dock (read-only mode)
DLMessageDock(
  enabled: false,
  onSend: (_) {}, // will not be called while disabled
);
''';
