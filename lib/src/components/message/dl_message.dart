// lib/src/components/message/dl_message.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// Message bubbles (other vs own, single vs response)
/// ---------------------------------------------------------------------------
///
/// Types:
///   - other single    → light bubble, author + text
///   - own single      → dark bubble, text only
///   - other response  → light bubble with highlighted quoted message
///   - own response    → dark bubble with highlighted quoted message
///
/// Size:
///   - Width is NOT fixed; it grows with text up to [maxWidth] (default: 240)
///   - Height is fully dynamic.
///
/// Example:
///   const DLMessage.otherSingle(
///     author: 'Thomas',
///     text: 'Lorem ipsum dolor sit amet.',
///   );
///
///   const DLMessage.ownResponse(
///     text: 'Lorem ipsum dolor sit amet.',
///     highlightAuthor: 'Thomas',
///     highlightText: 'Lorem ipsum dolor sit amet, consectetur sadipscing elitr.',
///   );
/// ---------------------------------------------------------------------------

enum DLMessageVariant { otherSingle, ownSingle, otherResponse, ownResponse }

class DLMessage extends StatelessWidget {
  const DLMessage.otherSingle({
    super.key,
    required String author,
    required String text,
    double? maxWidth,
  }) : variant = DLMessageVariant.otherSingle,
       author = author,
       text = text,
       highlightAuthor = null,
       highlightText = null,
       maxWidth = maxWidth ?? 240;

  const DLMessage.ownSingle({super.key, required String text, double? maxWidth})
    : variant = DLMessageVariant.ownSingle,
      author = null,
      text = text,
      highlightAuthor = null,
      highlightText = null,
      maxWidth = maxWidth ?? 240;

  const DLMessage.otherResponse({
    super.key,
    required String author,
    required String text,
    required String highlightAuthor,
    required String highlightText,
    double? maxWidth,
  }) : variant = DLMessageVariant.otherResponse,
       author = author,
       text = text,
       highlightAuthor = highlightAuthor,
       highlightText = highlightText,
       maxWidth = maxWidth ?? 240;

  const DLMessage.ownResponse({
    super.key,
    required String text,
    required String highlightAuthor,
    required String highlightText,
    double? maxWidth,
  }) : variant = DLMessageVariant.ownResponse,
       author = null,
       text = text,
       highlightAuthor = highlightAuthor,
       highlightText = highlightText,
       maxWidth = maxWidth ?? 240;

  final DLMessageVariant variant;

  /// Author name (only used for "other" variants).
  final String? author;

  /// Main message text.
  final String text;

  /// Highlighted (quoted) author + text (only for response variants).
  final String? highlightAuthor;
  final String? highlightText;

  /// Max width the bubble can grow to; text wraps beyond this.
  final double maxWidth;

  bool get _isOwn =>
      variant == DLMessageVariant.ownSingle ||
      variant == DLMessageVariant.ownResponse;

  bool get _isResponse =>
      variant == DLMessageVariant.otherResponse ||
      variant == DLMessageVariant.ownResponse;

  @override
  Widget build(BuildContext context) {
    final bg = _backgroundColor();
    final borderRadius = BorderRadius.circular(DLRadii.lg);

    final content = Padding(
      padding: const EdgeInsets.all(DLSpacing.p12),
      child: _buildContent(),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: DecoratedBox(
        decoration: BoxDecoration(color: bg, borderRadius: borderRadius),
        child: content,
      ),
    );
  }

  Color _backgroundColor() {
    switch (variant) {
      case DLMessageVariant.otherSingle:
      case DLMessageVariant.otherResponse:
        return DLColors.grey100;
      case DLMessageVariant.ownSingle:
      case DLMessageVariant.ownResponse:
        return DLColors.grey800;
    }
  }

  Widget _buildContent() {
    switch (variant) {
      case DLMessageVariant.otherSingle:
        return _buildOtherSingle();
      case DLMessageVariant.ownSingle:
        return _buildOwnSingle();
      case DLMessageVariant.otherResponse:
        return _buildOtherResponse();
      case DLMessageVariant.ownResponse:
        return _buildOwnResponse();
    }
  }

  // ----------------------------- VARIANT: other/single ----------------------

  Widget _buildOtherSingle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (author != null) ...[
          Text(author!, style: DLTypos.textBaseSemibold(color: DLColors.black)),
          const SizedBox(height: DLSpacing.p4),
        ],
        Text(text, style: DLTypos.textBaseRegular(color: DLColors.black)),
      ],
    );
  }

  // ----------------------------- VARIANT: own/single ------------------------

  Widget _buildOwnSingle() {
    return Text(text, style: DLTypos.textBaseRegular(color: DLColors.white));
  }

  // ----------------------------- VARIANT: other/response --------------------

  Widget _buildOtherResponse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (author != null) ...[
          Text(author!, style: DLTypos.textBaseSemibold(color: DLColors.black)),
          const SizedBox(height: DLSpacing.p4),
        ],
        if (highlightAuthor != null && highlightText != null) ...[
          _HighlightBubble.light(
            author: highlightAuthor!,
            text: highlightText!,
          ),
          const SizedBox(height: DLSpacing.p4),
        ],
        Text(text, style: DLTypos.textBaseRegular(color: DLColors.black)),
      ],
    );
  }

  // ----------------------------- VARIANT: own/response ----------------------

  Widget _buildOwnResponse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (highlightAuthor != null && highlightText != null) ...[
          _HighlightBubble.dark(author: highlightAuthor!, text: highlightText!),
          const SizedBox(height: DLSpacing.p4),
        ],
        Text(text, style: DLTypos.textSmRegular(color: DLColors.white)),
      ],
    );
  }
}

/// Inner quoted message bubble (highlight) used by response variants.
class _HighlightBubble extends StatelessWidget {
  const _HighlightBubble._({
    required this.author,
    required this.text,
    required this.isDark,
  });

  factory _HighlightBubble.light({
    required String author,
    required String text,
  }) => _HighlightBubble._(author: author, text: text, isDark: false);

  factory _HighlightBubble.dark({
    required String author,
    required String text,
  }) => _HighlightBubble._(author: author, text: text, isDark: true);

  final String author;
  final String text;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color bg = isDark ? DLColors.grey700 : DLColors.grey300;
    final Color authorColor = isDark ? DLColors.white : DLColors.black;
    final Color textColor = isDark ? DLColors.white : DLColors.black;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        // Not strictly required, but keeps highlight a bit narrower
        // than outer bubble, similar to spec.
        maxWidth: 240,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(DLRadii.md),
        ),
        child: Padding(
          padding: const EdgeInsets.all(DLSpacing.p12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(author, style: DLTypos.textSmSemibold(color: authorColor)),
              const SizedBox(height: DLSpacing.p4),
              Text(text, style: DLTypos.textSmRegular(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
