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
    this.width = 343,
    required this.title,
    this.description = 'Description',
    this.type = DLLineItemType.plain,
    this.enabled = true,

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

  /// Fixed width of the line item (defaults to 343).
  final double width;

  final String title;
  final String description;
  final DLLineItemType type;
  final bool enabled;

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
      return DLTypos.textBaseRegular(
        color: DLColors.grey500,
      ).copyWith(decoration: TextDecoration.lineThrough);
    }
    return DLTypos.textBaseSemibold(color: DLColors.black);
  }

  TextStyle get _descriptionStyle {
    if (!enabled) {
      return DLTypos.textSmRegular(
        color: DLColors.grey500,
      ).copyWith(decoration: TextDecoration.lineThrough);
    }
    return DLTypos.textSmRegular(color: DLColors.black);
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
          type: DLButtonType.secondary,
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
              color: DLColors.grey500,
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    final trailing = _buildTrailing();

    final row = ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 76, // height is hug — can grow with content
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DLSpacing.p16,
          vertical: DLSpacing.p12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title + description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: _titleStyle),
                  const SizedBox(height: 4),
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

    Widget content = SizedBox(
      width: width, // fixed width 343
      child: Column(
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
      ),
    );

    if (onTap != null &&
        (type == DLLineItemType.plain || type == DLLineItemType.icon)) {
      content = InkWell(onTap: enabled ? onTap : null, child: content);
    }

    return content;
  }
}
