import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Internal factories (kept for reuse)
// ─────────────────────────────────────────────────────────────────────────────

class DynamicLayers {
  DynamicLayers._();
  static _ButtonFactory get buttons => _ButtonFactory._();
  static _DockFactory get dock => const _DockFactory._();
  static _SeparatorFactory get separator => const _SeparatorFactory._();
  static _AccordionFactory get accordion => const _AccordionFactory._();
  static _AlertFactory get alert => const _AlertFactory._();
  static _BadgeFactory get badge => const _BadgeFactory._();
  static _AvatarFactory get avatar => const _AvatarFactory._();
  static _AvatarGroupFactory get avatarGroup => const _AvatarGroupFactory._();
}

class _ButtonFactory {
  _ButtonFactory._();

  /// Generic entry – used by `DLButton`.
  Widget call({
    // type
    required DLButtonType type,

    // shared content
    String label = 'Button field',
    Widget? iconLeft,
    Widget? iconRight,

    // behavior
    VoidCallback? onPressed,
    bool enabled = true,

    // visuals (shared)
    DLButtonSize size = DLButtonSize.lg,
    DLButtonState state = DLButtonState.normal,
    double? width,
    double? height,
    double? radius,
    double? gap,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? foregroundColor,

    // borders (for secondary/tertiary)
    Color? borderColor,
    double? borderWidth,

    // ghost underline
    double? underlineThickness,
    Color? underlineColor,

    // layout
    bool fixedWidth = false,

    // primary-only affordances (kept for parity; available to all)
    bool affordanceTextForIcons = false,
    String plusAffordance = ' +',
    String ellipsisAffordance = ' …',
  }) {
    // Everything funnels into the unified DLButton
    return DLButton(
      type: type,
      label: label,
      iconLeft: iconLeft,
      iconRight: iconRight,
      onPressed: onPressed,
      enabled: enabled,
      size: size,

      width: width,
      height: height,
      radius: radius ?? DLButtonTokens.defaultRadius,
      gap: gap ?? DLButtonTokens.defaultGap,
      padding: padding ?? DLButtonTokens.padding(size),

      fixedWidth: fixedWidth,
      affordanceTextForIcons: affordanceTextForIcons,
      plusAffordance: plusAffordance,
      ellipsisAffordance: ellipsisAffordance,
    );
  }

  // Specific convenience creators (kept for API parity)
  Widget primary({
    String label = 'Button field',
    Widget? iconLeft,
    Widget? iconRight,
    VoidCallback? onPressed,
    bool enabled = true,
    DLButtonSize size = DLButtonSize.lg,
    DLButtonState state = DLButtonState.normal,
    double? width,
    double? height,
    double? radius,
    double? gap,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    bool fixedWidth = false,
    bool affordanceTextForIcons = false,
    String plusAffordance = ' +',
    String ellipsisAffordance = ' …',
  }) {
    return call(
      type: DLButtonType.primary,
      label: label,
      iconLeft: iconLeft,
      iconRight: iconRight,
      onPressed: onPressed,
      enabled: enabled,
      size: size,
      state: state,
      width: width,
      height: height,
      radius: radius,
      gap: gap,
      padding: padding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      fixedWidth: fixedWidth,
      affordanceTextForIcons: affordanceTextForIcons,
      plusAffordance: plusAffordance,
      ellipsisAffordance: ellipsisAffordance,
    );
  }

  Widget secondary({
    String label = 'Button field',
    Widget? iconLeft,
    Widget? iconRight,
    VoidCallback? onPressed,
    bool enabled = true,
    DLButtonSize size = DLButtonSize.lg,
    DLButtonState state = DLButtonState.normal,
    double? width,
    double? height,
    double? radius,
    double? gap,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double? borderWidth,
    bool fixedWidth = false,
  }) {
    return call(
      type: DLButtonType.secondary,
      label: label,
      iconLeft: iconLeft,
      iconRight: iconRight,
      onPressed: onPressed,
      enabled: enabled,
      size: size,
      state: state,
      width: width,
      height: height,
      radius: radius,
      gap: gap,
      padding: padding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      fixedWidth: fixedWidth,
    );
  }

  Widget tertiary({
    String label = 'Button field',
    Widget? iconLeft,
    Widget? iconRight,
    VoidCallback? onPressed,
    bool enabled = true,
    DLButtonSize size = DLButtonSize.lg,
    DLButtonState state = DLButtonState.normal,
    double? width,
    double? height,
    double? radius,
    double? gap,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double? borderWidth,
    bool fixedWidth = false,
  }) {
    return call(
      type: DLButtonType.tertiary,
      label: label,
      iconLeft: iconLeft,
      iconRight: iconRight,
      onPressed: onPressed,
      enabled: enabled,
      size: size,
      state: state,
      width: width,
      height: height,
      radius: radius,
      gap: gap,
      padding: padding,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      fixedWidth: fixedWidth,
    );
  }

  Widget ghost({
    String label = 'Button field',
    Widget? iconLeft,
    Widget? iconRight,
    VoidCallback? onPressed,
    bool enabled = true,
    DLButtonSize size = DLButtonSize.lg,
    DLButtonState state = DLButtonState.normal,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    Color? foregroundColor,
    bool fixedWidth = false,
    double? underlineThickness,
    Color? underlineColor,
  }) {
    return call(
      type: DLButtonType.ghost,
      label: label,
      iconLeft: iconLeft,
      iconRight: iconRight,
      onPressed: onPressed,
      enabled: enabled,
      size: size,
      state: state,
      width: width,
      height: height,
      padding: padding,
      foregroundColor: foregroundColor,
      fixedWidth: fixedWidth,
      underlineThickness: underlineThickness,
      underlineColor: underlineColor,
    );
  }
}

class _DockFactory {
  const _DockFactory._();

  Widget call({
    required List<DLButton> buttons,

    // Layout
    Axis direction = Axis.vertical,
    double gap = 0,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    double? width,
    double height = 122,
    double maxContentWidth = 600,

    // Chrome
    Color backgroundColor = Colors.white,
    bool showSeparator = true,
    Color separatorColor = const Color(0x1F000000),
    double separatorThickness = 1.0,
    bool showHomeIndicator = true,
    Color homeIndicatorColor = Colors.black,
    double homeIndicatorWidth = 120,
    double homeIndicatorHeight = 4,
    double homeIndicatorRadius = 999,
    double elevation = 8.0,

    // SafeArea
    bool useSafeArea = true,
  }) {
    return DLButtonDock(
      buttons: buttons,
      direction: direction,

      padding: padding,

      maxContentWidth: maxContentWidth,
      backgroundColor: backgroundColor,
      showSeparator: showSeparator,
      elevation: elevation,
      useSafeArea: useSafeArea,
    );
  }
}

class _SeparatorFactory {
  const _SeparatorFactory._();

  Widget call({
    DLSeparatorDirection direction = DLSeparatorDirection.horizontal,
    double? length,
    double thickness = 1.0,
    Color? color,
    double opacity = 1.0,
    BorderRadiusGeometry? radius,
    EdgeInsetsGeometry? margin,
  }) {
    return DLSeparator(
      direction: direction,
      length: length,
      thickness: thickness,
      color: color,

      radius: radius,
      margin: margin,
    );
  }
}

// NEW: Accordion factory
class _AccordionFactory {
  const _AccordionFactory._();

  Widget call({
    DLAccordionState state = DLAccordionState.collapsed,
    String trigger = 'Accordion',
    String content =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
    bool showSeparator = true,

    // Layout
    double? width,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    EdgeInsetsGeometry headerPadding = EdgeInsets.zero,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.fromLTRB(
      DLSpacing.p0,
      DLSpacing.p12,
      DLSpacing.p0,
      DLSpacing.p12,
    ),

    // Border chrome
    Color borderColor = DLColors.grey200,
    double borderThickness = 1.0,

    // Typography
    TextStyle? triggerStyle,
    TextStyle? contentStyle,
    TextStyle? disabledTriggerStyle,

    // Icons
    Widget? trailingChevron,
    double chevronSize = 20,

    // Animation
    Duration duration = const Duration(milliseconds: 180),
    Curve curve = Curves.easeInOut,

    // Callback
    ValueChanged<bool>? onChanged,
  }) {
    return DLAccordion(
      state: state,
      trigger: trigger,
      content: content,
      showSeparator: showSeparator,
      width: width,

      headerPadding: headerPadding,
      contentPadding: contentPadding,
      borderColor: borderColor,
      borderThickness: borderThickness,
      triggerStyle: triggerStyle,
      contentStyle: contentStyle,
      disabledTriggerStyle: disabledTriggerStyle,
      trailingChevron: trailingChevron,

      duration: duration,
      curve: curve,
      onChanged: onChanged,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Public top-level API (what you asked for)
// ─────────────────────────────────────────────────────────────────────────────
// NEW: Alert factory, returns the card widget
class _AlertFactory {
  const _AlertFactory._();

  Widget call({
    DLAlertType type = DLAlertType.error,
    String title = 'Headline',
    String description =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
    bool showClose = true,
    VoidCallback? onClose,
    Widget? leading,
    double iconSize = 18,
    double badgeSize = 24,

    double width = 343,
    double height = 108,
    EdgeInsetsGeometry padding = const EdgeInsets.all(DLSpacing.p16),
    double radius = DLRadii.lg,
    Color borderColor = DLColors.grey200,
    double borderWidth = 1.0,
    Color backgroundColor = DLColors.white,
    double elevation = 0.0,

    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
  }) {
    return DLAlert(
      type: type,
      title: title,
      description: description,
      showClose: showClose,
      onClose: onClose,
      leading: leading,

      width: width,
      height: height,
      radius: radius,
      borderColor: borderColor,
      borderWidth: borderWidth,
      backgroundColor: backgroundColor,
      titleStyle: titleStyle,
      descriptionStyle: descriptionStyle,
    );
  }
}

class _BadgeFactory {
  const _BadgeFactory._();

  Widget call({
    DLBadgeSize size = DLBadgeSize.md,
    int count = 1,
    Color backgroundColor = DLColors.red500,
    Color foregroundColor = DLColors.white,
    double? minWidth,
    double? height,
    double? horizontalPadding,
  }) {
    return DLBadge(
      size: size,
      count: count,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      minWidth: minWidth,
      height: height,
      horizontalPadding: horizontalPadding,
    );
  }

  /// Overlay on top of [child]
  Widget anchor({
    required Widget child,
    required DLBadge badge,
    Alignment alignment = Alignment.topRight,
    Offset offset = const Offset(0, 0),
    bool showIfZero = false,
  }) {
    return DLBadgeAnchor(
      child: child,
      badge: badge,
      alignment: alignment,
      offset: offset,
      showIfZero: showIfZero,
    );
  }
}

class _AvatarFactory {
  const _AvatarFactory._();

  Widget call({
    DLAvatarType type = DLAvatarType.icon,
    DLAvatarSize size = DLAvatarSize.lg,
    DLAvatarPresence presence = DLAvatarPresence.defaultState,
    String initials = 'Aa',
    ImageProvider? imageProvider,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double borderWidth = DLBorderWidth.w0,
    bool showPresence = false, // default off per your request
    Color presenceOnlineColor = DLColors.green500,
    Color presenceOfflineColor = DLColors.grey300,
    String? tooltip,
  }) {
    return DLAvatar(
      type: type,
      size: size,
      presence: presence,
      initials: initials,
      imageProvider: imageProvider,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      showPresence: showPresence,
      presenceOnlineColor: presenceOnlineColor,
      presenceOfflineColor: presenceOfflineColor,
      tooltip: tooltip,
    );
  }
}

class _AvatarGroupFactory {
  const _AvatarGroupFactory._();

  Widget call({
    required DLAvatarGroupSize size,
    required List<DLAvatarItem> items,
    int maxVisible = 2,
    int? overflowCount,
    bool showCounterBubble = false,
    TextDirection direction = TextDirection.ltr,
    double? overlapFraction,
    Color? ringColor,
  }) {
    return DLAvatarGroup(
      items: items,
      maxVisible: maxVisible,
      overflowCount: overflowCount,
      showCounterBubble: showCounterBubble,
      direction: direction,
      overlapFraction: overlapFraction,
      ringColor: ringColor,
      groupSize: size,
    );
  }
}

/// Dock helper – use this to build a bottom/side button dock easily.
///
/// Example:
/// ```dart
/// DLDock(
///   buttons: [
///     DLDockButton(label: 'Accept', type: DLButtonType.primary, onPressed: ...),
///     DLDockButton(label: 'Decline', type: DLButtonType.secondary, onPressed: ...),
///   ],
///   direction: Axis.horizontal,
///   gap: 12,
/// );
/// ```
Widget DLDock({
  required List<DLButton> buttons,
  Axis direction = Axis.vertical,
  double gap = 0,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  double? width,
  double height = 122,
  double maxContentWidth = 600,
  Color backgroundColor = Colors.white,
  bool showSeparator = true,
  Color separatorColor = const Color(0x1F000000),
  double separatorThickness = 1.0,
  bool showHomeIndicator = true,
  Color homeIndicatorColor = Colors.black,
  double homeIndicatorWidth = 120,
  double homeIndicatorHeight = 4,
  double homeIndicatorRadius = 999,
  double elevation = 8.0,
  bool useSafeArea = true,
}) {
  return DynamicLayers.dock.call(
    buttons: buttons,
    direction: direction,
    gap: gap,
    padding: padding,
    width: width,
    height: height,
    maxContentWidth: maxContentWidth,
    backgroundColor: backgroundColor,
    showSeparator: showSeparator,
    separatorColor: separatorColor,
    separatorThickness: separatorThickness,
    showHomeIndicator: showHomeIndicator,
    homeIndicatorColor: homeIndicatorColor,
    homeIndicatorWidth: homeIndicatorWidth,
    homeIndicatorHeight: homeIndicatorHeight,
    homeIndicatorRadius: homeIndicatorRadius,
    elevation: elevation,
    useSafeArea: useSafeArea,
  );
}

/// Uppercase alias if you prefer `DLDOCK(...)`.
Widget DLDOCK({
  required List<DLButton> buttons,
  Axis direction = Axis.vertical,
  double gap = 0,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  double? width,
  double height = 122,
  double maxContentWidth = 600,
  Color backgroundColor = Colors.white,
  bool showSeparator = true,
  Color separatorColor = const Color(0x1F000000),
  double separatorThickness = 1.0,
  bool showHomeIndicator = true,
  Color homeIndicatorColor = Colors.black,
  double homeIndicatorWidth = 120,
  double homeIndicatorHeight = 4,
  double homeIndicatorRadius = 999,
  double elevation = 8.0,
  bool useSafeArea = true,
}) {
  return DLDock(
    buttons: buttons,
    direction: direction,
    gap: gap,
    padding: padding,
    width: width,
    height: height,
    maxContentWidth: maxContentWidth,
    backgroundColor: backgroundColor,
    showSeparator: showSeparator,
    separatorColor: separatorColor,
    separatorThickness: separatorThickness,
    showHomeIndicator: showHomeIndicator,
    homeIndicatorColor: homeIndicatorColor,
    homeIndicatorWidth: homeIndicatorWidth,
    homeIndicatorHeight: homeIndicatorHeight,
    homeIndicatorRadius: homeIndicatorRadius,
    elevation: elevation,
    useSafeArea: useSafeArea,
  );
}

// NOTE: You can already use the widget `DLSeparator(...)` directly.
// If you want the factory defaults, keep using `DynamicLayers.separator(...)`.
// If you also want a function alias, uncomment below:

/*
/// Convenience alias mirroring the factory defaults.
/// (Disabled by default to avoid naming shadow with the DLSeparator widget type.)
Widget DLSeparatorFactory({
  DLSeparatorDirection direction = DLSeparatorDirection.horizontal,
  double? length,
  double thickness = 1.0,
  Color? color,
  double opacity = 1.0,
  BorderRadiusGeometry? radius,
  EdgeInsetsGeometry? margin,
}) {
  return DynamicLayers.separator.call(
    direction: direction,
    length: length,
    thickness: thickness,
    color: color,
    opacity: opacity,
    radius: radius,
    margin: margin,
  );
}
*/
