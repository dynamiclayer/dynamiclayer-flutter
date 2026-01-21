import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../tokens/dl_colors.dart';
import '../../tokens/dl_typography.dart';

class DLTopNavigationMessage extends StatelessWidget {
  const DLTopNavigationMessage({
    super.key,
    required this.title,
    this.description,
    this.showSeparator = true,
    this.iconLeft,
    this.iconRight,
    this.onLeftTap,
    this.onRightTap,
    this.avatar,
  });

  final String title;
  final String? description;
  final bool showSeparator;

  final Widget? iconLeft;
  final Widget? iconRight;

  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  /// Optional override for the avatar widget.
  /// If null, it will auto-pick based on description (single vs multi user).
  final Widget? avatar;

  static const double _height = 56.0;

  @override
  Widget build(BuildContext context) {
    final hasDescription = (description ?? '').trim().isNotEmpty;

    return SizedBox(
      height: _height,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: DLColors.white,
          border: showSeparator
              ? const Border(
                  bottom: BorderSide(width: 1, color: DLColors.grey200),
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _TapIcon(
                onTap: onLeftTap,
                child: iconLeft ?? const _PlaceholderNavIcon(),
              ),
              const SizedBox(width: 12),

              avatar ?? _AvatarXs(hasDescription: hasDescription),

              const SizedBox(width: 12),
              Expanded(
                child: _TitleAndSubtitle(
                  title: title,
                  subtitle: hasDescription ? description! : null,
                ),
              ),
              const SizedBox(width: 12),
              _TapIcon(
                onTap: onRightTap,
                child: iconRight ?? const _PlaceholderNavIcon(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarXs extends StatelessWidget {
  const _AvatarXs({required this.hasDescription});

  final bool hasDescription;

  @override
  Widget build(BuildContext context) {
    // Per your requirement: use multi_user.svg for the second one (with description)
    final String? asset = hasDescription
        ? 'assets/snackbar/multi_user.svg'
        : null;

    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Color(0xFFEEEEEE),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: asset != null
          ? SvgPicture.asset(
              asset,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                Color(0xFF757575),
                BlendMode.srcIn,
              ),
            )
          : const Icon(Icons.person, size: 18, color: Color(0xFF757575)),
    );
  }
}

class _TitleAndSubtitle extends StatelessWidget {
  const _TitleAndSubtitle({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final hasSubtitle = (subtitle ?? '').trim().isNotEmpty;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: DLTypos.textBaseSemibold(color: DLColors.black),
        ),
        if (hasSubtitle) ...[
          const SizedBox(height: 2),
          Text(
            subtitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: DLTypos.textSmRegular(color: const Color(0xFF757575)),
          ),
        ],
      ],
    );
  }
}

class _TapIcon extends StatelessWidget {
  const _TapIcon({required this.child, this.onTap});
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 24,
      child: SizedBox(width: 40, height: 40, child: Center(child: child)),
    );
  }
}

class _PlaceholderNavIcon extends StatelessWidget {
  const _PlaceholderNavIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.fullscreen, size: 20, color: DLColors.black);
  }
}
