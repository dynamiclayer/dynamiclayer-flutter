import 'package:dynamiclayer_flutter/src/tokens/dl_font_size.dart';
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
        top: true,
        bottom: true, // no bottom safe-area padding strip
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
    final maxH = (MediaQuery.of(context).size.height * 0.9);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header (dynamic height; no fixed SizedBox)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title center-aligned, with side paddings so it won't collide with the close button.
            SizedBox(width: 56, height: 56),
            SizedBox(
              width: (MediaQuery.of(context).size.width) - (2 * 56),
              child: Padding(
                padding: EdgeInsets.all(DLSpacing.p16),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: DLTypos.textBaseSemibold(color: DLColors.black)
                      .copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: DlFontSize.f3,
                      ),
                ),
              ),
            ),
            if (showClose)
              InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.all(DLSpacing.p16),
                  child: Image.asset(
                    Assets.bottomSheetX,
                    width: 24,
                    height: 24,
                    // fit: BoxFit.fill,
                  ),
                ),
              ),
          ],
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
                SizedBox(height: DLSpacing.p32),
                illustration ??
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Image.asset(
                        Assets.bottomSheetBadgeGold,
                        fit: BoxFit.contain,
                      ),
                    ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DLSpacing.p16,
                    vertical: DLSpacing.p32,
                  ),
                  child: Column(
                    children: [
                      if (showHeadline)
                        Text(
                          headlineText,
                          textAlign: TextAlign.center,
                          style: DLTypos.textXlSemibold(
                            color: DLColors.black,
                          ).copyWith(fontSize: DlFontSize.f5),
                        ),
                      if (showDescription) ...[
                        SizedBox(height: DLSpacing.p8),
                        Text(
                          descriptionText,
                          textAlign: TextAlign.center,
                          style: DLTypos.textSmRegular(color: DLColors.grey600),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Buttons (separator removed; height adapts to content)
        if (type != DLBottomSheetType.defaultType)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              DLSpacing.p16,
              DLSpacing.p0,
              DLSpacing.p16,
              DLSpacing.p16,
            ),
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
            const SizedBox(height: DLSpacing.p16),
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
