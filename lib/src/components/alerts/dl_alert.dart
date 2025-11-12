import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../dynamiclayers.dart';
import '../../../generated/assets.dart';

enum DLAlertType { error, success, warning, info }

class DLAlert extends StatelessWidget {
  const DLAlert({
    super.key,
    this.type = DLAlertType.error,
    this.title = 'Headline',
    this.description =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',

    // close control (new API)
    this.close = true,
    @Deprecated('Use `close` instead') this.showClose,
    this.onClose,

    this.leading,

    // Card layout (Figma defaults)
    this.width = 343,
    this.height = 108, // now treated as MIN height to avoid overflow
    this.radius = DLRadii.lg,
    this.borderColor = DLColors.grey200,
    this.borderWidth = DLBorderWidth.w1,
    this.backgroundColor = DLColors.white,

    // Typography overrides (Inter / size3 / line-height3 / letter-spacing7)
    this.titleStyle,
    this.descriptionStyle,

    // Spacing tokens
    this.horizontalPadding = DLSpacing.p16, // 16
    this.verticalPadding = DLSpacing.p16, // 16
    this.iconTextGap = DLSpacing.p16, // 16 between badge and text
    this.titleDescriptionGap = DLSpacing.p8, // 8 between title and message
    // Fixed icon sizes per Figma
    this.badgeIconSize = 24,
    this.closeIconSize = 24,

    // Optional shadow
    this.shadow,
  });

  final DLAlertType type;
  final String title;
  final String description;

  /// New API — whether to show the close button.
  final bool close;

  /// Legacy flag (if supplied, overrides [close])
  final bool? showClose;

  final VoidCallback? onClose;
  final Widget? leading;

  final double width;
  final double height; // acts as minHeight
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;

  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  // Spacing
  final double horizontalPadding;
  final double verticalPadding;
  final double iconTextGap;
  final double titleDescriptionGap;

  // Icons
  final double badgeIconSize; // 24
  final double closeIconSize; // 24

  final List<BoxShadow>? shadow;

  static const double _closeHitSize = 56; // exact 56×56 hit target
  bool get _shouldShowClose => showClose ?? close;

  // Inter defaults for your tokens (override if you pipe in DLTypos)
  TextStyle get _defaultTitle =>
      (titleStyle ??
      const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600, // Semi Bold
        fontSize: 16, // font/size/3
        height: 24 / 16, // font/line-height/3
        letterSpacing: 0.0, // font/letter-spacing/7
        color: DLColors.black,
      ));

  TextStyle get _defaultDesc =>
      (descriptionStyle ??
      const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400, // Regular
        fontSize: 16, // font/size/3
        height: 24 / 16,
        letterSpacing: 0.0,
        color: DLColors.grey700,
      ));

  @override
  Widget build(BuildContext context) {
    final double leftIndent = badgeIconSize + iconTextGap;

    return Container(
      width: width,
      constraints: BoxConstraints(minHeight: height),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: shadow,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Row 1: Icon + Headline + Close ────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: badgeIconSize,
                  height: badgeIconSize,
                  child: leading ?? _buildBadgeIcon(type, badgeIconSize),
                ),
                SizedBox(width: iconTextGap),
                // Headline centered with icon
                Expanded(
                  child: Text(
                    title,
                    style: _defaultTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_shouldShowClose) ...[
                  SizedBox(width: iconTextGap),
                  _CloseButton(
                    size: _closeHitSize,
                    iconSize: closeIconSize,
                    onTap: onClose,
                  ),
                ],
              ],
            ),

            // ── Row 2: Indented full message (no ellipsis) ────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // indent so message aligns with headline start
                SizedBox(width: leftIndent),
                // message wraps fully
                Expanded(
                  child: Text(
                    description,
                    style: _defaultDesc,
                    softWrap: true,
                    // no truncation:
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // SVG badge icons
  Widget _buildBadgeIcon(DLAlertType type, double size) {
    switch (type) {
      case DLAlertType.error:
        return SvgPicture.asset(
          Assets.alertsCircleAlert,
          width: size,
          height: size,
          fit: BoxFit.contain,
        );
      case DLAlertType.success:
        return SvgPicture.asset(
          Assets.alertsCircleCheck,
          width: size,
          height: size,
          fit: BoxFit.contain,
        );
      case DLAlertType.warning:
        return SvgPicture.asset(
          Assets.alertsAlertTriangleFilled,
          width: size,
          height: size,
          fit: BoxFit.contain,
        );
      case DLAlertType.info:
        return SvgPicture.asset(
          Assets.alertsInfo,
          width: size,
          height: size,
          fit: BoxFit.contain,
        );
    }
  }

  // ── Overlay helper (unchanged; still uses `close`)
  static OverlayEntry show(
    BuildContext context, {
    DLAlertType type = DLAlertType.error,
    String title = 'Headline',
    String description =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
    bool close = true,
    @Deprecated('Use `close` instead') bool? showClose,
    VoidCallback? onClose,
    Widget? leading,

    double width = 343,
    double height = 108,
    double radius = DLRadii.lg,
    Color borderColor = DLColors.grey200,
    double borderWidth = DLBorderWidth.w1,
    Color backgroundColor = DLColors.white,

    double horizontalPadding = DLSpacing.p16,
    double verticalPadding = DLSpacing.p16,
    double iconTextGap = DLSpacing.p16,
    double titleDescriptionGap = DLSpacing.p8,

    double badgeIconSize = 24,
    double closeIconSize = 24,

    List<BoxShadow>? shadow,

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
      close: showClose ?? close,
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
      iconTextGap: iconTextGap,
      titleDescriptionGap: titleDescriptionGap,
      badgeIconSize: badgeIconSize,
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
      if (entry.mounted) entry.remove();
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

  DLAlert _copyWith({VoidCallback? onClose}) => DLAlert(
    type: type,
    title: title,
    description: description,
    close: _shouldShowClose,
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
    iconTextGap: iconTextGap,
    titleDescriptionGap: titleDescriptionGap,
    badgeIconSize: badgeIconSize,
    closeIconSize: closeIconSize,
    shadow: shadow,
  );
}

/// Close button with exact 56×56 hit area and a 24px SVG centered.
class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.size, required this.iconSize, this.onTap});

  final double size; // 56
  final double iconSize; // 24
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: SvgPicture.asset(
              Assets.alertsCircleX,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

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
