// lib/demo/demo_pagination_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/pagination/dl_pagination.dart';

class DemoPaginationPage extends StatelessWidget {
  const DemoPaginationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagination — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Pagination Dot'),
          SizedBox(height: 8),
          _PaginationDotPreview(),
          SizedBox(height: 24),
          _SectionHeader('Pagination'),
          SizedBox(height: 8),
          _PaginationRowPreview(),
          SizedBox(height: 24),
          _SubHeader('How to use'),
          SizedBox(height: 8),
          _CodeBox(code: _paginationUsageCode),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Pagination Dot preview (light + dark)
/// ---------------------------------------------------------------------------

class _PaginationDotPreview extends StatelessWidget {
  const _PaginationDotPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Light
        _BorderedContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              DLPaginationDot(selected: true, mode: DLPaginationMode.light),
              SizedBox(width: 24),
              DLPaginationDot(selected: false, mode: DLPaginationMode.light),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Dark
        Container(
          color: DLColors.black,
          padding: const EdgeInsets.all(16),
          child: _BorderedContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                DLPaginationDot(selected: true, mode: DLPaginationMode.dark),
                SizedBox(width: 24),
                DLPaginationDot(selected: false, mode: DLPaginationMode.dark),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// Pagination row preview (2–5 dots, light + dark, each in its own row)
/// Each row is interactive: tapping a dot makes it active.
/// ---------------------------------------------------------------------------

class _PaginationRowPreview extends StatelessWidget {
  const _PaginationRowPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Light block
        _BorderedContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              _InteractiveDotRow(count: 2, mode: DLPaginationMode.light),
              SizedBox(height: 12),
              _InteractiveDotRow(count: 3, mode: DLPaginationMode.light),
              SizedBox(height: 12),
              _InteractiveDotRow(count: 4, mode: DLPaginationMode.light),
              SizedBox(height: 12),
              _InteractiveDotRow(count: 5, mode: DLPaginationMode.light),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Dark block
        Container(
          color: DLColors.black,
          padding: const EdgeInsets.all(16),
          child: _BorderedContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _InteractiveDotRow(count: 2, mode: DLPaginationMode.dark),
                SizedBox(height: 12),
                _InteractiveDotRow(count: 3, mode: DLPaginationMode.dark),
                SizedBox(height: 12),
                _InteractiveDotRow(count: 4, mode: DLPaginationMode.dark),
                SizedBox(height: 12),
                _InteractiveDotRow(count: 5, mode: DLPaginationMode.dark),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// One interactive row of dots (2–5 dots)
class _InteractiveDotRow extends StatefulWidget {
  const _InteractiveDotRow({super.key, required this.count, required this.mode})
    : assert(count >= 2 && count <= 5);

  final int count;
  final DLPaginationMode mode;

  @override
  State<_InteractiveDotRow> createState() => _InteractiveDotRowState();
}

class _InteractiveDotRowState extends State<_InteractiveDotRow> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.count * 2 - 1, (i) {
          // Even indices → dots, odd indices → spacing
          if (i.isOdd) {
            return const SizedBox(width: 8);
          }
          final dotIndex = i ~/ 2;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() => _activeIndex = dotIndex);
            },
            child: DLPaginationDot(
              selected: dotIndex == _activeIndex,
              mode: widget.mode,
            ),
          );
        }),
      ),
    );
  }
}

/// ---------- Shared demo helpers -------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
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

/// Simple rounded border container (replaces dashed painter)
class _BorderedContainer extends StatelessWidget {
  const _BorderedContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      width: double.infinity,
      child: Center(child: child),
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

/// ---------- "How to use" snippet ------------------------------------------

const String _paginationUsageCode = '''
// Basic usage — 4 dots, index 1 (second dot active), light mode
const DLPagination(
  count: 4,
  activeIndex: 1,
  mode: DLPaginationMode.light,
);

// Expanded usage — 5 dots taking full width, dark mode
Container(
  color: DLColors.black,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: const DLPagination(
    count: 5,
    activeIndex: 2,
    mode: DLPaginationMode.dark,
    expanded: true,
  ),
);

// Manual interactive row using DLPaginationDot directly
class MyDotsRow extends StatefulWidget {
  const MyDotsRow({super.key});

  @override
  State<MyDotsRow> createState() => _MyDotsRowState();
}

class _MyDotsRowState extends State<MyDotsRow> {
  int _active = 0;

  @override
  Widget build(BuildContext context) {
    const count = 4;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count * 2 - 1, (i) {
        if (i.isOdd) return const SizedBox(width: 8);
        final index = i ~/ 2;
        return GestureDetector(
          onTap: () => setState(() => _active = index),
          child: DLPaginationDot(
            selected: index == _active,
            mode: DLPaginationMode.light,
          ),
        );
      }),
    );
  }
}
''';
