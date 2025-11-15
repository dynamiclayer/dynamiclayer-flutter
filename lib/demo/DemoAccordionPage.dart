import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

/// Demo page showing 3 Accordion states:
/// 1) Default (collapsed)
/// 2) Expanded
/// 3) Disabled
class DemoAccordionPage extends StatelessWidget {
  const DemoAccordionPage({super.key});

  static const _lorem =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy '
      'eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accordion — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('1) Default (collapsed)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _AccordionDefault(),
            code: _accordionDefaultCode,
          ),
          SizedBox(height: 24),

          _SectionHeader('2) Expanded'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _AccordionExpanded(),
            code: _accordionExpandedCode,
          ),
          SizedBox(height: 24),

          _SectionHeader('3) Disabled'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _AccordionDisabled(),
            code: _accordionDisabledCode,
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// 1) Default (collapsed)
/// ---------------------------------------------------------------------------
class _AccordionDefault extends StatelessWidget {
  const _AccordionDefault();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 343,
        child: DLAccordion(
          state: DLAccordionState.collapsed,
          trigger: 'Accordion',
          content: DemoAccordionPage._lorem,
          showSeparator: true,
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// 2) Expanded
/// ---------------------------------------------------------------------------
class _AccordionExpanded extends StatelessWidget {
  const _AccordionExpanded();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 343,
        child: DLAccordion(
          state: DLAccordionState.expanded,
          trigger: 'Accordion',
          content: DemoAccordionPage._lorem,
          borderColor: DLColors.grey200,
          showTopBorder: false,
          borderThickness: 1.0,
          headerPadding: const EdgeInsets.symmetric(vertical: 14),
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// 3) Disabled
/// ---------------------------------------------------------------------------
class _AccordionDisabled extends StatelessWidget {
  const _AccordionDisabled();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 343,
        child: DLAccordion(
          state: DLAccordionState.disabled,
          trigger: 'Accordion',
          content: DemoAccordionPage._lorem,
          showTopBorder: false,
          borderColor: DLColors.grey200,
          borderThickness: 1.0,
          headerPadding: const EdgeInsets.symmetric(vertical: 14),
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        ),
      ),
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
const _accordionDefaultCode = '''
// 1) Default (collapsed)
DLAccordion(
  state: DLAccordionState.collapsed,
  trigger: 'Accordion',
  content:
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy '
      'eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
  showSeparator: true,
  showTopBorder: false,
  borderColor: DLColors.grey200,
  borderThickness: 1.0,
  headerPadding: EdgeInsets.symmetric(vertical: 14),
  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 12),
);
''';

const _accordionExpandedCode = '''
// 2) Expanded
DLAccordion(
  state: DLAccordionState.expanded,
  trigger: 'Accordion',
  content:
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy '
      'eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
  showTopBorder: false,
  borderColor: DLColors.grey200,
  borderThickness: 1.0,
  headerPadding: EdgeInsets.symmetric(vertical: 14),
  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 12),
);
''';

const _accordionDisabledCode = '''
// 3) Disabled
DLAccordion(
  state: DLAccordionState.disabled,
  trigger: 'Accordion',
  content:
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy '
      'eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
  showTopBorder: false,
  borderColor: DLColors.grey200,
  borderThickness: 1.0,
  headerPadding: EdgeInsets.symmetric(vertical: 14),
  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 12),
);
''';
