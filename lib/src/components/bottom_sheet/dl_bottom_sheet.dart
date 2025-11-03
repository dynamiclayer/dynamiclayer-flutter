import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

enum DLBottomSheetType { defaultType, singleButton, doubleButton }

class DLBottomSheet extends StatelessWidget {
  const DLBottomSheet({
    super.key,
    this.type = DLBottomSheetType.defaultType,

    // Chrome
    this.showClose = true,
    this.showHomeIndicator = true,

    // Content toggles + text
    this.title = 'Title',
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

  // Chrome
  final bool showClose;
  final bool showHomeIndicator;

  // Content
  final String title;
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

  // ──────────────────────────────────────────────────────────────────────────
  // Show helper
  // ──────────────────────────────────────────────────────────────────────────
  static Future<T?> show<T>(
    BuildContext context, {
    Key? key,
    DLBottomSheetType type = DLBottomSheetType.defaultType,

    // Chrome
    bool showClose = true,
    bool showHomeIndicator = true,

    // Content toggles + text
    String title = 'Title',
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
    bool isScrollControlled = true, // keep default true; still content-sized
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
        showHomeIndicator: showHomeIndicator,
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

    // ⬇️ Use bottom:false to avoid extra white space; we draw our own indicator.
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        bottom: false,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // ⬇️ Wrap makes the modal bottom sheet height = intrinsic content
          child: Wrap(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: DLColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DLRadii.x3l),
                    topRight: Radius.circular(DLRadii.x3l),
                  ),
                ),
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheetContent(BuildContext context) {
    final horizontal =
        padding ?? DLSpacing.symmetric(h: DLSpacing.p24, v: DLSpacing.p24);

    return LayoutBuilder(
      builder: (context, constraints) {
        final inner = ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: _Body(
            type: type,
            showClose: showClose,
            showHomeIndicator: showHomeIndicator,
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

        // No Align tricks — just padding around intrinsic content.
        return Padding(padding: horizontal, child: inner);
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.type,
    required this.showClose,
    required this.showHomeIndicator,
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
  final bool showHomeIndicator;

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

  @override
  Widget build(BuildContext context) {
    // Sheet can grow up to 90% height; otherwise stays content-sized.
    final maxH = MediaQuery.of(context).size.height * 0.9;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header (Title centered, close top-right)
        Row(
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: DLTypos.textSmMedium(color: DLColors.black),
                ),
              ),
            ),
            if (showClose)
              IconButton(
                visualDensity: VisualDensity.compact,
                splashRadius: 22,
                icon: const Icon(Icons.close, size: 20, color: DLColors.black),
                onPressed: () => Navigator.of(context).maybePop(),
              )
            else
              const SizedBox(width: 24),
          ],
        ),

        const SizedBox(height: 8),

        // Content stays intrinsic; only scrolls if exceeding 90% of screen.
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxH),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            child: Padding(
              padding: DLSpacing.symmetric(h: 4, v: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  illustration ??
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: DLColors.grey200,
                          borderRadius: DLRadii.brMd,
                        ),
                      ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 20),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ),

        if (showHomeIndicator) ...[
          const SizedBox(height: 8),
          Container(
            width: 120,
            height: 4,
            decoration: BoxDecoration(
              color: DLColors.black,
              borderRadius: DLRadii.brFull,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _buildButtons() {
    switch (type) {
      case DLBottomSheetType.defaultType:
        return const SizedBox.shrink();

      case DLBottomSheetType.singleButton:
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
          ],
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
            const SizedBox(height: 12),
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
