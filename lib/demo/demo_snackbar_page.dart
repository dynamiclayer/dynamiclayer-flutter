import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoSnackbarPage extends StatelessWidget {
  const DemoSnackbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Snackbar — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Snackbar variants'),
          SizedBox(height: 8),
          _PreviewBlock(child: _SnackbarPreview(), code: _snackbarCodeSample),
        ],
      ),
    );
  }
}

class _SnackbarPreview extends StatelessWidget {
  const _SnackbarPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: const [
        DLSnackbar(type: DLSnackbarType.success, label: 'Label'),
        DLSnackbar(type: DLSnackbarType.error, label: 'Label'),
        DLSnackbar(type: DLSnackbarType.warning, label: 'Label'),
        DLSnackbar(type: DLSnackbarType.info, label: 'Label'),
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

const _snackbarCodeSample = '''// Success
const DLSnackbar(
  type: DLSnackbarType.success,
  label: 'Label',
);

// Error
const DLSnackbar(
  type: DLSnackbarType.error,
  label: 'Label',
);

// Warning
const DLSnackbar(
  type: DLSnackbarType.warning,
  label: 'Label',
);

// Info
const DLSnackbar(
  type: DLSnackbarType.info,
  label: 'Label',
);

// Optional tap
DLSnackbar(
  type: DLSnackbarType.success,
  label: 'Saved',
  onTap: () {
    // handle tap
  },
);
''';
