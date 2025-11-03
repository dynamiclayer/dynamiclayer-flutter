import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers – Alert (tokenized + overlay helper)
/// ---------------------------------------------------------------------------
/// Defaults now use tokens:
/// • Size: 343×108
/// • Padding: DLSpacing.p16
/// • Corners: DLRadii.lg
/// • Border: DLBorderWidth.w1 + DLColors.grey200
/// • Typography: DLTypos
/// • Gaps/sizes use DLSpacing where possible (p12, p28, etc.)
/// Everything is still overridable via parameters.
/// ---------------------------------------------------------------------------
enum DLAlertType { error, success, warning, info }

class DLAlert extends StatelessWidget {
  const DLAlert({
    super.key,
    this.type = DLAlertType.error,
    this.title = 'Headline',
    this.description =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
    this.showClose = true,
    this.onClose,
    this.leading,

    // Card layout
    this.width = 343,
    this.height = 108,
    this.radius = DLRadii.lg,
    this.borderColor = DLColors.grey200,
    this.borderWidth = DLBorderWidth.w1,
    this.backgroundColor = DLColors.white,

    // Typography overrides
    this.titleStyle,
    this.descriptionStyle,

    // Tokenized chrome & layout overrides
    this.horizontalPadding = DLSpacing.p16,
    this.verticalPadding = DLSpacing.p16,
    this.cornerGap = DLSpacing.p12,
    this.titleDescriptionGap = DLSpacing.p8,

    // Badge & close sizes (use spacing tokens where possible)
    this.badgeSize = DLSpacing.p28, // 28
    this.badgeIconSize = 16,
    this.closeSize = DLSpacing.p28, // 28
    this.closeIconSize = 14,

    // Optional shadow (off by default)
    this.shadow,
  });

  final DLAlertType type;
  final String title;
  final String description;
  final bool showClose;
  final VoidCallback? onClose;

  final Widget? leading;

  final double width;
  final double height;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;

  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  // Tokens / spacing
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerGap;
  final double titleDescriptionGap;

  // Badge / close controls
  final double badgeSize;
  final double badgeIconSize;
  final double closeSize;
  final double closeIconSize;

  // Shadow
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    final (defaultBadge, _) = _buildBadge(badgeSize, badgeIconSize);

    final titleTextStyle =
        titleStyle ?? DLTypos.textBaseBold(color: DLColors.black);
    final descTextStyle =
        descriptionStyle ?? DLTypos.textSmRegular(color: DLColors.grey700);

    // Keep text clear of top-left badge and top-right close
    final leftInset = horizontalPadding + badgeSize + cornerGap;
    final rightInset =
        horizontalPadding + (showClose ? closeSize + cornerGap : 0);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: shadow,
      ),
      child: Stack(
        children: [
          // Top-left badge
          Positioned(
            top: verticalPadding,
            left: horizontalPadding,
            child: leading ?? defaultBadge,
          ),

          // Top-right close
          if (showClose)
            Positioned(
              top: verticalPadding,
              right: horizontalPadding,
              child: InkWell(
                onTap: onClose,
                customBorder: const CircleBorder(),
                child: Container(
                  width: closeSize,
                  height: closeSize,
                  decoration: const BoxDecoration(
                    color: DLColors.black,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.close,
                    size: closeIconSize,
                    color: DLColors.white,
                  ),
                ),
              ),
            ),

          // Text block — padded between the two top icons
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                leftInset,
                verticalPadding,
                rightInset,
                verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: titleTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: titleDescriptionGap),
                  Text(
                    description,
                    style: descTextStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns (badgeWidget, accentColor)
  (Widget, Color) _buildBadge(double size, double iconSize) {
    switch (type) {
      case DLAlertType.error:
        return (
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: DLColors.red500,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.priority_high,
              size: iconSize,
              color: DLColors.white,
            ),
          ),
          DLColors.red500,
        );
      case DLAlertType.success:
        return (
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: DLColors.green500,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.check, size: iconSize, color: DLColors.white),
          ),
          DLColors.green500,
        );
      case DLAlertType.warning:
        return (
          SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Icon(
                Icons.warning_amber_rounded,
                size: size * 0.78,
                color: DLColors.yellow500,
              ),
            ),
          ),
          DLColors.yellow500,
        );
      case DLAlertType.info:
        return (
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: DLColors.violet500,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.info, size: iconSize, color: DLColors.white),
          ),
          DLColors.violet500,
        );
    }
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Overlay "snackbar" helper
  // ───────────────────────────────────────────────────────────────────────────

  /// Shows an animated alert overlay and returns the created OverlayEntry.
  /// Uses an internal stateful host to obtain a TickerProvider safely.
  static OverlayEntry show(
    BuildContext context, {
    DLAlertType type = DLAlertType.error,
    String title = 'Headline',
    String description =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
    bool showClose = true,
    VoidCallback? onClose,
    Widget? leading,

    // Card layout
    double width = 343,
    double height = 108,
    double radius = DLRadii.lg,
    Color borderColor = DLColors.grey200,
    double borderWidth = DLBorderWidth.w1,
    Color backgroundColor = DLColors.white,

    // Tokenized chrome & layout
    double horizontalPadding = DLSpacing.p16,
    double verticalPadding = DLSpacing.p16,
    double cornerGap = DLSpacing.p12,
    double titleDescriptionGap = DLSpacing.p8,

    // Badge & close sizing
    double badgeSize = DLSpacing.p28,
    double badgeIconSize = 16,
    double closeSize = DLSpacing.p28,
    double closeIconSize = 14,

    // Shadow
    List<BoxShadow>? shadow,

    // Overlay presentation
    Alignment alignment = Alignment.bottomCenter,
    EdgeInsets margin = const EdgeInsets.fromLTRB(16, 0, 16, 24),
    Duration duration = const Duration(milliseconds: 2400),
    Duration animationDuration = const Duration(milliseconds: 220),
    Curve curve = Curves.easeOutCubic,
  }) {
    final alert = DLAlert(
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
      horizontalPadding: horizontalPadding,
      verticalPadding: verticalPadding,
      cornerGap: cornerGap,
      titleDescriptionGap: titleDescriptionGap,
      badgeSize: badgeSize,
      badgeIconSize: badgeIconSize,
      closeSize: closeSize,
      closeIconSize: closeIconSize,
      shadow: shadow,
    );

    return _buildEntry(
      context: context,
      alert: alert,
      alignment: alignment,
      margin: margin,
      duration: duration,
      animation: animationDuration,
      curve: curve,
    );
  }

  static OverlayEntry _buildEntry({
    required BuildContext context,
    required DLAlert alert,
    required Alignment alignment,
    required EdgeInsets margin,
    required Duration duration,
    required Duration animation,
    required Curve curve,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    void remove() {
      if (entry.mounted) {
        entry.remove();
      }
    }

    entry = OverlayEntry(
      builder: (_) => SafeArea(
        child: Align(
          alignment: alignment,
          child: Padding(
            padding: margin,
            child: _DLAlertOverlayHost(
              alert: alert,
              animationDuration: animation,
              curve: curve,
              lifetime: duration,
              onDispose: remove,
            ),
          ),
        ),
      ),
    );

    overlay?.insert(entry);
    return entry;
  }

  // Internal: copy with new onClose (kept for parity; not used in the host)
  DLAlert _copyWith({VoidCallback? onClose}) => DLAlert(
    type: type,
    title: title,
    description: description,
    showClose: showClose,
    onClose: onClose ?? this.onClose,
    leading: leading,
    width: width,
    height: height,
    radius: radius,
    borderColor: borderColor,
    borderWidth: borderWidth,
    backgroundColor: backgroundColor,
    titleStyle: titleStyle,
    descriptionStyle: descriptionStyle,
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
    cornerGap: cornerGap,
    titleDescriptionGap: titleDescriptionGap,
    badgeSize: badgeSize,
    badgeIconSize: badgeIconSize,
    closeSize: closeSize,
    closeIconSize: closeIconSize,
    shadow: shadow,
  );
}

/// Internal host that provides a TickerProvider for the overlay animation.
class _DLAlertOverlayHost extends StatefulWidget {
  const _DLAlertOverlayHost({
    required this.alert,
    required this.animationDuration,
    required this.curve,
    required this.lifetime,
    required this.onDispose,
  });

  final DLAlert alert;
  final Duration animationDuration;
  final Curve curve;
  final Duration lifetime;
  final VoidCallback onDispose;

  @override
  State<_DLAlertOverlayHost> createState() => _DLAlertOverlayHostState();
}

class _DLAlertOverlayHostState extends State<_DLAlertOverlayHost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _fade = CurvedAnimation(parent: _controller, curve: widget.curve);
    _slide = Tween(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).chain(CurveTween(curve: widget.curve)).animate(_controller);

    _controller.forward();

    if (widget.lifetime.inMilliseconds > 0) {
      Future.delayed(widget.lifetime, _close);
    }
  }

  Future<void> _close() async {
    if (!mounted) return;
    await _controller.reverse();
    widget.onDispose();
  }

  @override
  Widget build(BuildContext context) {
    // Make the card close itself when the close button is tapped
    final closable = widget.alert._copyWith(
      onClose: () {
        widget.alert.onClose?.call();
        _close();
      },
    );

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Material(color: Colors.transparent, child: closable),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
