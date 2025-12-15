// lib/src/components/card/dl_card.dart
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

  /// Leading icon widget (Figma: 24x24)
  final Widget icon;

  final String title;
  final String description;

  final DLCardSize size;
  final DLCardState state;

  final VoidCallback? onTap;
  final bool descriptionVisible;
  final String? semanticsLabel;

  // ---------------------------------------------------------------------------
  // Tokens
  // ---------------------------------------------------------------------------

  double get _fixedWidth => 160;

  double get _minHeight {
    switch (size) {
      case DLCardSize.md:
        return 64; // Hug 64 in Figma for md
      case DLCardSize.lg:
        return 112; // Hug 112 in Figma for lg
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
        return DLSpacing.p12;
      case DLCardSize.lg:
        return DLSpacing.p16;
    }
  }

  // Background is grey100 for all states (per your current token use)
  Color get _background => DLColors.grey100;

  double get _borderWidth {
    switch (state) {
      case DLCardState.active:
        return DLBorderWidth.w2;
      case DLCardState.normal:
      case DLCardState.disabled:
        return DLBorderWidth.w0;
    }
  }

  Color? get _borderColor {
    switch (state) {
      case DLCardState.active:
        return DLColors.black;
      case DLCardState.normal:
      case DLCardState.disabled:
        return null;
    }
  }

  TextStyle get _titleStyle {
    switch (state) {
      case DLCardState.normal:
      case DLCardState.active:
        return DLTypos.textBaseSemibold(color: DLColors.black);
      case DLCardState.disabled:
        return DLTypos.textBaseStrike(color: DLColors.grey400);
    }
  }

  TextStyle get _descriptionStyle {
    switch (state) {
      case DLCardState.normal:
      case DLCardState.active:
        return DLTypos.textBaseRegular(color: DLColors.black);
      case DLCardState.disabled:
        return DLTypos.textBaseStrike(color: DLColors.grey400);
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
    // Figma: icon is 24x24 (no 40x40 container)
    return IconTheme(
      data: IconThemeData(size: 24, color: _iconColor),
      child: SizedBox(width: 24, height: 24, child: Center(child: icon)),
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
    // md: icon + text in a row, centered vertically by row height
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
    // lg: icon top-left, then text below (both aligned to start)
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
    final content = SizedBox(
      width: _fixedWidth, // Figma: W Fixed 160
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: _minHeight),
        child: Container(
          decoration: BoxDecoration(
            color: _background,
            borderRadius: DLRadii.brLg,
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
      ),
    );

    final semanticsWrapped = Semantics(
      button: onTap != null,
      enabled: !_isDisabled,
      label: semanticsLabel ?? title,
      child: content,
    );

    if (_isDisabled || onTap == null) return semanticsWrapped;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: semanticsWrapped,
    );
  }
}
