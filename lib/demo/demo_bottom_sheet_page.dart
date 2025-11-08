import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoBottomSheetPage extends StatelessWidget {
  const DemoBottomSheetPage({super.key});

  static const _lorem =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy '
      'eirmod tempor invidunt ut labore et dolore.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Sheet — Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Section('Default (no buttons)'),
          SizedBox(height: 8),
          _PreviewBox(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _PrimaryBtn(label: 'Default', onPressed: _showDefault),
              ],
            ),
          ),

          SizedBox(height: 24),
          _Section('Single Button'),
          SizedBox(height: 8),
          _PreviewBox(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _PrimaryBtn(label: 'Primary action', onPressed: _showSingle),
              ],
            ),
          ),

          SizedBox(height: 24),
          _Section('Double Button'),
          SizedBox(height: 8),
          _PreviewBox(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _PrimaryBtn(
                  label: 'Primary + Secondary',
                  onPressed: _showDouble,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Tap handlers
  // ───────────────────────────────────────────────────────────────────────────
  static void _showDefault(BuildContext context) => DLBottomSheet.show(
    context,
    type: DLBottomSheetType.defaultType,
    title: 'Title',
    showHeadline: true,
    headlineText: 'Headline',
    showDescription: true,
    descriptionText: _lorem,
    isScrollControlled: false,
  );

  static void _showSingle(BuildContext context) => DLBottomSheet.show(
    context,
    type: DLBottomSheetType.singleButton,
    title: 'Title',
    headlineText: 'Headline',
    descriptionText: _lorem,
    primaryLabel: 'Button',
    primaryType: DLButtonType.primary,
    onPrimaryPressed: () => Navigator.of(context).maybePop(),
    isScrollControlled: false,
  );

  static void _showDouble(BuildContext context) => DLBottomSheet.show(
    context,
    type: DLBottomSheetType.doubleButton,
    title: 'Title',
    headlineText: 'Headline',
    descriptionText: _lorem,
    primaryLabel: 'Button',
    primaryType: DLButtonType.primary,
    onPrimaryPressed: () => Navigator.of(context).maybePop(),
    secondaryLabel: 'Button',
    secondaryType: DLButtonType.secondary,
    onSecondaryPressed: () => Navigator.of(context).maybePop(),
    isScrollControlled: false,
  );
}

/// ---------- Simple “normal” button (hug content; no fixed height) ----------
class _PrimaryBtn extends StatelessWidget {
  const _PrimaryBtn({required this.label, required this.onPressed});
  final String label;
  final void Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      child: Text(label),
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
    // Soft surface background; no borders/rounded frame.
    return DecoratedBox(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
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
