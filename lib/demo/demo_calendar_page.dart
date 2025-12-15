// lib/demo/demo_calendar_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/calendar/dl_calendar_item.dart';
import '../src/components/calendar/dl_calendar_month.dart';

class DemoCalendarPage extends StatelessWidget {
  const DemoCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Calendar item states'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _CalendarItemStatesPreview(),
            code: _calendarItemCode,
          ),
          SizedBox(height: 24),
          _SectionHeader('Month grid (no spacing + range selection)'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _CalendarMonthPreview(),
            code: _calendarMonthCode,
          ),
        ],
      ),
    );
  }
}

class _CalendarItemStatesPreview extends StatelessWidget {
  const _CalendarItemStatesPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [
        DLCalendarItem(day: 1, state: DLCalendarItemState.normal),
        DLCalendarItem(day: 1, state: DLCalendarItemState.unselect),
        DLCalendarItem(day: 1, state: DLCalendarItemState.selected),
        DLCalendarItem(day: 1, state: DLCalendarItemState.active),
        DLCalendarItem(day: 1, state: DLCalendarItemState.disabled),
      ],
    );
  }
}

class _CalendarMonthPreview extends StatelessWidget {
  const _CalendarMonthPreview();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final month = DateTime(now.year, now.month);

    return DLCalendarMonth(
      month: month,
      initialSelectedDay: 1,
      onRangeSelected: (range) {
        // optional: debugPrint('Range: ${range.start} - ${range.end}');
      },
    );
  }
}

/// ---------- DOC UI helpers (unchanged) ----------

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

const _calendarItemCode = '''
// Calendar item states row
Wrap(
  spacing: 24,
  runSpacing: 12,
  children: const [
    DLCalendarItem(day: 1, state: DLCalendarItemState.normal),
    DLCalendarItem(day: 1, state: DLCalendarItemState.unselect),
    DLCalendarItem(day: 1, state: DLCalendarItemState.selected),
    DLCalendarItem(day: 1, state: DLCalendarItemState.active),
    DLCalendarItem(day: 1, state: DLCalendarItemState.disabled),
  ],
);
''';

const _calendarMonthCode = '''
// Month grid with NO spacing + range selection logic
DLCalendarMonth(
  month: DateTime(2024, 4),
  initialSelectedDay: 1,
  onRangeSelected: (range) {
    debugPrint('Range: \${range.start} - \${range.end}');
  },
);
''';
