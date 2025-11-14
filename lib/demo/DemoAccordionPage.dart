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
      appBar: AppBar(title: const Text('Accordion — 3 States')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Section('1) Default (collapsed)'),
          SizedBox(height: 8),
          _PreviewBox(child: _AccordionDefault()),
          SizedBox(height: 24),

          _Section('2) Expanded'),
          SizedBox(height: 8),
          _PreviewBox(child: _AccordionExpanded()),
          SizedBox(height: 24),

          _Section('3) Disabled'),
          SizedBox(height: 8),
          _PreviewBox(child: _AccordionDisabled()),
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
          showTopBorder: false,
          // borders & layout as per your spec
          borderColor: DLColors.grey200,
          borderThickness: 1.0,
          headerPadding: const EdgeInsets.symmetric(vertical: 14),
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
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
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}
