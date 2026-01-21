import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/segmented_control/dl_segmented_control.dart';

class DemoSegmentedControlPage extends StatelessWidget {
  const DemoSegmentedControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segmented Control — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Segmented Control'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _SegmentedControlPreview(),
            code: _segmentedControlCodeSample,
          ),
          SizedBox(height: 24),
          _SectionHeader('Segmented Control Tab'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _SegmentedControlTabPreview(),
            code: _segmentedControlTabCodeSample,
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW 1: Segmented Control (outer container + slide indicator)
/// ---------------------------------------------------------------------------

class _SegmentedControlPreview extends StatelessWidget {
  const _SegmentedControlPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SubHeader('Count = 2 (interactive)'),
        SizedBox(height: 8),
        _InteractiveSegments(count: 2),
        SizedBox(height: 24),

        _SubHeader('Count = 3 (interactive)'),
        SizedBox(height: 8),
        _InteractiveSegments(count: 3),
        SizedBox(height: 24),

        _SubHeader('Count = 4 (interactive)'),
        SizedBox(height: 8),
        _InteractiveSegments(count: 4),
        SizedBox(height: 24),

        _SubHeader('Disabled'),
        SizedBox(height: 8),
        _DisabledSegmentsSample(),
      ],
    );
  }
}

class _InteractiveSegments extends StatefulWidget {
  const _InteractiveSegments({super.key, required this.count});
  final int count;

  @override
  State<_InteractiveSegments> createState() => _InteractiveSegmentsState();
}

class _InteractiveSegmentsState extends State<_InteractiveSegments> {
  int _selected = 0;

  List<DLSegmentItem> get _items =>
      List.generate(widget.count, (_) => const DLSegmentItem(label: 'Value'));

  @override
  Widget build(BuildContext context) {
    return DLSegmentedControl(
      items: _items,
      selectedIndex: _selected,
      onChanged: (i) => setState(() => _selected = i),
      width: 343,
      height: 36,
      innerHeight: 28,
      outerPadding: const EdgeInsets.all(4),
    );
  }
}

class _DisabledSegmentsSample extends StatelessWidget {
  const _DisabledSegmentsSample({super.key});

  @override
  Widget build(BuildContext context) {
    return DLSegmentedControl(
      state: DLSegmentedControlState.disabled,
      items: const [
        DLSegmentItem(label: 'Value'),
        DLSegmentItem(label: 'Value'),
        DLSegmentItem(label: 'Value'),
      ],
      selectedIndex: 0,
      onChanged: (_) {},
      width: 343,
      height: 36,
      innerHeight: 28,
      outerPadding: const EdgeInsets.all(4),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW 2: Segmented Control Tab (single pill item)
/// ---------------------------------------------------------------------------

class _SegmentedControlTabPreview extends StatelessWidget {
  const _SegmentedControlTabPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SubHeader('States'),
        SizedBox(height: 8),
        _TabStatesRow(),
        SizedBox(height: 24),
        _SubHeader('Interactive (tap to select)'),
        SizedBox(height: 8),
        _InteractiveTabRow(),
      ],
    );
  }
}

class _TabStatesRow extends StatelessWidget {
  const _TabStatesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        IntrinsicWidth(
          child: DLSegmentedControlTab(
            label: 'Value',
            state: DLSegmentedControlTabState.selected,
            onTap: null,
          ),
        ),
        SizedBox(width: 24),
        IntrinsicWidth(
          child: DLSegmentedControlTab(
            label: 'Value',
            state: DLSegmentedControlTabState.defaultState,
            onTap: null,
          ),
        ),
        SizedBox(width: 24),
        IntrinsicWidth(
          child: DLSegmentedControlTab(
            label: 'Value',
            state: DLSegmentedControlTabState.disabled,
            onTap: null,
          ),
        ),
      ],
    );
  }
}

class _InteractiveTabRow extends StatefulWidget {
  const _InteractiveTabRow({super.key});

  @override
  State<_InteractiveTabRow> createState() => _InteractiveTabRowState();
}

class _InteractiveTabRowState extends State<_InteractiveTabRow> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicWidth(
          child: DLSegmentedControlTab(
            label: 'Value',
            state: _selected == 0
                ? DLSegmentedControlTabState.selected
                : DLSegmentedControlTabState.defaultState,
            onTap: () => setState(() => _selected = 0),
          ),
        ),
        const SizedBox(width: 24),
        IntrinsicWidth(
          child: DLSegmentedControlTab(
            label: 'Value',
            state: _selected == 1
                ? DLSegmentedControlTabState.selected
                : DLSegmentedControlTabState.defaultState,
            onTap: () => setState(() => _selected = 1),
          ),
        ),
        const SizedBox(width: 24),
        const IntrinsicWidth(
          child: DLSegmentedControlTab(
            label: 'Value',
            state: DLSegmentedControlTabState.disabled,
            onTap: null,
          ),
        ),
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

/// ---------- Code samples shown in the docs ---------------------------------

const _segmentedControlCodeSample =
    '''// Segmented Control (2..4 segments) with animated indicator
class _InteractiveSegments extends StatefulWidget {
  const _InteractiveSegments({super.key, required this.count});
  final int count;

  @override
  State<_InteractiveSegments> createState() => _InteractiveSegmentsState();
}

class _InteractiveSegmentsState extends State<_InteractiveSegments> {
  int _selected = 0;

  List<DLSegmentItem> get _items => List.generate(
        widget.count,
        (_) => const DLSegmentItem(label: 'Value'),
      );

  @override
  Widget build(BuildContext context) {
    return DLSegmentedControl(
      items: _items,
      selectedIndex: _selected,
      onChanged: (i) => setState(() => _selected = i),
      width: 343,
      height: 36,
      innerHeight: 28,
      outerPadding: const EdgeInsets.all(4),
    );
  }
}

// Disabled segmented control
DLSegmentedControl(
  state: DLSegmentedControlState.disabled,
  items: const [
    DLSegmentItem(label: 'Value'),
    DLSegmentItem(label: 'Value'),
    DLSegmentItem(label: 'Value'),
  ],
  selectedIndex: 0,
  onChanged: (_) {},
);
''';

const _segmentedControlTabCodeSample = '''// Segmented Control Tab (single pill)
DLSegmentedControlTab(
  label: 'Value',
  state: DLSegmentedControlTabState.selected,
  onTap: () {},
);

DLSegmentedControlTab(
  label: 'Value',
  state: DLSegmentedControlTabState.defaultState,
  onTap: () {},
);

const DLSegmentedControlTab(
  label: 'Value',
  state: DLSegmentedControlTabState.disabled,
  onTap: null,
);

// Interactive row
class _InteractiveTabRow extends StatefulWidget {
  const _InteractiveTabRow({super.key});

  @override
  State<_InteractiveTabRow> createState() => _InteractiveTabRowState();
}

class _InteractiveTabRowState extends State<_InteractiveTabRow> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      children: [
        DLSegmentedControlTab(
          label: 'Value',
          state: _selected == 0
              ? DLSegmentedControlTabState.selected
              : DLSegmentedControlTabState.defaultState,
          onTap: () => setState(() => _selected = 0),
        ),
        DLSegmentedControlTab(
          label: 'Value',
          state: _selected == 1
              ? DLSegmentedControlTabState.selected
              : DLSegmentedControlTabState.defaultState,
          onTap: () => setState(() => _selected = 1),
        ),
        const DLSegmentedControlTab(
          label: 'Value',
          state: DLSegmentedControlTabState.disabled,
          onTap: null,
        ),
      ],
    );
  }
}
''';
