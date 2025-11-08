import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';
import '../../../generated/assets.dart';

enum DLBottomSheetType { defaultType, singleButton, doubleButton }

class DLBottomSheet extends StatelessWidget {
  const DLBottomSheet({
    super.key,
    this.type = DLBottomSheetType.defaultType,

    // Header
    this.showClose = true,
    this.title = 'Title',

    // Content toggles + text
    this.showHeadline = true,
    this.headlineText = 'Headline',
    this.showDescription = true,
    this.descriptionText =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',

    // Illustration
    this.illustration,

    // Buttons (single/double)
    this.primaryLabel = 'Button',
    this.onPrimaryPressed,
    this.primaryType = DLButtonType.primary,

    this.secondaryLabel = 'Button',
    this.onSecondaryPressed,
    this.secondaryType = DLButtonType.secondary,

    // Layout
    this.maxContentWidth = 600,
    this.padding,
  });

  // Variant
  final DLBottomSheetType type;

  // Header
  final bool showClose;
  final String title;

  // Content
  final bool showHeadline;
  final String headlineText;
  final bool showDescription;
  final String descriptionText;

  // Illustration
  final Widget? illustration;

  // Buttons
  final String primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final DLButtonType primaryType;

  final String secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final DLButtonType secondaryType;

  // Layout
  final double maxContentWidth;
  final EdgeInsetsGeometry? padding;

  static Future<T?> show<T>(
    BuildContext context, {
    Key? key,
    DLBottomSheetType type = DLBottomSheetType.defaultType,

    // Header
    bool showClose = true,
    String title = 'Title',

    // Content toggles + text
    bool showHeadline = true,
    String headlineText = 'Headline',
    bool showDescription = true,
    String descriptionText =
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.',

    // Illustration
    Widget? illustration,

    // Buttons
    String primaryLabel = 'Button',
    VoidCallback? onPrimaryPressed,
    DLButtonType primaryType = DLButtonType.primary,

    String secondaryLabel = 'Button',
    VoidCallback? onSecondaryPressed,
    DLButtonType secondaryType = DLButtonType.secondary,

    // Layout
    double maxContentWidth = 600,
    EdgeInsetsGeometry? padding,
    bool isScrollControlled = true,
    bool useSafeArea = true,
    Color barrierColor = const Color(0x99000000),
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor,
      builder: (ctx) => DLBottomSheet(
        key: key,
        type: type,
        showClose: showClose,
        title: title,
        showHeadline: showHeadline,
        headlineText: headlineText,
        showDescription: showDescription,
        descriptionText: descriptionText,
        illustration: illustration,
        primaryLabel: primaryLabel,
        onPrimaryPressed: onPrimaryPressed,
        primaryType: primaryType,
        secondaryLabel: secondaryLabel,
        onSecondaryPressed: onSecondaryPressed,
        secondaryType: secondaryType,
        maxContentWidth: maxContentWidth,
        padding: padding,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildSheetContent(context);

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        bottom: false, // no bottom safe-area padding strip
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          // keep only keyboard inset; no extra bottom padding
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(DLRadii.x3l),
                  topRight: Radius.circular(DLRadii.x3l),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: DLColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(DLRadii.x3l),
                      topRight: Radius.circular(DLRadii.x3l),
                    ),
                  ),
                  child: content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final inner = ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: _Body(
            type: type,
            showClose: showClose,
            title: title,
            showHeadline: showHeadline,
            headlineText: headlineText,
            showDescription: showDescription,
            descriptionText: descriptionText,
            illustration: illustration,
            primaryLabel: primaryLabel,
            onPrimaryPressed: onPrimaryPressed,
            primaryType: primaryType,
            secondaryLabel: secondaryLabel,
            onSecondaryPressed: onSecondaryPressed,
            secondaryType: secondaryType,
          ),
        );

        return inner;
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.type,
    required this.showClose,
    required this.title,
    required this.showHeadline,
    required this.headlineText,
    required this.showDescription,
    required this.descriptionText,
    required this.illustration,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    required this.primaryType,
    required this.secondaryLabel,
    required this.onSecondaryPressed,
    required this.secondaryType,
  });

  final DLBottomSheetType type;
  final bool showClose;

  final String title;
  final bool showHeadline;
  final String headlineText;
  final bool showDescription;
  final String descriptionText;

  final Widget? illustration;

  final String primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final DLButtonType primaryType;

  final String secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final DLButtonType secondaryType;

  static const _contentHPad = 32.0;

  @override
  Widget build(BuildContext context) {
    final maxH = MediaQuery.of(context).size.height * 0.9;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header (dynamic height; no fixed SizedBox)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Stack(
            children: [
              // Title center-aligned, with side paddings so it won't collide with the close button.
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 56.0),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: DLTypos.textXlSemibold(
                      color: DLColors.black,
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              if (showClose)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: SizedBox(
                    // keep a good tap target without fixing the whole header height
                    width: 48,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.of(context).maybePop(),
                        child: Center(
                          child: Image.asset(
                            Assets.bottomSheetX,
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Middle content
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxH),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: _contentHPad),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                illustration ??
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset(
                        Assets.bottomSheetBadgeGold,
                        fit: BoxFit.contain,
                      ),
                    ),
                const SizedBox(height: 24),
                if (showHeadline)
                  Text(
                    headlineText,
                    textAlign: TextAlign.center,
                    style: DLTypos.textLgBold(color: DLColors.black),
                  ),
                if (showDescription) ...[
                  const SizedBox(height: 8),
                  Text(
                    descriptionText,
                    textAlign: TextAlign.center,
                    style: DLTypos.textSmRegular(color: DLColors.grey600),
                  ),
                ],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        // Buttons (separator removed; height adapts to content)
        if (type != DLBottomSheetType.defaultType)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: _buildButtons(),
          ),
      ],
    );
  }

  Widget _buildButtons() {
    switch (type) {
      case DLBottomSheetType.defaultType:
        return const SizedBox.shrink();

      case DLBottomSheetType.singleButton:
        return DLButton(
          type: primaryType,
          label: primaryLabel,
          size: DLButtonSize.lg,
          onPressed: onPrimaryPressed,
          width: double.infinity,
          fixedWidth: true,
        );

      case DLBottomSheetType.doubleButton:
        return Column(
          children: [
            DLButton(
              type: primaryType,
              label: primaryLabel,
              size: DLButtonSize.lg,
              onPressed: onPrimaryPressed,
              width: double.infinity,
              fixedWidth: true,
            ),
            const SizedBox(height: 16),
            DLButton(
              type: secondaryType,
              label: secondaryLabel,
              size: DLButtonSize.lg,
              onPressed: onSecondaryPressed,
              width: double.infinity,
              fixedWidth: true,
            ),
          ],
        );
    }
  }
}
