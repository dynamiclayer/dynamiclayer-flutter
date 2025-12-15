// lib/src/components/line_item/dl_line_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../dynamiclayers.dart';
import '../../../generated/assets.dart';
import '../switch/dl_switch.dart';
import '../checkbox/dl_checkbox.dart';
import '../radio/dl_radio_button.dart';
import '../buttons/dl_button.dart';
import '../separator/dl_separator.dart';

enum DLLineItemType {
  plain,
  switchControl,
  button,
  checkbox,
  radioButton,
  icon,
}

class DLLineItem extends StatelessWidget {
  const DLLineItem({
    super.key,
    this.width, // hug by default
    required this.title,
    this.description = 'Description',
    this.type = DLLineItemType.plain,
    this.enabled = true,

    // Left icon
    this.showLeftIcon = false,
    this.leftIcon,

    // Switch
    this.switchValue,
    this.onSwitchChanged,

    // Button
    this.buttonLabel,
    this.onButtonPressed,

    // Checkbox
    this.checkboxValue,
    this.onCheckboxChanged,

    // Radio
    this.radioSelected,
    this.onRadioChanged,

    // Icon / tap
    this.trailingIcon,
    this.onTap,

    // Separator control
    this.showBottomSeparator = true,
  });

  /// Optional width. If null -> hug (takes parent constraints).
  final double? width;

  final String title;
  final String description;
  final DLLineItemType type;
  final bool enabled;

  // Left icon
  final bool showLeftIcon;

  /// Left icon widget override. Default: Icon(Icons.fullscreen)
  final Widget? leftIcon;

  // Switch
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  // Button
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;

  // Checkbox
  final bool? checkboxValue;
  final ValueChanged<bool?>? onCheckboxChanged;

  // Radio
  final bool? radioSelected;
  final ValueChanged<bool>? onRadioChanged;

  // Icon / tap
  final Widget? trailingIcon;
  final VoidCallback? onTap;

  /// Whether to show the bottom separator (default: true).
  final bool showBottomSeparator;

  TextStyle get _titleStyle {
    if (!enabled) {
      return DLTypos.textSmStrike(
        color: DLColors.grey500,
      ).copyWith(fontWeight: FontWeight.w400);
    }
    return DLTypos.textBaseSemibold(color: DLColors.black);
  }

  TextStyle get _descriptionStyle {
    if (!enabled) {
      return DLTypos.textSmStrike(
        color: DLColors.grey500,
      ).copyWith(fontWeight: FontWeight.w400);
    }
    return DLTypos.textSmRegular(color: DLColors.black);
  }

  Widget _buildLeftIcon() {
    return leftIcon ?? const Icon(Icons.fullscreen, size: 20);
  }

  Widget? _buildTrailing() {
    switch (type) {
      case DLLineItemType.plain:
        return trailingIcon;

      case DLLineItemType.switchControl:
        return DLSwitch(
          value: switchValue ?? false,
          onChanged: onSwitchChanged,
          enabled: enabled,
        );

      case DLLineItemType.button:
        return DLButton(
          type: DLButtonType.tertiary,
          size: DLButtonSize.xs,
          label: buttonLabel ?? 'Add',
          onPressed: enabled ? onButtonPressed : null,
          enabled: enabled,
          fixedWidth: true,
        );

      case DLLineItemType.checkbox:
        return DLCheckbox(
          value: checkboxValue ?? false,
          onChanged: onCheckboxChanged,
          enabled: enabled,
        );

      case DLLineItemType.radioButton:
        return DLRadioButton(
          selected: radioSelected ?? false,
          onChanged: onRadioChanged,
          enabled: enabled,
        );

      case DLLineItemType.icon:
        return trailingIcon ??
            SvgPicture.asset(
              Assets.lineItemArrowFarword,
              width: 8,
              height: 14,
              color: DLColors.black, // chevron must be black
            );
    }
  }

  bool get _hasAnyTap =>
      enabled &&
      (onTap != null ||
          onButtonPressed != null ||
          onSwitchChanged != null ||
          onCheckboxChanged != null ||
          onRadioChanged != null);

  void _handleTap() {
    if (!enabled) return;

    // Priority: explicit onTap always wins if provided
    if (onTap != null) {
      onTap!.call();
      return;
    }

    // Otherwise, type-driven interactions
    switch (type) {
      case DLLineItemType.checkbox:
        final current = checkboxValue ?? false;
        onCheckboxChanged?.call(!current);
        break;

      case DLLineItemType.radioButton:
        // Set selected to true on tap
        onRadioChanged?.call(true);
        break;

      case DLLineItemType.switchControl:
        final current = switchValue ?? false;
        onSwitchChanged?.call(!current);
        break;

      case DLLineItemType.button:
        onButtonPressed?.call();
        break;

      case DLLineItemType.plain:
      case DLLineItemType.icon:
        // no-op if onTap was null (handled above)
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final trailing = _buildTrailing();

    Widget row = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 76),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DLSpacing.p0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showLeftIcon) ...[
              _buildLeftIcon(),
              const SizedBox(width: DLSpacing.p12),
            ],

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: _titleStyle),
                  SizedBox(height: DLSpacing.p8),
                  Text(description, style: _descriptionStyle),
                ],
              ),
            ),

            if (trailing != null) ...[
              const SizedBox(width: DLSpacing.p16),
              trailing,
            ],
          ],
        ),
      ),
    );

    // Make the whole item tappable for ALL trailing types as well.
    if (_hasAnyTap) {
      row = InkWell(onTap: _handleTap, child: row);
    }

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        row,
        if (showBottomSeparator)
          const DLSeparator(
            direction: DLSeparatorDirection.horizontal,
            thickness: 1,
            color: DLColors.grey200,
          ),
      ],
    );

    if (width != null) {
      content = SizedBox(width: width, child: content);
    }

    return content;
  }
}
