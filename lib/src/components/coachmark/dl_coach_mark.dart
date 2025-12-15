// lib/src/components/coachmark/dl_coach_mark.dart
import 'package:flutter/material.dart';

import '../../../dynamiclayers.dart';
import '../pagination/dl_pagination.dart';

/// Direction for the little callout pointer.
enum DLCoachMarkDirection { bottom, top, left, right }

/// Tutorial / coach-mark bubble.
///
/// Updates:
/// - Internal step state (Next/Back updates pagination automatically).
/// - Optional editable title + message via TextFields.
/// - Optional callbacks for step change and text changes.
class DLCoachMark extends StatefulWidget {
  const DLCoachMark({
    super.key,

    // Content
    this.title = '',
    this.message = '',

    // Steps
    required this.totalSteps,
    this.initialStep = 0,
    this.onStepChanged,

    // Buttons
    this.onNext,
    this.onBack,
    this.showBack = true,
    this.showNext = true,

    // Enable rules (optional; defaults computed from step)
    this.backEnabled,
    this.nextEnabled,

    // Pointer
    this.direction = DLCoachMarkDirection.bottom,

    // Layout
    this.maxWidth = 343,

    // Editable text
    this.editable = false,
    this.titleController,
    this.messageController,
    this.onTitleChanged,
    this.onMessageChanged,
    this.titleHint = 'Title',
    this.messageHint = 'Message',
  }) : assert(totalSteps >= 1),
       assert(initialStep >= 0 && initialStep < totalSteps);

  /// Title text (non-editable mode).
  final String title;

  /// Body text (non-editable mode).
  final String message;

  /// Total number of steps.
  final int totalSteps;

  /// Initial step (zero-based).
  final int initialStep;

  /// Notifies whenever internal step changes.
  final ValueChanged<int>? onStepChanged;

  /// Optional callbacks invoked after internal step updates.
  /// If you need to close/reposition an Overlay, do it here.
  final ValueChanged<int>? onNext;
  final ValueChanged<int>? onBack;

  /// Visibility flags for the buttons.
  final bool showBack;
  final bool showNext;

  /// Optional overrides for enabled states.
  /// If null, they are computed from current step.
  final bool? backEnabled;
  final bool? nextEnabled;

  /// Pointer side.
  final DLCoachMarkDirection direction;

  /// Maximum width of the bubble.
  final double maxWidth;

  /// When true, title/message become editable text fields.
  final bool editable;

  /// Optional controllers (recommended when editable = true).
  final TextEditingController? titleController;
  final TextEditingController? messageController;

  /// Optional change callbacks (editable mode).
  final ValueChanged<String>? onTitleChanged;
  final ValueChanged<String>? onMessageChanged;

  /// Hints for editable fields.
  final String titleHint;
  final String messageHint;

  @override
  State<DLCoachMark> createState() => _DLCoachMarkState();
}

class _DLCoachMarkState extends State<DLCoachMark> {
  late int _step;

  TextEditingController? _ownedTitleController;
  TextEditingController? _ownedMessageController;

  TextEditingController get _titleC =>
      widget.titleController ?? _ownedTitleController!;
  TextEditingController get _messageC =>
      widget.messageController ?? _ownedMessageController!;

  @override
  void initState() {
    super.initState();
    _step = widget.initialStep;

    if (widget.editable) {
      if (widget.titleController == null) {
        _ownedTitleController = TextEditingController(text: widget.title);
      }
      if (widget.messageController == null) {
        _ownedMessageController = TextEditingController(text: widget.message);
      }
    }
  }

  @override
  void didUpdateWidget(covariant DLCoachMark oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If totalSteps shrinks, clamp step
    if (_step >= widget.totalSteps) {
      _step = widget.totalSteps - 1;
    }

    // If editable toggles on, ensure controllers exist.
    if (widget.editable && oldWidget.editable != widget.editable) {
      if (widget.titleController == null && _ownedTitleController == null) {
        _ownedTitleController = TextEditingController(text: widget.title);
      }
      if (widget.messageController == null && _ownedMessageController == null) {
        _ownedMessageController = TextEditingController(text: widget.message);
      }
    }
  }

  @override
  void dispose() {
    _ownedTitleController?.dispose();
    _ownedMessageController?.dispose();
    super.dispose();
  }

  bool get _computedBackEnabled => _step > 0;
  bool get _computedNextEnabled => _step < widget.totalSteps - 1;

  void _goBack() {
    if (!(widget.backEnabled ?? _computedBackEnabled)) return;
    if (_step <= 0) return;

    setState(() => _step -= 1);

    widget.onStepChanged?.call(_step);
    widget.onBack?.call(_step);
  }

  void _goNext() {
    if (!(widget.nextEnabled ?? _computedNextEnabled)) return;
    if (_step >= widget.totalSteps - 1) return;

    setState(() => _step += 1);

    widget.onStepChanged?.call(_step);
    widget.onNext?.call(_step);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBackEnabled = widget.backEnabled ?? _computedBackEnabled;
    final effectiveNextEnabled = widget.nextEnabled ?? _computedNextEnabled;

    final bubble = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
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
              if (!widget.editable)
                Text(
                  widget.title,
                  style: DLTypos.textBaseSemibold(color: DLColors.white),
                )
              else
                _CoachTextField(
                  controller: _titleC,
                  hintText: widget.titleHint,
                  textStyle: DLTypos.textBaseSemibold(color: DLColors.white),
                  onChanged: widget.onTitleChanged,
                  maxLines: 1,
                ),

              const SizedBox(height: DLSpacing.p8),

              // Message
              if (!widget.editable)
                Text(
                  widget.message,
                  style: DLTypos.textSmRegular(color: DLColors.white),
                )
              else
                _CoachTextField(
                  controller: _messageC,
                  hintText: widget.messageHint,
                  textStyle: DLTypos.textSmRegular(color: DLColors.white),
                  onChanged: widget.onMessageChanged,
                  maxLines: 6,
                ),

              const SizedBox(height: DLSpacing.p12),

              Row(
                children: [
                  _CoachPagination(
                    currentStep: _step,
                    totalSteps: widget.totalSteps,
                  ),
                  const Spacer(),
                  if (widget.showBack) ...[
                    _CoachButton(
                      label: 'Back',
                      enabled: effectiveBackEnabled,
                      onTap: effectiveBackEnabled ? _goBack : null,
                    ),
                    const SizedBox(width: DLSpacing.p8),
                  ],
                  if (widget.showNext)
                    _CoachButton(
                      label: 'Next',
                      enabled: effectiveNextEnabled,
                      onTap: effectiveNextEnabled ? _goNext : null,
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
        _CoachPointer(direction: widget.direction),
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
      mode: DLPaginationMode.dark,
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

    final diamond = Transform.rotate(
      angle: 0.78539816339, // 45 degrees
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

/// Minimal text field styling for the dark bubble.
class _CoachTextField extends StatelessWidget {
  const _CoachTextField({
    required this.controller,
    required this.hintText,
    required this.textStyle,
    required this.maxLines,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final TextStyle textStyle;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      style: textStyle,
      cursorColor: DLColors.white,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: textStyle.copyWith(color: DLColors.white.withOpacity(0.6)),
      ),
    );
  }
}
