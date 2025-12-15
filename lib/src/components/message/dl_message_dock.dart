// lib/src/components/message/dl_message_dock.dart
import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';
import '../separator/dl_separator.dart';

/// Bottom message input dock with separator, text field, and send button.
///
/// Usage:
///   Scaffold(
///     body: ...,
///     bottomNavigationBar: DLMessageDock(
///       onSend: (text) { /* send message */ },
///     ),
///   );
class DLMessageDock extends StatefulWidget {
  const DLMessageDock({
    super.key,
    this.controller,
    required this.onSend,
    this.hintText = 'Write a message...',
    this.enabled = true,
    this.padding = const EdgeInsets.all(DLSpacing.p16), // ✅ p16 on all sides
    this.showTopBorder = true,
  });

  /// Optional external controller. If null, the dock creates its own.
  final TextEditingController? controller;

  /// Called when the user taps the send button (only if text is non-empty).
  final ValueChanged<String> onSend;

  /// Placeholder for the input.
  final String hintText;

  /// Whether the entire dock is enabled.
  final bool enabled;

  /// Inner padding of the dock (spacing around the row).
  final EdgeInsets padding;

  /// Whether to draw a separator line at the top.
  final bool showTopBorder;

  @override
  State<DLMessageDock> createState() => _DLMessageDockState();
}

class _DLMessageDockState extends State<DLMessageDock> {
  late TextEditingController _controller;
  late bool _ownsController;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _attachController(widget.controller);
  }

  @override
  void didUpdateWidget(covariant DLMessageDock oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the external controller changes, re-wire listeners + disposal.
    if (oldWidget.controller != widget.controller) {
      _detachController();
      _attachController(widget.controller);
      setState(() {}); // reflect new controller text immediately
    }
  }

  void _attachController(TextEditingController? external) {
    _ownsController = external == null;
    _controller = external ?? TextEditingController();
    _hasText = _controller.text.trim().isNotEmpty;
    _controller.addListener(_handleTextChanged);
  }

  void _detachController() {
    _controller.removeListener(_handleTextChanged);
    if (_ownsController) {
      _controller.dispose();
    }
  }

  void _handleTextChanged() {
    final has = _controller.text.trim().isNotEmpty;
    if (has != _hasText) {
      setState(() => _hasText = has);
    }
  }

  @override
  void dispose() {
    _detachController();
    super.dispose();
  }

  bool get _canSend => widget.enabled && _hasText;

  void _handleSend() {
    if (!_canSend) return;
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showTopBorder)
            const DLSeparator(), // ✅ separator component

          Container(
            width: double.infinity,
            color: DLColors.white,
            padding: widget.padding, // ✅ p16 on all sides (matches screenshot)
            child: Row(
              children: [
                Expanded(
                  child: _MessageInputField(
                    controller: _controller,
                    enabled: widget.enabled,
                    hintText: widget.hintText,
                  ),
                ),
                const SizedBox(width: DLSpacing.p8),
                _SendButton(active: _canSend, onTap: _handleSend),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageInputField extends StatelessWidget {
  const _MessageInputField({
    required this.controller,
    required this.enabled,
    required this.hintText,
  });

  final TextEditingController controller;
  final bool enabled;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: DLSpacing.p16),
      decoration: BoxDecoration(
        color: DLColors.grey100,
        borderRadius: BorderRadius.circular(DLRadii.md),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: 1,
        style: DLTypos.textBaseRegular(
          color: enabled ? DLColors.black : DLColors.grey500,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: DLTypos.textBaseRegular(color: DLColors.grey500),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color bg = active ? DLColors.black : DLColors.grey100;
    final Color iconColor = active ? DLColors.white : DLColors.grey500;

    return GestureDetector(
      onTap: active ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(DLSpacing.p12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(DLRadii.full),
        ),
        child: FittedBox(child: Icon(Icons.arrow_upward, color: iconColor)),
      ),
    );
  }
}
