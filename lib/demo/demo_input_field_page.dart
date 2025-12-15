// lib/demo/demo_input_field_page.dart
import 'package:flutter/material.dart';

import '../dynamiclayers.dart';
import '../src/components/input/dl_input_field.dart';

class DemoInputFieldPage extends StatelessWidget {
  const DemoInputFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Input Field — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Default'),
          SizedBox(height: 8),
          _DefaultPreview(),
          SizedBox(height: 24),

          _SectionHeader('Error'),
          SizedBox(height: 8),
          _ErrorPreview(),
          SizedBox(height: 24),

          _SectionHeader('Success'),
          SizedBox(height: 8),
          _SuccessPreview(),
          SizedBox(height: 24),

          _SectionHeader('Disabled'),
          SizedBox(height: 8),
          _DisabledPreview(),
          SizedBox(height: 24),

          _SubHeader('How to use'),
          SizedBox(height: 8),
          _CodeBox(code: _inputUsageCode),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW – DEFAULT (empty + filled)
/// ---------------------------------------------------------------------------

class _DefaultPreview extends StatelessWidget {
  const _DefaultPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            // Default (empty, placeholder only)
            const DLInputField(
              size: DLInputFieldSize.lg,
              placeholder: 'Input Field',
            ),

            // Filled (label + value – black border)
            DLInputField(
              size: DLInputFieldSize.lg,
              label: 'Input Field',
              controller: TextEditingController(text: 'Input Title'),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW – ERROR (empty + filled)
/// ---------------------------------------------------------------------------

class _ErrorPreview extends StatelessWidget {
  const _ErrorPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            // Error – empty
            const DLInputField(
              size: DLInputFieldSize.lg,
              type: DLInputFieldType.error,
              placeholder: 'Input Field',
              errorText: '* Description',
            ),

            // Error – filled
            DLInputField(
              size: DLInputFieldSize.lg,
              type: DLInputFieldType.error,
              label: 'Input Field',
              controller: TextEditingController(text: 'Input Title'),
              errorText: '* Description',
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW – SUCCESS (empty + filled)
/// ---------------------------------------------------------------------------

class _SuccessPreview extends StatelessWidget {
  const _SuccessPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            // Success – empty
            const DLInputField(
              size: DLInputFieldSize.lg,
              type: DLInputFieldType.success,
              placeholder: 'Input Field',
            ),

            // Success – filled
            DLInputField(
              size: DLInputFieldSize.lg,
              type: DLInputFieldType.success,
              label: 'Input Field',
              controller: TextEditingController(text: 'Input Title'),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW – DISABLED (only empty – no filled state)
/// ---------------------------------------------------------------------------

class _DisabledPreview extends StatelessWidget {
  const _DisabledPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: const DLInputField(
          size: DLInputFieldSize.lg,
          type: DLInputFieldType.disabled,
          placeholder: 'Input Field',
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Shared helpers
/// ---------------------------------------------------------------------------

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

/// ---------------------------------------------------------------------------
/// "How to use" snippet
/// ---------------------------------------------------------------------------

const String _inputUsageCode = '''
// Default (lg, placeholder only)
const DLInputField(
  size: DLInputFieldSize.lg,
  placeholder: 'Input Field',
);

// With floating label + initial value (shows border)
DLInputField(
  size: DLInputFieldSize.lg,
  label: 'Input Field',
  controller: TextEditingController(text: 'Input Title'),
);

// Error with description
const DLInputField(
  size: DLInputFieldSize.lg,
  type: DLInputFieldType.error,
  placeholder: 'Input Field',
  errorText: '* Description',
);

// Success
const DLInputField(
  size: DLInputFieldSize.lg,
  type: DLInputFieldType.success,
  placeholder: 'Input Field',
);

// Disabled
const DLInputField(
  size: DLInputFieldSize.lg,
  type: DLInputFieldType.disabled,
  placeholder: 'Input Field',
);
''';
