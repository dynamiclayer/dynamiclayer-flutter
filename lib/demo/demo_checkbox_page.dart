// lib/demo/demo_checkbox_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/checkbox/dl_checkbox.dart'; // DLCheckbox, DLColors, etc.

class DemoCheckboxPage extends StatelessWidget {
  const DemoCheckboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkbox — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Checkbox states'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _CheckboxStatesPreview(),
            code: _checkboxCodeSample,
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Preview row: default, active, disabled
/// ---------------------------------------------------------------------------

class _CheckboxStatesPreview extends StatelessWidget {
  const _CheckboxStatesPreview();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        // 1) Default (interactive, unchecked)
        _InteractiveCheckboxDemo(),
        SizedBox(width: 48),

        // 2) Active (checked, enabled – black with checkmark)
        _ActiveCheckboxSample(),
        SizedBox(width: 48),

        // 3) Disabled (grey with minus)
        DLCheckbox(value: null, enabled: false, onChanged: null),
      ],
    );
  }
}

/// Separate stateful widget so the first checkbox is interactive.
class _InteractiveCheckboxDemo extends StatefulWidget {
  const _InteractiveCheckboxDemo({super.key});

  @override
  State<_InteractiveCheckboxDemo> createState() =>
      _InteractiveCheckboxDemoState();
}

class _InteractiveCheckboxDemoState extends State<_InteractiveCheckboxDemo> {
  bool? _value = false;

  @override
  Widget build(BuildContext context) {
    return DLCheckbox(
      value: _value,
      enabled: true,
      onChanged: (next) {
        setState(() => _value = next);
      },
      semanticLabel: 'Interactive demo checkbox',
    );
  }
}

/// Active (checked) sample – enabled but we ignore interaction.
class _ActiveCheckboxSample extends StatelessWidget {
  const _ActiveCheckboxSample({super.key});

  @override
  Widget build(BuildContext context) {
    return DLCheckbox(
      value: true,
      enabled: true,
      // Pass a no-op callback so the control is NOT treated as disabled.
      onChanged: (_) {},
      semanticLabel: 'Active checkbox sample',
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

const _checkboxCodeSample = '''
// 1) Default (interactive)
class _InteractiveCheckboxDemo extends StatefulWidget {
  const _InteractiveCheckboxDemo({super.key});

  @override
  State<_InteractiveCheckboxDemo> createState() =>
      _InteractiveCheckboxDemoState();
}

class _InteractiveCheckboxDemoState extends State<_InteractiveCheckboxDemo> {
  bool? _value = false;

  @override
  Widget build(BuildContext context) {
    return DLCheckbox(
      value: _value,
      enabled: true,
      onChanged: (next) {
        setState(() => _value = next);
      },
    );
  }
}

// 2) Active (checked)
DLCheckbox(
  value: true,
  enabled: true,
  onChanged: (_) {}, // no-op to keep it enabled
);

// 3) Disabled
const DLCheckbox(
  value: null,
  enabled: false,
  onChanged: null,
);
''';
