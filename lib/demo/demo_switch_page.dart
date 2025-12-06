// lib/demo/demo_switch_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/switch/dl_switch.dart';

class DemoSwitchPage extends StatelessWidget {
  const DemoSwitchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Switch — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Switch states'),
          SizedBox(height: 8),
          _PreviewBlock(child: _SwitchStatesPreview(), code: _switchCodeSample),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Preview row: interactive (off/on) + fixed ON sample
/// ---------------------------------------------------------------------------

class _SwitchStatesPreview extends StatelessWidget {
  const _SwitchStatesPreview();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        // 1) Interactive switch (you can toggle it)
        _InteractiveSwitchDemo(),
        SizedBox(width: 48),

        // 2) Always-on sample (enabled but no-op tap)
        _OnSwitchSample(),
      ],
    );
  }
}

/// Separate stateful widget so the first switch is interactive.
class _InteractiveSwitchDemo extends StatefulWidget {
  const _InteractiveSwitchDemo({super.key});

  @override
  State<_InteractiveSwitchDemo> createState() => _InteractiveSwitchDemoState();
}

class _InteractiveSwitchDemoState extends State<_InteractiveSwitchDemo> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return DLSwitch(
      value: _value,
      enabled: true,
      onChanged: (next) {
        setState(() => _value = next);
      },
      semanticLabel: 'Interactive demo switch',
    );
  }
}

/// ON sample – visually on, but tap doesn’t change state.
class _OnSwitchSample extends StatelessWidget {
  const _OnSwitchSample({super.key});

  @override
  Widget build(BuildContext context) {
    return DLSwitch(
      value: true,
      enabled: true,
      onChanged: (_) {}, // no-op to keep it visually on
      semanticLabel: 'On switch sample',
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

/// ---------- Code sample shown in the docs ---------------------------------

const _switchCodeSample = '''// 1) Interactive switch
class _InteractiveSwitchDemo extends StatefulWidget {
  const _InteractiveSwitchDemo({super.key});

  @override
  State<_InteractiveSwitchDemo> createState() =>
      _InteractiveSwitchDemoState();
}

class _InteractiveSwitchDemoState extends State<_InteractiveSwitchDemo> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return DLSwitch(
      value: _value,
      enabled: true,
      onChanged: (next) {
        setState(() => _value = next);
      },
    );
  }
}

// 2) Always-on sample
DLSwitch(
  value: true,
  enabled: true,
  onChanged: (_) {}, // no-op to keep it visually on
);
''';
