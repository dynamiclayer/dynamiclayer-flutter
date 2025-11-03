import 'package:flutter/material.dart';
import '../../../../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers – Accordion
/// ---------------------------------------------------------------------------
/// States:
/// - collapsed (default)
/// - expanded
/// - disabled  (title shows strike-through, muted colors, no interaction)
///
/// Visuals:
/// - 1px top & bottom borders (grey200 by default)
/// - Optional internal separator (DLSeparator) between header and content
/// - Chevron rotates on expand/collapse
///
/// Usage:
/// DLAccordion(
///   trigger: 'Accordion',
///   content: 'Lorem ipsum…',
///   state: DLAccordionState.collapsed, // or expanded / disabled
///   showSeparator: true,
/// )
enum DLAccordionState { collapsed, expanded, disabled }

class DLAccordion extends StatefulWidget {
  const DLAccordion({
    super.key,
    this.state = DLAccordionState.collapsed,
    this.trigger = 'Accordion',
    this.content =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
    this.showSeparator = true,

    // Layout
    this.width,
    this.padding = EdgeInsets.zero,
    this.headerPadding = const EdgeInsets.symmetric(
      horizontal: DLSpacing.p0,
      vertical: DLSpacing.p0,
    ),
    this.contentPadding = const EdgeInsets.fromLTRB(
      DLSpacing.p0,
      DLSpacing.p12,
      DLSpacing.p0,
      DLSpacing.p12,
    ),

    // Border chrome
    this.borderColor = DLColors.grey200,
    this.borderThickness = 1.0,

    // Typography
    this.triggerStyle,
    this.contentStyle,
    this.disabledTriggerStyle,

    // Icons
    this.trailingChevron,
    this.chevronSize = 20,

    // Animation
    this.duration = const Duration(milliseconds: 180),
    this.curve = Curves.easeInOut,

    // Callbacks
    this.onChanged,
  });

  /// Initial visual state.
  final DLAccordionState state;

  /// Header text (left aligned).
  final String trigger;

  /// Body text shown when expanded.
  final String content;

  /// Show a thin separator line between header and content (via DLSeparator).
  final bool showSeparator;

  /// Optional fixed width for the whole widget (otherwise expands to parent).
  final double? width;

  /// Outer padding around the whole accordion container.
  final EdgeInsetsGeometry padding;

  /// Padding for the header row.
  final EdgeInsetsGeometry headerPadding;

  /// Padding for the content area (when expanded).
  final EdgeInsetsGeometry contentPadding;

  /// Border color for top & bottom.
  final Color borderColor;

  /// Border thickness for top & bottom.
  final double borderThickness;

  /// Style overrides.
  final TextStyle? triggerStyle;
  final TextStyle? disabledTriggerStyle;
  final TextStyle? contentStyle;

  /// Custom trailing chevron (defaults to Icons.expand_more).
  final Widget? trailingChevron;
  final double chevronSize;

  /// Expand/collapse animation.
  final Duration duration;
  final Curve curve;

  /// Emits `true` when expanded, `false` when collapsed.
  final ValueChanged<bool>? onChanged;

  @override
  State<DLAccordion> createState() => _DLAccordionState();
}

class _DLAccordionState extends State<DLAccordion>
    with SingleTickerProviderStateMixin {
  late bool _expanded;

  bool get _disabled => widget.state == DLAccordionState.disabled;

  @override
  void initState() {
    super.initState();
    _expanded = widget.state == DLAccordionState.expanded;
  }

  void _toggle() {
    if (_disabled) return;
    setState(() => _expanded = !_expanded);
    widget.onChanged?.call(_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final baseTriggerStyle =
        widget.triggerStyle ?? DLTypos.textBaseBold(color: DLColors.black);
    final disabledTriggerStyle =
        widget.disabledTriggerStyle ??
        DLTypos.textBaseBold(
          color: DLColors.grey600,
        ).copyWith(decoration: TextDecoration.lineThrough);
    final contentStyle =
        widget.contentStyle ?? DLTypos.textSmRegular(color: DLColors.grey700);

    final chevron =
        widget.trailingChevron ??
        Icon(
          Icons.expand_more,
          size: widget.chevronSize,
          color: _disabled ? DLColors.grey600 : DLColors.black,
        );

    final header = InkWell(
      onTap: _disabled ? null : _toggle,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: widget.headerPadding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.trigger,
                style: _disabled ? disabledTriggerStyle : baseTriggerStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AnimatedRotation(
              turns: _expanded ? 0.5 : 0, // 0 -> down, 0.5 -> up
              duration: widget.duration,
              curve: widget.curve,
              child: chevron,
            ),
          ],
        ),
      ),
    );

    final separator = widget.showSeparator
        ? Padding(
            padding: const EdgeInsets.only(top: DLSpacing.p8),
            child: DLSeparator(
              direction: DLSeparatorDirection.horizontal,
              thickness: 1.0,
              color: DLColors.grey200,
              opacity: 1.0,
            ),
          )
        : const SizedBox.shrink();

    final body = ClipRect(
      child: AnimatedSize(
        duration: widget.duration,
        curve: widget.curve,
        child: _expanded
            ? Padding(
                padding: widget.contentPadding,
                child: Text(widget.content, style: contentStyle),
              )
            : const SizedBox.shrink(),
      ),
    );

    final container = Container(
      width: widget.width,
      padding: widget.padding,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: widget.borderColor,
            width: widget.borderThickness,
          ),
          bottom: BorderSide(
            color: widget.borderColor,
            width: widget.borderThickness,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [header, if (widget.showSeparator) separator, body],
      ),
    );

    return container;
  }
}
