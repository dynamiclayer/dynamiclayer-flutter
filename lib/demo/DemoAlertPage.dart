import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoAlertPage extends StatelessWidget {
  const DemoAlertPage({super.key});

  static const _lorem =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts — Inline Cards')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _Section('Inline cards'),
          const SizedBox(height: 8),
          _PreviewBox(
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                DynamicLayers.alert(
                  type: DLAlertType.error,
                  title: 'Headline',
                  description: _lorem,
                ),
                DynamicLayers.alert(
                  type: DLAlertType.success,
                  title: 'Headline',
                  description: _lorem,
                ),
                DynamicLayers.alert(
                  type: DLAlertType.warning,
                  title: 'Headline',
                  description: _lorem,
                ),
                DynamicLayers.alert(
                  type: DLAlertType.info,
                  title: 'Headline',
                  description: _lorem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------- UI helpers ----------
class _Section extends StatelessWidget {
  const _Section(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _PreviewBox extends StatelessWidget {
  const _PreviewBox({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 740),
            child: child,
          ),
        ),
      ),
    );
  }
}
