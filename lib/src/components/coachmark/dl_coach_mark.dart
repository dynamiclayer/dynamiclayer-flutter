// lib/src/components/coachmark/dl_coach_mark.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';
import '../pagination/dl_pagination.dart'; // ← uses your pagination component

/// Direction for the little callout pointer.
enum DLCoachMarkDirection { bottom, top, left, right }

/// Tutorial / coach-mark bubble.
///
/// Features:
/// - Fixed max width (343px) but height is dynamic.
/// - Title + message.
/// - Pagination dots (current step / total).
/// - Back / Next buttons.
/// - Pointer that can be at top / bottom / left / right.
///
/// This widget only draws the bubble itself; you can place it in an Overlay,
/// Align, Positioned, etc. to point at any part of the UI.
class DLCoachMark extends StatelessWidget {
  const DLCoachMark({
    super.key,
    required this.title,
    required this.message,
    required this.currentStep,
    required this.totalSteps,
    required this.onNext,
    required this.onBack,
    this.direction = DLCoachMarkDirection.bottom,
    this.maxWidth = 343,
    this.showBack = true,
    this.showNext = true,
    this.backEnabled = true,
    this.nextEnabled = true,
  }) : assert(totalSteps >= 1),
       assert(currentStep >= 0 && currentStep < totalSteps);

  /// Title text (bold).
  final String title;

  /// Body text.
  final String message;

  /// Zero-based index of the current step (0..totalSteps-1).
  final int currentStep;

  /// Total number of steps.
  final int totalSteps;

  /// Called when user taps "Next".
  final VoidCallback onNext;

  /// Called when user taps "Back".
  final VoidCallback onBack;

  /// Pointer side (top / bottom / left / right).
  final DLCoachMarkDirection direction;

  /// Maximum width of the bubble (defaults to 343).
  final double maxWidth;

  /// Visibility / enabled flags for the buttons.
  final bool showBack;
  final bool showNext;
  final bool backEnabled;
  final bool nextEnabled;

  @override
  Widget build(BuildContext context) {
    final bubble = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: DLColors.black,
          borderRadius: BorderRadius.circular(DLRadii.lg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(DLSpacing.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: DLTypos.textBaseSemibold(color: DLColors.white),
              ),
              const SizedBox(height: DLSpacing.p8),

              // Message
              Text(
                message,
                style: DLTypos.textSmRegular(color: DLColors.white),
              ),
              const SizedBox(height: DLSpacing.p12),

              // Bottom row: pagination + buttons
              Row(
                children: [
                  // Pagination dots
                  _CoachPagination(
                    currentStep: currentStep,
                    totalSteps: totalSteps,
                  ),
                  const Spacer(),
                  if (showBack) ...[
                    _CoachButton(
                      label: 'Back',
                      enabled: backEnabled,
                      onTap: backEnabled ? onBack : null,
                    ),
                    const SizedBox(width: DLSpacing.p8),
                  ],
                  if (showNext)
                    _CoachButton(
                      label: 'Next',
                      enabled: nextEnabled,
                      onTap: nextEnabled ? onNext : null,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        bubble,
        _CoachPointer(direction: direction),
      ],
    );
  }
}

/// Small secondary button used for "Back" and "Next".
class _CoachButton extends StatelessWidget {
  const _CoachButton({required this.label, required this.enabled, this.onTap});

  final String label;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DLButton(
      type: DLButtonType.secondary,
      size: DLButtonSize.xs,
      label: label,
      enabled: enabled,
      onPressed: onTap,
    );
  }
}

/// Pagination row for the coach mark – reuses your pagination component.
class _CoachPagination extends StatelessWidget {
  const _CoachPagination({required this.currentStep, required this.totalSteps});

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return DLPagination(
      count: totalSteps,
      activeIndex: currentStep,
      mode: DLPaginationMode.dark, // white dots on dark bg
      expanded: false,
    );
  }
}

/// Pointer – small rotated square (diamond) placed on the given side.
class _CoachPointer extends StatelessWidget {
  const _CoachPointer({required this.direction});

  final DLCoachMarkDirection direction;

  @override
  Widget build(BuildContext context) {
    const double size = 12;
    const double half = size / 2;

    Widget diamond = Transform.rotate(
      angle: 0.78539816339, // 45 degrees in radians
      child: Container(width: size, height: size, color: DLColors.black),
    );

    switch (direction) {
      case DLCoachMarkDirection.bottom:
        return Positioned(
          bottom: -half,
          left: 0,
          right: 0,
          child: Center(child: diamond),
        );
      case DLCoachMarkDirection.top:
        return Positioned(
          top: -half,
          left: 0,
          right: 0,
          child: Center(child: diamond),
        );
      case DLCoachMarkDirection.left:
        return Positioned(
          left: -half,
          top: 0,
          bottom: 0,
          child: Center(child: diamond),
        );
      case DLCoachMarkDirection.right:
        return Positioned(
          right: -half,
          top: 0,
          bottom: 0,
          child: Center(child: diamond),
        );
    }
  }
}
