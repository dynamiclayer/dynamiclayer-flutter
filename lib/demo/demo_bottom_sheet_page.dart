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
      appBar: AppBar(title: const Text('Bottom Sheet — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Default (no buttons)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _PrimaryBtn(
                  label: 'Default',
                  onPressed: DemoBottomSheetPage._showDefault,
                ),
              ],
            ),
            code: _defaultBottomSheetCode,
          ),

          SizedBox(height: 24),
          _SectionHeader('Single Button'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _PrimaryBtn(
                  label: 'Primary action',
                  onPressed: DemoBottomSheetPage._showSingle,
                ),
              ],
            ),
            code: _singleButtonBottomSheetCode,
          ),

          SizedBox(height: 24),
          _SectionHeader('Double Button'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _PrimaryBtn(
                  label: 'Primary + Secondary',
                  onPressed: DemoBottomSheetPage._showDouble,
                ),
              ],
            ),
            code: _doubleButtonBottomSheetCode,
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
    isScrollControlled: true,
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

/// ---------- DOC UI helpers (same pattern as DemoButtonsCatalogPage) ----------
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
        SizedBox(height: 8),
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
        SizedBox(height: 8),
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
const _defaultBottomSheetCode = '''
// Default (no buttons)
DLBottomSheet.show(
  context,
  type: DLBottomSheetType.defaultType,
  title: 'Title',
  showHeadline: true,
  headlineText: 'Headline',
  showDescription: true,
  descriptionText: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr...',
  isScrollControlled: false,
);
''';

const _singleButtonBottomSheetCode = '''
// Single button bottom sheet
DLBottomSheet.show(
  context,
  type: DLBottomSheetType.singleButton,
  title: 'Title',
  headlineText: 'Headline',
  descriptionText: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr...',
  primaryLabel: 'Button',
  primaryType: DLButtonType.primary,
  onPrimaryPressed: () => Navigator.of(context).maybePop(),
  isScrollControlled: false,
);
''';

const _doubleButtonBottomSheetCode = '''
// Double button bottom sheet
DLBottomSheet.show(
  context,
  type: DLBottomSheetType.doubleButton,
  title: 'Title',
  headlineText: 'Headline',
  descriptionText: 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr...',
  primaryLabel: 'Button',
  primaryType: DLButtonType.primary,
  onPrimaryPressed: () => Navigator.of(context).maybePop(),
  secondaryLabel: 'Button',
  secondaryType: DLButtonType.secondary,
  onSecondaryPressed: () => Navigator.of(context).maybePop(),
  isScrollControlled: true,
);
''';
