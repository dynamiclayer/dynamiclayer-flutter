import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../dynamiclayers.dart';
import '../../../generated/assets.dart';

enum DLAccordionState { collapsed, expanded, disabled }

class DLAccordion extends StatefulWidget {
  const DLAccordion({
    super.key,
    this.state = DLAccordionState.collapsed,
    this.trigger = 'Accordion',
    this.content =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',

    // Borders
    this.showTopBorder = false,
    this.showBottomBorder = true,

    // Layout
    this.width,
    // header: horizontal padding from here, vertical via [headerVerticalPadding]
    this.headerPadding = const EdgeInsets.symmetric(horizontal: DLSpacing.p0),
    this.headerVerticalPadding = DLSpacing.p12,
    this.contentPadding = const EdgeInsets.fromLTRB(
      DLSpacing.p0,
      DLSpacing.p12,
      DLSpacing.p0,
      DLSpacing.p12,
    ),

    this.borderColor = DLColors.grey200,
    this.borderThickness = 1.0,

    // Typography
    this.triggerStyle,
    this.contentStyle,
    this.disabledTriggerStyle,

    // Icons
    this.trailingChevron,

    // Animation
    this.duration = const Duration(milliseconds: 180),
    this.curve = Curves.easeInOut,

    // Callback
    this.onChanged,

    // Kept for backward compatibility; no longer used.
    this.showSeparator = false,
  });

  final DLAccordionState state;
  final String trigger;
  final String content;

  // kept but unused (middle separator removed)
  final bool showSeparator;

  final bool showTopBorder;
  final bool showBottomBorder;

  final double? width;
  final EdgeInsetsGeometry headerPadding; // applies L/R
  final double headerVerticalPadding;
  final EdgeInsetsGeometry contentPadding;

  final Color borderColor;
  final double borderThickness;

  final TextStyle? triggerStyle;
  final TextStyle? disabledTriggerStyle;
  final TextStyle? contentStyle;

  /// Optional custom chevron widget (overrides default SVG).
  final Widget? trailingChevron;

  final Duration duration;
  final Curve curve;

  final ValueChanged<bool>? onChanged;

  @override
  State<DLAccordion> createState() => _DLAccordionState();
}

class _DLAccordionState extends State<DLAccordion> {
  static const String _chevronAsset = Assets.accordionAccordionChevron;

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

  TextStyle get _baseTriggerStyle {
    // Inter, medium – overriding any system default
    return (widget.triggerStyle ??
            DLTypos.textBaseMedium(color: DLColors.black))
        .copyWith(fontFamily: 'Inter', fontWeight: FontWeight.w500);
  }

  TextStyle get _disabledTriggerTextStyle {
    return (widget.disabledTriggerStyle ??
            DLTypos.textBaseMedium(color: DLColors.grey600))
        .copyWith(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.lineThrough,
        );
  }

  TextStyle get _contentTextStyle {
    // Inter for body text as well
    return (widget.contentStyle ??
        DLTypos.textSmRegular(color: DLColors.grey700));
  }

  Widget _buildChevron() {
    if (widget.trailingChevron != null) {
      return widget.trailingChevron!;
    }

    final Color color = _disabled ? DLColors.grey600 : DLColors.black;

    return SvgPicture.asset(
      _chevronAsset,
      width: 12,
      height: 9,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Resolve paddings
    final headerResolved = widget.headerPadding.resolve(
      Directionality.of(context),
    );
    final headerHorizontalOnly = EdgeInsets.only(
      left: headerResolved.left,
      right: headerResolved.right,
    );

    // Header: min height 48, but grows for multi-line headline
    final header = InkWell(
      onTap: _disabled ? null : _toggle,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Padding(
          padding: headerHorizontalOnly.add(
            EdgeInsets.symmetric(vertical: widget.headerVerticalPadding),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Headline: allow multiple lines, no ellipsis
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.trigger,
                    style: _disabled
                        ? _disabledTriggerTextStyle
                        : _baseTriggerStyle,
                    softWrap: true,
                  ),
                ),
              ),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0.0,
                duration: widget.duration,
                curve: widget.curve,
                child: SizedBox(
                  width: 12,
                  height: 9,
                  child: Center(child: _buildChevron()),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Body (no middle separator)
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
              padding: EdgeInsets.only(bottom: DLSpacing.p12),
              child: Text(
                key: const ValueKey('expanded'),
                widget.content,
                style: _contentTextStyle,
                softWrap: true,
              ),
            )
          : const SizedBox.shrink(key: ValueKey('collapsed')),
    );

    // Only top + bottom borders (bottom acts as separator)
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
      child: Column(mainAxisSize: MainAxisSize.min, children: [header, body]),
    );
  }
}
