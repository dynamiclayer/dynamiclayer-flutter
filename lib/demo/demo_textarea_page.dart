import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoTextareaPage extends StatefulWidget {
  const DemoTextareaPage({super.key});

  @override
  State<DemoTextareaPage> createState() => _DemoTextareaPageState();
}

class _DemoTextareaPageState extends State<DemoTextareaPage> {
  late final TextEditingController filledController;
  late final TextEditingController disabledController;

  // Optional: keep a focus node to show Active state consistently.
  final FocusNode activeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    filledController = TextEditingController(
      text: 'May I know what is the noise level like in\nthe area?',
    );

    disabledController = TextEditingController(
      text: 'Tell us something about you',
    );

    // Auto-focus the active field on first frame (optional)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) activeFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    activeFocusNode.dispose();
    filledController.dispose();
    disabledController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Keep demo responsive: show 2 columns when there’s room, otherwise stack.
    return Scaffold(
      appBar: AppBar(title: const Text('Textarea — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Textarea variants (default / active / filled / disabled)',
            style: DLTypos.text2xlSemibold(),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F0F7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE6D9E6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Preview', style: DLTypos.text2xlSemibold()),
                const SizedBox(height: 12),

                LayoutBuilder(
                  builder: (context, c) {
                    final isTwoCol = c.maxWidth >= (343 * 2 + 16);
                    final children = <Widget>[
                      SizedBox(
                        width: 343,
                        child: DLTextarea(
                          state: DLTextareaState.defaultState,
                          hintText: 'Tell us something about you',
                          onChanged: (_) {},
                        ),
                      ),
                      SizedBox(
                        width: 343,
                        child: DLTextarea(
                          state: DLTextareaState.active,
                          focusNode: activeFocusNode,
                          // keep hint empty for the active screenshot style
                          hintText: '',
                          onChanged: (_) {},
                        ),
                      ),
                      SizedBox(
                        width: 343,
                        child: DLTextarea(
                          state: DLTextareaState.filled,
                          controller: filledController,
                          onChanged: (_) {},
                        ),
                      ),
                      SizedBox(
                        width: 343,
                        child: DLTextarea(
                          state: DLTextareaState.disabled,
                          controller: disabledController,
                          onChanged: null,
                        ),
                      ),
                    ];

                    if (isTwoCol) {
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: children,
                      );
                    }

                    return Column(
                      children: [
                        for (int i = 0; i < children.length; i++) ...[
                          children[i],
                          if (i != children.length - 1)
                            const SizedBox(height: 16),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Text('Code', style: DLTypos.text2xlSemibold()),
          const SizedBox(height: 8),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE9E1EA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFD2C5D4)),
            ),
            child: Text('''
// Default
DLTextarea(
  state: DLTextareaState.defaultState,
  hintText: 'Tell us something about you',
  onChanged: (v) {},
);

// Active
DLTextarea(
  state: DLTextareaState.active,
  onChanged: (v) {},
);

// Filled
DLTextarea(
  state: DLTextareaState.filled,
  controller: TextEditingController(text: '...'),
  onChanged: (v) {},
);

// Disabled (line-through + not editable)
DLTextarea(
  state: DLTextareaState.disabled,
  controller: TextEditingController(text: '...'),
  onChanged: null,
);
''', style: DLTypos.textSmRegular()),
          ),
        ],
      ),
    );
  }
}
