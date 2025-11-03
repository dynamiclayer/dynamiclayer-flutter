import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoBottomSheetPage extends StatelessWidget {
  const DemoBottomSheetPage({super.key});

  static const _lorem =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy '
      'eirmod tempor invidunt ut labore et dolore.';

  static const _loremLong =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy '
      'eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam '
      'voluptua. At vero eos et accusam et justo duo dolores et ea rebum. '
      'Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';

  static const _loremVeryLong =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy '
      'eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam '
      'voluptua. ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Sheet — Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _Section('Default (no buttons)'),
          const SizedBox(height: 8),
          _PreviewBox(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _PrimaryBtn(
                  label: 'Default',
                  onPressed: () => _showDefault(context),
                ),
                _SecondaryBtn(
                  label: 'With long text',
                  onPressed: () => _showDefault(context, longDesc: true),
                ),
                _TertiaryBtn(
                  label: 'Very long (scroll)',
                  onPressed: () =>
                      _showDefault(context, customDesc: _loremVeryLong),
                ),
                _TertiaryBtn(
                  label: 'No headline/desc',
                  onPressed: () => _showDefault(
                    context,
                    showHeadline: false,
                    showDescription: false,
                  ),
                ),
                _GhostBtn(
                  label: 'No indicator',
                  onPressed: () =>
                      _showDefault(context, showHomeIndicator: false),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const _Section('Single Button'),
          const SizedBox(height: 8),
          _PreviewBox(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _PrimaryBtn(
                  label: 'Primary action',
                  onPressed: () => _showSingle(context),
                ),
                _SecondaryBtn(
                  label: 'Custom illustration',
                  onPressed: () =>
                      _showSingle(context, illustration: _demoIllustration()),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const _Section('Double Button'),
          const SizedBox(height: 8),
          _PreviewBox(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _PrimaryBtn(
                  label: 'Primary + Secondary',
                  onPressed: () => _showDouble(context),
                ),
                _SecondaryBtn(
                  label: 'Long content + both',
                  onPressed: () => _showDouble(context, longDesc: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Helpers to show each variant
  // ───────────────────────────────────────────────────────────────────────────

  static void _showDefault(
    BuildContext context, {
    bool showHeadline = true,
    bool showDescription = true,
    bool showHomeIndicator = true,
    bool longDesc = false,
    String? customDesc,
  }) {
    DLBottomSheet.show(
      context,
      type: DLBottomSheetType.defaultType,
      title: 'Title',
      showHeadline: showHeadline,
      headlineText: 'Headline',
      showDescription: showDescription,
      descriptionText: customDesc ?? (longDesc ? _loremLong : _lorem),
      showHomeIndicator: showHomeIndicator,
      // Wrap content height (no big empty space):
      isScrollControlled: false,
    );
  }

  static void _showSingle(BuildContext context, {Widget? illustration}) {
    DLBottomSheet.show(
      context,
      type: DLBottomSheetType.singleButton,
      title: 'Title',
      headlineText: 'Headline',
      descriptionText: _lorem,
      illustration: illustration,
      primaryLabel: 'Button',
      primaryType: DLButtonType.primary,
      onPrimaryPressed: () => Navigator.of(context).maybePop(),
      // Wrap content height:
      isScrollControlled: false,
    );
  }

  static void _showDouble(BuildContext context, {bool longDesc = false}) {
    DLBottomSheet.show(
      context,
      type: DLBottomSheetType.doubleButton,
      title: 'Title',
      headlineText: 'Headline',
      descriptionText: longDesc ? _loremLong : _lorem,
      primaryLabel: 'Button',
      primaryType: DLButtonType.primary,
      onPrimaryPressed: () => Navigator.of(context).maybePop(),
      secondaryLabel: 'Button',
      secondaryType: DLButtonType.secondary,
      onSecondaryPressed: () => Navigator.of(context).maybePop(),
      // Wrap content height:
      isScrollControlled: false,
    );
  }

  static Widget _demoIllustration() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: DLColors.grey200,
        borderRadius: DLRadii.brMd,
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.image, color: DLColors.grey600),
    );
  }
}

/// ---------- Simple “normal” button wrappers (to roughly match your styles) ----------
class _PrimaryBtn extends StatelessWidget {
  const _PrimaryBtn({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label),
    );
  }
}

class _SecondaryBtn extends StatelessWidget {
  const _SecondaryBtn({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(120, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label),
    );
  }
}

class _TertiaryBtn extends StatelessWidget {
  const _TertiaryBtn({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(120, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label),
    );
  }
}

class _GhostBtn extends StatelessWidget {
  const _GhostBtn({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Simple text-only look (like a ghost link)
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: const Size(120, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        foregroundColor: Theme.of(context).colorScheme.primary,
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
