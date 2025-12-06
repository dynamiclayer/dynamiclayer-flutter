import 'package:dynamiclayer_flutter/demo/DemoBadgePage.dart';
import 'package:dynamiclayer_flutter/demo/demo_separator_page.dart';
import 'package:flutter/material.dart';

// Your demos
import 'DemoAccordionPage.dart';
import 'DemoAlertPage.dart';
import 'DemoAvatarGroupPage.dart';
import 'DemoAvatarPage.dart';
import 'bottom_nav/demo_bottom_nav_bar_page.dart';
import 'bottom_nav/demo_bottom_nav_tab_page.dart';
import 'buttons_demo.dart'; // ButtonsDemoHome
import 'demo_bottom_sheet_page.dart';
import 'demo_button_dock_page.dart';
import 'demo_calendar_page.dart';
import 'demo_card_page.dart';
import 'demo_checkbox_page.dart';
import 'demo_chip_page.dart';
import 'demo_coach_mark_page.dart';
import 'demo_icon_button_page.dart';
import 'demo_input_field_page.dart';
import 'demo_input_otp_page.dart';
import 'demo_line_item_message_page.dart';
import 'demo_line_item_page.dart';
import 'demo_loading_button_page.dart';
import 'demo_loading_dots_page.dart';
import 'demo_message_dock_page.dart';
import 'demo_message_loading_page.dart';
import 'demo_message_page.dart';
import 'demo_pagination_page.dart';
import 'demo_pin_keyboard_page.dart';
import 'demo_radio_button_page.dart';
import 'demo_switch_page.dart';
import 'demo_timed_button_page.dart'; // DemoButtonDockPage

/// Central hub to open any demo screen — now responsive & polished.
class DemoHubPage extends StatefulWidget {
  const DemoHubPage({super.key});

  @override
  State<DemoHubPage> createState() => _DemoHubPageState();
}

class _DemoHubPageState extends State<DemoHubPage> {
  final _controller = TextEditingController();
  String _query = '';

  List<_DemoEntry> get _entries => <_DemoEntry>[
    _DemoEntry(
      title: 'Input',
      subtitle: '39 variants',
      builder: DemoInputFieldPage.new,
    ),
    _DemoEntry(
      title: 'Line Item',
      subtitle: 'including Checkbox, Radio Button, Switch, Button, Seperator',
      builder: DemoLineItemPage.new,
    ),
    _DemoEntry(
      title: 'Line Item Messgae',
      subtitle: 'inc. Seperator, avatar, avatar group, badge',
      builder: DemoLineItemMessagePage.new,
    ),
    _DemoEntry(
      title: 'Input OTP',
      subtitle: 'Visual state of a single OTP cell',
      builder: DemoInputOtpPage.new,
    ),
    _DemoEntry(
      title: 'Coach Mark',
      subtitle: 'top,bottom,left right',
      builder: DemoCoachMarkPage.new,
    ),
    _DemoEntry(
      title: 'Message Dock',
      subtitle: 'default, active',
      builder: DemoMessageDockPage.new,
    ),
    _DemoEntry(
      title: 'Message loading',
      subtitle: 'dot, loading',
      builder: DemoMessageLoadingPage.new,
    ),
    _DemoEntry(
      title: 'Message',
      subtitle: 'other /own, single/ response',
      builder: DemoMessagePage.new,
    ),
    _DemoEntry(
      title: 'Switch',
      subtitle: 'Default, active',
      builder: DemoSwitchPage.new,
    ),
    _DemoEntry(
      title: 'Pagination',
      subtitle: 'Dot, Pagination',
      builder: DemoPaginationPage.new,
    ),
    _DemoEntry(
      title: 'Pin Keyboard',
      subtitle: 'text, Icon',
      builder: DemoPinKeyboardPage.new,
    ),
    _DemoEntry(
      title: 'Chip',
      subtitle: 'Default, active, disable',
      builder: DemoChipPage.new,
    ),
    _DemoEntry(
      title: 'Radio Button',
      subtitle: 'Default, active, disable',
      builder: DemoRadioButtonPage.new,
    ),
    _DemoEntry(
      title: 'Calender',
      subtitle: 'Default, Calender item',
      builder: DemoCalendarPage.new,
    ),
    _DemoEntry(
      title: 'Checkbox',
      subtitle: 'Default, Active, Disabled',
      builder: DemoCheckboxPage.new,
    ),
    _DemoEntry(
      title: 'Card  — Catalog & Variants',
      subtitle: 'Default, Active, Disabled',
      builder: DemoCardPage.new,
    ),
    _DemoEntry(
      title: 'Buttons Icon — Catalog & Variants',
      subtitle: 'Primary / Secondary / Tertiary  sizes, states, icons',
      builder: DemoIconButtonPage.new,
    ),
    _DemoEntry(
      title: 'Buttons Loading — Catalog & Variants',
      subtitle: 'Primary / Secondary / Tertiary / Ghost,  sizes, states, icons',
      builder: DemoLoadingButtonPage.new,
    ),
    _DemoEntry(
      title: 'Loading Dots',
      subtitle: 'Animation',
      builder: DemoLoadingDotsPage.new,
    ),
    _DemoEntry(
      title: 'Buttons Timed — Catalog & Variants',
      subtitle: 'Timer goes down, Animation',
      builder: DemoTimedButtonPage.new,
    ),
    _DemoEntry(
      title: 'Buttons — Catalog & Variants',
      subtitle: 'Primary / Secondary / Tertiary / Ghost, sizes, states, icons',
      builder: ButtonsDemoHome.new,
    ),
    _DemoEntry(
      title: 'Button Dock — Sticky Actions',
      subtitle: 'Always-visible 1–N actions, horizontal/vertical, separator',
      builder: DemoButtonDockPage.new,
    ),
    _DemoEntry(
      title: 'Separator Demo',
      subtitle: 'Vertical and horizontal',
      builder: DemoSeparatorPage.new,
    ),
    _DemoEntry(
      title: 'Accordion Demo',
      subtitle: 'Default, expanded, disabled',
      builder: DemoAccordionPage.new,
    ),
    _DemoEntry(
      title: 'Alert Demo',
      subtitle: 'Error, success, warning, info + overlay helper',
      builder: DemoAlertPage.new,
    ),
    _DemoEntry(
      title: 'Bottom Sheet Demo',
      subtitle: 'Default, Single Button, Double Button',
      builder: DemoBottomSheetPage.new,
    ),
    _DemoEntry(
      title: 'Badge Demo',
      subtitle: 'Standalone counts and anchored dots',
      builder: DemoBadgePage.new,
    ),
    _DemoEntry(
      title: 'Avatar Demo',
      subtitle: 'Initials, image, presence',
      builder: DemoAvatarPage.new,
    ),
    _DemoEntry(
      title: 'Avatar Group Demo',
      subtitle: 'Row & diagonal with counter',
      builder: DemoAvatarGroupPage.new,
    ),
    _DemoEntry(
      title: 'Bottom Nav Tab Demo',
      subtitle: 'Label, icon, badge, disabled',
      builder: DemoBottomNavTabPage.new,
    ),
    _DemoEntry(
      title: 'Bottom Navigation Demo',
      subtitle: '2 / 3 / 4 tabs with labels',
      builder: DemoBottomNavBarPage.new,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_DemoEntry> _filtered(List<_DemoEntry> all) {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return all;
    return all.where((e) {
      return e.title.toLowerCase().contains(q) ||
          e.subtitle.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = _filtered(_entries);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DynamicLayers — Demo Hub'),
        centerTitle: false,
      ),
      body: CustomScrollView(
        slivers: [
          // Sticky search
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            toolbarHeight: 72,
            backgroundColor: theme.scaffoldBackgroundColor,
            flexibleSpace: SafeArea(
              bottom: false,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: TextField(
                    controller: _controller,
                    onChanged: (v) => setState(() => _query = v),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search demos…',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Header + count
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Row(
                  children: [
                    Text(
                      'All Demos',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _CountPill(count: entries.length),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),

          // Responsive grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverLayoutBuilder(
              builder: (context, constraints) {
                final max = constraints.crossAxisExtent;
                // Simple breakpoints
                final cols = max >= 1280
                    ? 4
                    : max >= 1000
                    ? 3
                    : max >= 680
                    ? 2
                    : 1;
                return SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1280),
                      child: _ResponsiveGrid(
                        columns: cols,
                        itemCount: entries.length,
                        itemBuilder: (context, i) {
                          final e = entries[i];
                          return _DemoCard(
                            title: e.title,
                            subtitle: e.subtitle,
                            icon: e.icon ?? _inferIcon(e.title),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => e.builder()),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- Widgets -----------------------------------------------------------------

class _DemoCard extends StatefulWidget {
  const _DemoCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.icon,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  State<_DemoCard> createState() => _DemoCardState();
}

class _DemoCardState extends State<_DemoCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseBorder = BorderSide(
      color: isDark ? Colors.white12 : Colors.black12,
      width: 1,
    );

    final elevation = _hover ? 2.0 : 0.0;

    return FocusableActionDetector(
      mouseCursor: SystemMouseCursors.click,
      onShowHoverHighlight: (v) => setState(() => _hover = v),
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (intent) {
            widget.onTap();
            return null;
          },
        ),
      },
      child: Card(
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.fromBorderSide(baseBorder),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Leading icon avatar
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withOpacity(.04),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(widget.icon ?? Icons.widgets_outlined, size: 24),
                ),
                const SizedBox(width: 14),
                // Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(
                            0.65,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 20,
                  color: theme.iconTheme.color?.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResponsiveGrid extends StatelessWidget {
  const _ResponsiveGrid({
    required this.columns,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int columns;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    final spacing = 14.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final itemWidth =
            (width - (spacing * (columns - 1))) / columns.toDouble();

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(itemCount, (i) {
            return SizedBox(width: itemWidth, child: itemBuilder(context, i));
          }),
        );
      },
    );
  }
}

class _CountPill extends StatelessWidget {
  const _CountPill({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.white12 : Colors.black.withOpacity(.06),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$count',
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// --- Model -------------------------------------------------------------------

class _DemoEntry {
  _DemoEntry({
    required this.title,
    required this.subtitle,
    required this.builder,
    this.icon,
  });

  final String title;
  final String subtitle;
  final Widget Function() builder;
  final IconData? icon;
}

// --- Helpers -----------------------------------------------------------------

IconData _inferIcon(String title) {
  final t = title.toLowerCase();
  if (t.contains('button') && t.contains('dock')) return Icons.space_bar;
  if (t.contains('button')) return Icons.radio_button_checked_outlined;
  if (t.contains('badge')) return Icons.brightness_1_outlined;
  if (t.contains('avatar') && t.contains('group')) return Icons.group_outlined;
  if (t.contains('avatar')) return Icons.account_circle_outlined;
  if (t.contains('alert')) return Icons.notification_important_outlined;
  if (t.contains('accordion')) return Icons.view_agenda_outlined;
  if (t.contains('separator')) return Icons.straighten_outlined;
  if (t.contains('bottom nav tab')) return Icons.tab_outlined;
  if (t.contains('bottom navigation')) return Icons.explore_outlined;
  if (t.contains('bottom sheet')) return Icons.vertical_align_top_outlined;
  if (t.contains('Calender')) return Icons.calendar_month;
  return Icons.widgets_outlined;
}
