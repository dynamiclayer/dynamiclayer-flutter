import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoProgressPage extends StatefulWidget {
  const DemoProgressPage({super.key});

  @override
  State<DemoProgressPage> createState() => _DemoProgressPageState();
}

class _DemoProgressPageState extends State<DemoProgressPage> {
  DLProgressState _state = DLProgressState.one;

  void _play() {
    // Force replay: one -> two
    setState(() => _state = DLProgressState.one);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _state = DLProgressState.two);
    });
  }

  void _reset() => setState(() => _state = DLProgressState.one);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress — Two States'),
        actions: [
          TextButton.icon(
            onPressed: _reset,
            icon: const Icon(Icons.refresh),
            label: const Text('Reset'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Preview', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: DLProgress(
                state: _state,
                width: 343,
                height: 8,
                radius: 9999,
                animationDelay: const Duration(milliseconds: 300),
                animationDuration: const Duration(milliseconds: 2400),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: _play,
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Play animation'),
              ),
              OutlinedButton(
                onPressed: _reset,
                child: const Text('State "one"'),
              ),
              OutlinedButton(
                onPressed: () => setState(() => _state = DLProgressState.two),
                child: const Text('State "two"'),
              ),
            ],
          ),

          const SizedBox(height: 24),
          Text('Code', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black12),
            ),
            child: const SelectableText(
              _sampleCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}

const _sampleCode = '''
DLProgress(
  state: DLProgressState.two, // or DLProgressState.one
  width: 343,
  height: 8,
  radius: 9999,
  animationDelay: Duration(milliseconds: 300),
  animationDuration: Duration(milliseconds: 2400),
);
''';
