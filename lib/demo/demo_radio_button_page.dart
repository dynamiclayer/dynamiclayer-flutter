// lib/demo/demo_radio_button_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/radio/dl_radio_button.dart';

class DemoRadioButtonPage extends StatelessWidget {
  const DemoRadioButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Radio Button — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Radio button states'),
          SizedBox(height: 8),
          _PreviewBlock(child: _RadioStatesPreview(), code: _radioCodeSample),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Preview row: default, active, disabled
/// ---------------------------------------------------------------------------

class _RadioStatesPreview extends StatelessWidget {
  const _RadioStatesPreview();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        // 1) Default (interactive, unselected)
        _InteractiveRadioDemo(),
        SizedBox(width: 48),

        // 2) Active (selected, enabled – black with white dot)
        _ActiveRadioSample(),
        SizedBox(width: 48),

        // 3) Disabled (light grey, no dot)
        DLRadioButton(
          selected: false,
          enabled: false,
          onChanged: null,
          semanticLabel: 'Disabled radio button',
        ),
      ],
    );
  }
}

/// Separate stateful widget so the first radio is interactive.
class _InteractiveRadioDemo extends StatefulWidget {
  const _InteractiveRadioDemo({super.key});

  @override
  State<_InteractiveRadioDemo> createState() => _InteractiveRadioDemoState();
}

class _InteractiveRadioDemoState extends State<_InteractiveRadioDemo> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return DLRadioButton(
      selected: _selected,
      enabled: true,
      onChanged: (_) {
        setState(() => _selected = !_selected);
      },
      semanticLabel: 'Interactive demo radio button',
    );
  }
}

/// Active (selected) sample – enabled but we ignore interaction visually.
class _ActiveRadioSample extends StatelessWidget {
  const _ActiveRadioSample({super.key});

  @override
  Widget build(BuildContext context) {
    return DLRadioButton(
      selected: true,
      enabled: true,
      // Pass a no-op callback so the control is NOT treated as disabled.
      onChanged: (_) {},
      semanticLabel: 'Active radio button sample',
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

const _radioCodeSample = '''// 1) Default (interactive)
class _InteractiveRadioDemo extends StatefulWidget {
  const _InteractiveRadioDemo({super.key});

  @override
  State<_InteractiveRadioDemo> createState() =>
      _InteractiveRadioDemoState();
}

class _InteractiveRadioDemoState extends State<_InteractiveRadioDemo> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return DLRadioButton(
      selected: _selected,
      enabled: true,
      onChanged: (_) {
        setState(() => _selected = !_selected);
      },
    );
  }
}

// 2) Active (selected)
DLRadioButton(
  selected: true,
  enabled: true,
  onChanged: (_) {}, // no-op to keep it enabled
);

// 3) Disabled
const DLRadioButton(
  selected: false,
  enabled: false,
  onChanged: null,
);
''';
