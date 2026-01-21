import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoSliderPage extends StatelessWidget {
  const DemoSliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Slider states'),
          SizedBox(height: 8),
          _PreviewBlock(child: _SliderPreview(), code: _sliderCodeSample),
        ],
      ),
    );
  }
}

class _SliderPreview extends StatefulWidget {
  const _SliderPreview();

  @override
  State<_SliderPreview> createState() => _SliderPreviewState();
}

class _SliderPreviewState extends State<_SliderPreview> {
  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SubHeader('Static (default)'),
        const SizedBox(height: 12),
        const DLSlider(
          state: DLSliderState.defaultState,
          width: 343,
          trackHeight: 4,
        ),
        const SizedBox(height: 24),

        const _SubHeader('Static (filled)'),
        const SizedBox(height: 12),
        const DLSlider(state: DLSliderState.filled, width: 343, trackHeight: 4),
        const SizedBox(height: 24),

        const _SubHeader('Interactive (drag)'),
        const SizedBox(height: 12),
        DLSlider(
          width: 343,
          trackHeight: 4,
          value: _value,
          onChanged: (v) => setState(() => _value = v),
        ),
      ],
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

const _sliderCodeSample = '''// Default (0%)
const DLSlider(
  state: DLSliderState.defaultState,
  width: 343,
  trackHeight: 4,
);

// Filled (100%)
const DLSlider(
  state: DLSliderState.filled,
  width: 343,
  trackHeight: 4,
);

// Interactive (0..1)
class _SliderDemo extends StatefulWidget {
  const _SliderDemo();

  @override
  State<_SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<_SliderDemo> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return DLSlider(
      width: 343,
      trackHeight: 4,
      value: value,
      onChanged: (v) => setState(() => value = v),
    );
  }
}
''';
