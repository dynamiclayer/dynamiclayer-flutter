import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoAlertPage extends StatelessWidget {
  const DemoAlertPage({super.key});

  static const _lorem =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Inline cards (some with close button off)'),
          SizedBox(height: 8),
          _PreviewBlock(child: _InlineAlertsPreview(), code: _inlineAlertsCode),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Inline Alerts Preview
/// ---------------------------------------------------------------------------
class _InlineAlertsPreview extends StatelessWidget {
  const _InlineAlertsPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: const [
        // error — close hidden
        _AlertErrorNoClose(),
        // success — close visible (default)
        _AlertSuccess(),
        // warning — close hidden
        _AlertWarningNoClose(),
        // info — close visible (default)
        _AlertInfo(),
      ],
    );
  }
}

class _AlertErrorNoClose extends StatelessWidget {
  const _AlertErrorNoClose();

  @override
  Widget build(BuildContext context) {
    return DLAlert(
      type: DLAlertType.error,
      title: 'Headline',
      description: DemoAlertPage._lorem,
      showClose: false,
    );
  }
}

class _AlertSuccess extends StatelessWidget {
  const _AlertSuccess();

  @override
  Widget build(BuildContext context) {
    return DLAlert(
      type: DLAlertType.success,
      title: 'Headline',
      description: DemoAlertPage._lorem,
      // uses default close behavior
    );
  }
}

class _AlertWarningNoClose extends StatelessWidget {
  const _AlertWarningNoClose();

  @override
  Widget build(BuildContext context) {
    return DLAlert(
      type: DLAlertType.warning,
      title: 'Headline',
      description: DemoAlertPage._lorem,
      showClose: false,
    );
  }
}

class _AlertInfo extends StatelessWidget {
  const _AlertInfo();

  @override
  Widget build(BuildContext context) {
    return DLAlert(
      type: DLAlertType.info,
      title: 'Headline',
      description: DemoAlertPage._lorem,
      // uses default close behavior
    );
  }
}

/// ---------- DOC UI helpers (same pattern as other catalog pages) ----------
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
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
  const _PreviewBlock({required this.child, required this.code});
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
  const _SubHeader(this.title);
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
  const _CodeBox({required this.code});
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

/// ---------- Code Samples ----------
const _inlineAlertsCode = '''
// Inline cards with different types and close behavior
Wrap(
  spacing: 16,
  runSpacing: 16,
  children: [
    // Error (close hidden)
    DLAlert(
      type: DLAlertType.error,
      title: 'Headline',
      description: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
      showClose: false,
    ),

    // Success (close visible — default)
   DLAlert(
      type: DLAlertType.success,
      title: 'Headline',
      description: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
    ),

    // Warning (close hidden)
    DLAlert(
      type: DLAlertType.warning,
      title: 'Headline',
      description: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
      showClose: false,
    ),

    // Info (close visible — default)
    DLAlert(
      type: DLAlertType.info,
      title: 'Headline',
      description: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
    ),
  ],
);
''';
