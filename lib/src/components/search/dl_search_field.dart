// lib/src/components/search/dl_search_field.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../dynamiclayers.dart';

enum DLSearchFieldSize { lg, md, sm }

class DLSearchField extends StatefulWidget {
  const DLSearchField({
    super.key,
    this.size = DLSearchFieldSize.lg,

    /// Spec: width fixed = 320 by default.
    this.width = 320,

    this.placeholder = 'Search Field',
    this.controller,
    this.onChanged,

    /// Behavior
    this.enabled = true,
    this.showLeadingIcon = true,
    this.showClearIcon = true,

    /// Assets (SVG)
    this.searchIconAsset = 'assets/search/search.svg',
    this.clearIconAsset = 'assets/search/x.svg',

    /// Optional overrides (if provided, assets are ignored for that slot)
    this.leadingIcon,
    this.clearIcon,
  });

  final DLSearchFieldSize size;
  final double width;

  final String placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  final bool enabled;
  final bool showLeadingIcon;
  final bool showClearIcon;

  final String searchIconAsset;
  final String clearIconAsset;

  final Widget? leadingIcon;
  final Widget? clearIcon;

  @override
  State<DLSearchField> createState() => _DLSearchFieldState();
}

class _DLSearchFieldState extends State<DLSearchField> {
  late TextEditingController _controller;
  late bool _ownsController;

  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  bool _hovering = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();

    _hasText = _controller.text.trim().isNotEmpty;

    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant DLSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (_ownsController) _controller.dispose();

      _ownsController = widget.controller == null;
      final newController = widget.controller ?? TextEditingController();
      newController.text = _controller.text;

      _controller.removeListener(_onTextChanged);
      _focusNode.removeListener(_onFocusChanged);

      _controller = newController;
      _hasText = _controller.text.trim().isNotEmpty;

      _controller.addListener(_onTextChanged);
      _focusNode.addListener(_onFocusChanged);
    }
  }

  void _onFocusChanged() {
    setState(() => _hasFocus = _focusNode.hasFocus);
  }

  void _onTextChanged() {
    final has = _controller.text.trim().isNotEmpty;
    if (has != _hasText) setState(() => _hasText = has);
    widget.onChanged?.call(_controller.text);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (_ownsController) _controller.dispose();

    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  bool get _isEnabled => widget.enabled;

  // ---------------------------- Spec tokens ----------------------------

  double _height() {
    switch (widget.size) {
      case DLSearchFieldSize.lg:
        return 56;
      case DLSearchFieldSize.md:
        return 48;
      case DLSearchFieldSize.sm:
        return 40;
    }
  }

  EdgeInsets _padding() {
    switch (widget.size) {
      case DLSearchFieldSize.lg:
        return const EdgeInsets.symmetric(horizontal: DLSpacing.p16);
      case DLSearchFieldSize.md:
        return const EdgeInsets.symmetric(horizontal: DLSpacing.p16);
      case DLSearchFieldSize.sm:
        return const EdgeInsets.symmetric(horizontal: DLSpacing.p12);
    }
  }

  Color _backgroundColor() {
    // Hover state background = grey200. Default/Active/Filled/Disabled = grey100.
    if (!_isEnabled) return DLColors.grey100;
    if (_hovering && !_hasFocus) return DLColors.grey200;
    return DLColors.grey100;
  }

  // To avoid layout jump, keep border width stable at 2 and toggle color.
  double _borderWidth() => DLBorderWidth.w2;

  Color _borderColor() {
    if (!_isEnabled) return Colors.transparent;
    if (_hasFocus) return DLColors.black; // active
    return Colors.transparent; // default/hover/filled
  }

  BorderRadius _radius() => BorderRadius.circular(DLRadii.full);

  double _gap() => 16;

  TextStyle _textStyle() {
    final base = widget.size == DLSearchFieldSize.sm
        ? DLTypos.textSmRegular(color: DLColors.black)
        : DLTypos.textBaseRegular(color: DLColors.black);

    if (!_isEnabled) {
      return (widget.size == DLSearchFieldSize.sm
              ? DLTypos.textSmStrike(color: DLColors.grey500)
              : DLTypos.textBaseStrike(color: DLColors.grey500))
          .copyWith(color: DLColors.grey500);
    }
    return base;
  }

  TextStyle _hintStyle() {
    final base = widget.size == DLSearchFieldSize.sm
        ? DLTypos.textSmRegular(color: DLColors.grey500)
        : DLTypos.textBaseRegular(color: DLColors.grey500);

    if (!_isEnabled) {
      return (widget.size == DLSearchFieldSize.sm
              ? DLTypos.textSmStrike(color: DLColors.grey500)
              : DLTypos.textBaseStrike(color: DLColors.grey500))
          .copyWith(color: DLColors.grey500);
    }
    return base;
  }

  Color _iconColor() => _isEnabled ? DLColors.grey500 : DLColors.grey500;

  Widget _buildLeading() {
    if (!widget.showLeadingIcon) return const SizedBox.shrink();

    final icon =
        widget.leadingIcon ??
        SvgPicture.asset(
          widget.searchIconAsset,
          width: 24,
          height: 24,
          color: _iconColor(),
        );

    return SizedBox(width: 24, height: 24, child: Center(child: icon));
  }

  Widget _buildClear() {
    final canShow = widget.showClearIcon && _hasText && _isEnabled;
    if (!canShow) return const SizedBox.shrink();

    final icon =
        widget.clearIcon ??
        SvgPicture.asset(
          widget.clearIconAsset,
          width: 24,
          height: 24,
          color: _iconColor(),
        );

    return InkResponse(
      onTap: () {
        _controller.clear();
        widget.onChanged?.call('');
        // keep focus for better UX (matches typical search fields)
        if (!_hasFocus) _focusNode.requestFocus();
      },
      radius: 24,
      child: SizedBox(width: 24, height: 24, child: Center(child: icon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final field = Container(
      width: widget.width,
      height: _height(),
      padding: _padding(),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: _radius(),
        border: Border.all(width: _borderWidth(), color: _borderColor()),
      ),
      child: Row(
        children: [
          if (widget.showLeadingIcon) ...[
            _buildLeading(),
            SizedBox(width: _gap()),
          ],
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              enabled: _isEnabled,
              style: _textStyle(),
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: widget.placeholder,
                hintStyle: _hintStyle(),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (widget.showClearIcon) ...[SizedBox(width: _gap()), _buildClear()],
        ],
      ),
    );

    // Hover is relevant mainly on web/desktop; safe everywhere.
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: field,
    );
  }
}
