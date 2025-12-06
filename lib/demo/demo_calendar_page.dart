// lib/demo/demo_calendar_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/calendar/dl_calendar_item.dart';
import '../src/components/calendar/dl_calendar_month.dart'; // exports DLCalendarItem, DLCalendarMonth, tokens

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
          _SectionHeader('Month grid'),
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

/// ---------------------------------------------------------------------------
/// 1) Calendar item states (row)
/// ---------------------------------------------------------------------------

class _CalendarItemStatesPreview extends StatelessWidget {
  const _CalendarItemStatesPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [
        // default / normal
        DLCalendarItem(day: 1, state: DLCalendarItemState.normal),
        // unselect (grey text)
        DLCalendarItem(day: 1, state: DLCalendarItemState.unselect),
        // selected (grey bg)
        DLCalendarItem(day: 1, state: DLCalendarItemState.selected),
        // active (black bg, white text)
        DLCalendarItem(day: 1, state: DLCalendarItemState.active),
        // disabled (light text)
        DLCalendarItem(day: 1, state: DLCalendarItemState.disabled),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// 2) Month grid preview
/// ---------------------------------------------------------------------------

class _CalendarMonthPreview extends StatelessWidget {
  const _CalendarMonthPreview();

  @override
  Widget build(BuildContext context) {
    // Example month (any month/year is fine)
    final now = DateTime.now();
    final month = DateTime(now.year, now.month);

    return DLCalendarMonth(
      month: month,
      initialSelectedDay: 1,
      onDaySelected: (date) {
        // ignore for demo; you can log or show a snackbar here
      },
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

/// ---------- Code samples shown in the docs --------------------------------

const _calendarItemCode = '''
// Calendar item states row
Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: const [
    DLCalendarItem(
      day: 1,
      state: DLCalendarItemState.normal,
    ),
    SizedBox(width: 24),
    DLCalendarItem(
      day: 1,
      state: DLCalendarItemState.unselect,
    ),
    SizedBox(width: 24),
    DLCalendarItem(
      day: 1,
      state: DLCalendarItemState.selected,
    ),
    SizedBox(width: 24),
    DLCalendarItem(
      day: 1,
      state: DLCalendarItemState.active,
    ),
    SizedBox(width: 24),
    DLCalendarItem(
      day: 1,
      state: DLCalendarItemState.disabled,
    ),
  ],
);
''';

const _calendarMonthCode = '''
// Simple month grid using DLCalendarMonth
DLCalendarMonth(
  month: DateTime(2024, 4), // April 2024
  initialSelectedDay: 1,
  onDaySelected: (date) {
    debugPrint('Selected: \$date');
  },
);
''';
