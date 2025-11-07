import 'package:flutter/material.dart';
import '../../../../dynamiclayers.dart';

enum DLAccordionState { collapsed, expanded, disabled }

class DLAccordion extends StatefulWidget {
  const DLAccordion({
    super.key,
    this.state = DLAccordionState.collapsed,
    this.trigger = 'Accordion',
    this.content =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
    this.showSeparator = false,
    this.showTopBorder = true,
    this.showBottomBorder = true,

    // Layout
    this.width,
    // keep API the same but we'll only honor LEFT/RIGHT to guarantee 48 height
    this.headerPadding = const EdgeInsets.symmetric(horizontal: DLSpacing.p0),
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

  final DLAccordionState state;
  final String trigger;
  final String content;

  final bool showSeparator;
  final bool showTopBorder;
  final bool showBottomBorder;

  final double? width;
  final EdgeInsetsGeometry headerPadding; // horizontal only is applied
  final EdgeInsetsGeometry contentPadding;

  final Color borderColor;
  final double borderThickness;

  final TextStyle? triggerStyle;
  final TextStyle? disabledTriggerStyle;
  final TextStyle? contentStyle;

  final Widget? trailingChevron;
  final double chevronSize;

  final Duration duration;
  final Curve curve;

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
    // Inter Medium (w500)
    final baseTriggerStyle =
        (widget.triggerStyle ?? DLTypos.textBaseRegular(color: DLColors.black))
            .copyWith(fontFamily: 'Inter', fontWeight: FontWeight.w500);

    final disabledTriggerStyle =
        (widget.disabledTriggerStyle ??
                DLTypos.textBaseRegular(color: DLColors.grey600))
            .copyWith(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.lineThrough,
            );

    final contentStyle =
        widget.contentStyle ?? DLTypos.textSmRegular(color: DLColors.grey700);

    final chevron =
        widget.trailingChevron ??
        Icon(
          Icons.expand_more,
          size: widget.chevronSize,
          color: _disabled ? DLColors.grey600 : DLColors.black,
        );

    // Resolve header padding but apply only LEFT/RIGHT to keep exact 48 height
    final resolved = widget.headerPadding.resolve(Directionality.of(context));
    final horizontalOnly = EdgeInsets.only(
      left: resolved.left,
      right: resolved.right,
    );

    // ---- Header: EXACT 48px (padding inside, horizontal only)
    final header = InkWell(
      onTap: _disabled ? null : _toggle,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SizedBox(
        height: 48, // ✅ fixed height
        child: Padding(
          padding: horizontalOnly,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.trigger,
                    style: _disabled ? disabledTriggerStyle : baseTriggerStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0.0,
                duration: widget.duration,
                curve: widget.curve,
                child: SizedBox(
                  width: widget.chevronSize,
                  height: widget.chevronSize,
                  child: Center(child: chevron),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Optional internal separator (only when expanded to avoid double borders)
    final separator = (widget.showSeparator && _expanded)
        ? Padding(
            padding: const EdgeInsets.only(top: DLSpacing.p8),
            child: DLSeparator(
              direction: DLSeparatorDirection.horizontal,
              thickness: 1.0,
              color: DLColors.grey200,
            ),
          )
        : const SizedBox.shrink();

    // Fade-in from top for content
    final body = AnimatedSwitcher(
      duration: widget.duration,
      switchInCurve: widget.curve,
      switchOutCurve: widget.curve,
      transitionBuilder: (child, anim) {
        final slide = Tween<Offset>(
          begin: const Offset(0, -0.05),
          end: Offset.zero,
        ).animate(anim);
        return FadeTransition(
          opacity: anim,
          child: SlideTransition(position: slide, child: child),
        );
      },
      child: _expanded
          ? Padding(
              key: const ValueKey('expanded'),
              padding: widget.contentPadding,
              child: Text(widget.content, style: contentStyle),
            )
          : const SizedBox.shrink(key: ValueKey('collapsed')),
    );

    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: widget.showTopBorder
                ? widget.borderColor
                : Colors.transparent,
            width: widget.showTopBorder ? widget.borderThickness : 0,
          ),
          bottom: BorderSide(
            color: widget.showBottomBorder
                ? widget.borderColor
                : Colors.transparent,
            width: widget.showBottomBorder ? widget.borderThickness : 0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [header, if (widget.showSeparator) separator, body],
      ),
    );
  }
}
