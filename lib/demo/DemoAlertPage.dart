import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoAlertPage extends StatelessWidget {
  const DemoAlertPage({super.key});

  static const _lorem =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alerts — Demo')),
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
          const SizedBox(height: 24),

          const _Section('Show as overlay (snackbar-style)'),
          const SizedBox(height: 8),
          _PreviewBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _OverlayButtonsRow(
                  label: 'Bottom overlay',
                  onError: () => _showBottom(context, DLAlertType.error),
                  onSuccess: () => _showBottom(context, DLAlertType.success),
                  onWarning: () => _showBottom(context, DLAlertType.warning),
                  onInfo: () => _showBottom(context, DLAlertType.info),
                ),
                const SizedBox(height: 12),
                _OverlayButtonsRow(
                  label: 'Top overlay',
                  onError: () => _showTop(context, DLAlertType.error),
                  onSuccess: () => _showTop(context, DLAlertType.success),
                  onWarning: () => _showTop(context, DLAlertType.warning),
                  onInfo: () => _showTop(context, DLAlertType.info),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const _Section('Other uses'),
          const SizedBox(height: 8),
          _PreviewBox(
            child: Column(
              children: [
                // Custom leading (any widget: image/asset/network/etc.)
                DynamicLayers.alert(
                  type: DLAlertType.info,
                  title: 'Custom leading',
                  description: 'Uses an arbitrary widget as the leading badge.',
                  leading: Container(
                    width: 28, // match DLAlert badge size
                    height: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: DLColors.violet500,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.flutter_dash,
                      size: 16,
                      color: DLColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // No close button
                DynamicLayers.alert(
                  type: DLAlertType.success,
                  title: 'No close',
                  description: 'Close icon hidden.',
                  showClose: false,
                ),
                const SizedBox(height: 12),
                // Buttons that show short/persistent overlays
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DLButton(
                      type: DLButtonType.secondary,
                      label: 'Short (1.5s)',
                      onPressed: () {
                        DLAlert.show(
                          context,
                          type: DLAlertType.warning,
                          title: 'Heads up',
                          description: 'This disappears quickly.',
                          duration: const Duration(milliseconds: 1500),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    DLButton(
                      type: DLButtonType.primary,
                      label: 'Persistent (close)',
                      onPressed: () {
                        // Duration 0 => remains until closed
                        DLAlert.show(
                          context,
                          type: DLAlertType.info,
                          title: 'Persistent',
                          description: 'Stays until you tap close.',
                          duration: Duration.zero,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom overlay helper
  static void _showBottom(BuildContext context, DLAlertType type) {
    DLAlert.show(
      context,
      type: type,
      title: 'Headline',
      description: _lorem,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      duration: const Duration(milliseconds: 2400),
    );
  }

  // Top overlay helper
  static void _showTop(BuildContext context, DLAlertType type) {
    DLAlert.show(
      context,
      type: type,
      title: 'Headline',
      description: _lorem,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      duration: const Duration(milliseconds: 2400),
    );
  }
}

/// Buttons row that triggers overlays for each type
class _OverlayButtonsRow extends StatelessWidget {
  const _OverlayButtonsRow({
    required this.label,
    required this.onError,
    required this.onSuccess,
    required this.onWarning,
    required this.onInfo,
  });

  final String label;
  final VoidCallback onError;
  final VoidCallback onSuccess;
  final VoidCallback onWarning;
  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            DLButton(
              type: DLButtonType.primary,
              label: 'Error',
              onPressed: onError,
            ),
            DLButton(
              type: DLButtonType.secondary,
              label: 'Success',
              onPressed: onSuccess,
            ),
            DLButton(
              type: DLButtonType.tertiary,
              label: 'Warning',
              onPressed: onWarning,
            ),
            DLButton(
              type: DLButtonType.ghost,
              label: 'Info',
              onPressed: onInfo,
            ),
          ],
        ),
      ],
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
