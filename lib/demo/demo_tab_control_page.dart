import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/tab_control/dl_tab_control.dart';
import '../src/components/tab_control/dl_tab_control_tab.dart';

class DemoTabControlPage extends StatelessWidget {
  const DemoTabControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab Control — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Tab Control Tab'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _TabControlTabPreview(),
            code: _tabControlTabCodeSample,
          ),
          SizedBox(height: 24),
          _SectionHeader('Tab Control'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _TabControlPreview(),
            code: _tabControlCodeSample,
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Preview 1: Tab Control Tab (row of 3 items: selected / default / disabled)
/// baseline must be ONE connected line, not per-item
/// ---------------------------------------------------------------------------
class _TabControlTabPreview extends StatelessWidget {
  const _TabControlTabPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        SizedBox(
          width: 111, // matches figma (hug ~111)
          child: DLTabControlTab(
            label: 'Value',
            state: DLTabControlTabState.selected,
            badge: false,
            onTap: _noop,
          ),
        ),
        SizedBox(width: 10), // <-- break between underline segments
        SizedBox(
          width: 111,
          child: DLTabControlTab(
            label: 'Value',
            state: DLTabControlTabState.defaultState,
            badge: false,
            onTap: _noop,
          ),
        ),
        SizedBox(width: 10), // <-- break between underline segments
        SizedBox(
          width: 111,
          child: DLTabControlTab(
            label: 'Value',
            state: DLTabControlTabState.disabled,
            badge: false,
            onTap: null,
          ),
        ),
      ],
    );
  }
}

void _noop() {}

/// A helper that draws the one connected baseline + one selected indicator,
/// but uses your explicit tab states (selected/default/disabled).
class _SingleRowWithBaseline extends StatelessWidget {
  const _SingleRowWithBaseline({
    required this.children,
    required this.selectedIndex,
  });

  final List<Widget> children;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    const baselineH = 2.0;

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final count = children.length;
        final segW = w / count;

        return SizedBox(
          height: 56,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(height: baselineH, color: DLColors.grey200),
              ),
              Positioned(
                left: segW * selectedIndex,
                bottom: 0,
                child: Container(
                  width: segW,
                  height: baselineH,
                  color: DLColors.black,
                ),
              ),
              Row(
                children: children
                    .map((w) => Expanded(child: w))
                    .toList(growable: false),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------------------
/// Preview 2: Tab Control (NO disabled tabs)
/// ---------------------------------------------------------------------------

class _TabControlPreview extends StatefulWidget {
  const _TabControlPreview();

  @override
  State<_TabControlPreview> createState() => _TabControlPreviewState();
}

class _TabControlPreviewState extends State<_TabControlPreview> {
  int selectedIndex2 = 0;
  int selectedIndex3 = 1;
  int selectedIndex4 = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DLTabControl(
          labels: const ['Value', 'Value'],
          selectedIndex: selectedIndex2,
          onChanged: (i) => setState(() => selectedIndex2 = i),
        ),
        const SizedBox(height: 24),
        DLTabControl(
          labels: const ['Value', 'Value', 'Value'],
          selectedIndex: selectedIndex3,
          onChanged: (i) => setState(() => selectedIndex3 = i),
        ),
        const SizedBox(height: 24),
        DLTabControl(
          labels: const ['Value', 'Value', 'Value', 'Value'],
          selectedIndex: selectedIndex4,
          onChanged: (i) => setState(() => selectedIndex4 = i),
        ),
      ],
    );
  }
}

/// ---------- DOC UI helpers (same pattern as your catalog pages) ----------

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

/// ---------- Code samples shown in docs ---------------------------------

const _tabControlTabCodeSample =
    '''// Tab Control Tab (row preview: selected / default / disabled)
Row(
  children: [
    Expanded(
      child: DLTabControlTab(
        label: 'Value',
        state: DLTabControlTabState.selected,
        badge: false,
        onTap: () {},
      ),
    ),
    Expanded(
      child: DLTabControlTab(
        label: 'Value',
        state: DLTabControlTabState.defaultState,
        badge: false,
        onTap: () {},
      ),
    ),
    Expanded(
      child: DLTabControlTab(
        label: 'Value',
        state: DLTabControlTabState.disabled,
        badge: false,
        onTap: null,
      ),
    ),
  ],
);
''';

const _tabControlCodeSample = '''// Tab Control (no disabled tabs)
class _Demo extends StatefulWidget {
  const _Demo();

  @override
  State<_Demo> createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DLTabControl(
      labels: const ['Value', 'Value', 'Value'],
      selectedIndex: selectedIndex,
      onChanged: (i) => setState(() => selectedIndex = i),
    );
  }
}
''';
