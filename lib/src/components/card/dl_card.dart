import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// Card visual state from Figma JSON: default / active / disabled
enum DLCardState { normal, active, disabled }

/// Card sizes: md / lg
enum DLCardSize { md, lg }

class DLCard extends StatelessWidget {
  const DLCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.size = DLCardSize.md,
    this.state = DLCardState.normal,
    this.onTap,
    this.descriptionVisible = true,
    this.semanticsLabel,
  });

  /// Leading icon widget (typically 24x24 inside a 40x40 box)
  final Widget icon;

  final String title;
  final String description;

  final DLCardSize size;
  final DLCardState state;

  /// Tap callback. If null, card is treated as non-interactive.
  /// (Disabled state will also ignore taps.)
  final VoidCallback? onTap;

  /// Allow hiding description text if needed
  final bool descriptionVisible;

  /// Optional semantics override
  final String? semanticsLabel;

  // ---------------------------------------------------------------------------
  // Tokens
  // ---------------------------------------------------------------------------

  double get _minWidth => 160;

  double get _minHeight {
    switch (size) {
      case DLCardSize.md:
        return 64;
      case DLCardSize.lg:
        return 112;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case DLCardSize.md:
        return const EdgeInsets.all(DLSpacing.p12);
      case DLCardSize.lg:
        return const EdgeInsets.all(DLSpacing.p16);
    }
  }

  double get _gap {
    switch (size) {
      case DLCardSize.md:
        return 12;
      case DLCardSize.lg:
        return 16;
    }
  }

  // Background is grey100 for all states
  Color get _background => DLColors.grey100;

  double get _borderWidth {
    switch (state) {
      case DLCardState.normal:
      case DLCardState.disabled:
        return DLBorderWidth.w0;
      case DLCardState.active:
        return DLBorderWidth.w2;
    }
  }

  Color? get _borderColor {
    switch (state) {
      case DLCardState.normal:
      case DLCardState.disabled:
        return null;
      case DLCardState.active:
        return DLColors.black;
    }
  }

  TextStyle get _titleStyle {
    switch (state) {
      case DLCardState.normal:
      case DLCardState.active:
        return DLTypos.textBaseSemibold(color: DLColors.black);
      case DLCardState.disabled:
        return DLTypos.textBaseSemibold(
          color: DLColors.grey400,
        ).copyWith(decoration: TextDecoration.lineThrough);
    }
  }

  TextStyle get _descriptionStyle {
    switch (state) {
      case DLCardState.normal:
      case DLCardState.active:
        return DLTypos.textBaseRegular(color: DLColors.black);
      case DLCardState.disabled:
        return DLTypos.textBaseRegular(
          color: DLColors.grey400,
        ).copyWith(decoration: TextDecoration.lineThrough);
    }
  }

  Color get _iconColor {
    switch (state) {
      case DLCardState.disabled:
        return DLColors.grey400;
      case DLCardState.normal:
      case DLCardState.active:
        return DLColors.black;
    }
  }

  bool get _isDisabled => state == DLCardState.disabled;

  Widget _buildIcon() {
    // Plain icon, no button chrome — matches Figma.
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: IconTheme(
          data: IconThemeData(size: 24, color: _iconColor),
          child: icon,
        ),
      ),
    );
  }

  Widget _buildTextBlock() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: _titleStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (descriptionVisible) ...[
          const SizedBox(height: 2),
          Text(
            description,
            style: _descriptionStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildMdLayout() {
    // Icon + text in a row (top row in Figma)
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildIcon(),
        SizedBox(width: _gap),
        Expanded(child: _buildTextBlock()),
      ],
    );
  }

  Widget _buildLgLayout() {
    // Icon on top, text below in a column (bottom row in Figma)
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIcon(),
        SizedBox(height: _gap),
        _buildTextBlock(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = ConstrainedBox(
      constraints: BoxConstraints(minWidth: _minWidth, minHeight: _minHeight),
      child: Container(
        decoration: BoxDecoration(
          color: _background,
          borderRadius: DLRadii.brLg, // rounded_lg
          border: _borderWidth > 0
              ? Border.all(
                  width: _borderWidth,
                  color: _borderColor ?? Colors.transparent,
                )
              : null,
        ),
        padding: _padding,
        child: size == DLCardSize.md ? _buildMdLayout() : _buildLgLayout(),
      ),
    );

    final semanticsWrapped = Semantics(
      button: onTap != null,
      enabled: !_isDisabled,
      label: semanticsLabel ?? title,
      child: content,
    );

    // Disabled state and null onTap → non-interactive card.
    if (_isDisabled || onTap == null) {
      return semanticsWrapped;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: semanticsWrapped,
    );
  }
}
