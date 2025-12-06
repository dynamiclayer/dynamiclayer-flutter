// lib/demo/demo_line_item_page.dart
import 'package:flutter/material.dart';

import '../dynamiclayers.dart';
import '../src/components/line_item/dl_line_item.dart';
import '../src/components/switch/dl_switch.dart';
import '../src/components/checkbox/dl_checkbox.dart';
import '../src/components/radio/dl_radio_button.dart';
import '../src/components/buttons/dl_button.dart';

class DemoLineItemPage extends StatelessWidget {
  const DemoLineItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Line Item — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Default'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _DefaultLineItemsPreview(),
            code: _defaultCodeSample,
          ),
          SizedBox(height: 24),

          _SectionHeader('With Switch'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _SwitchLineItemsPreview(),
            code: _switchCodeSample,
          ),
          SizedBox(height: 24),

          _SectionHeader('With Button'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _ButtonLineItemsPreview(),
            code: _buttonCodeSample,
          ),
          SizedBox(height: 24),

          _SectionHeader('With Checkbox'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _CheckboxLineItemsPreview(),
            code: _checkboxCodeSample,
          ),
          SizedBox(height: 24),

          _SectionHeader('With Radio Button'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _RadioLineItemsPreview(),
            code: _radioCodeSample,
          ),
          SizedBox(height: 24),

          _SectionHeader('With Trailing Icon'),
          SizedBox(height: 8),
          _PreviewBlock(child: _IconLineItemsPreview(), code: _iconCodeSample),
        ],
      ),
    );
  }
}

//
// PREVIEWS
//

class _DefaultLineItemsPreview extends StatelessWidget {
  const _DefaultLineItemsPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.plain,
          enabled: true,
        ),
        DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.plain,
          enabled: false,
        ),
      ],
    );
  }
}

class _SwitchLineItemsPreview extends StatefulWidget {
  const _SwitchLineItemsPreview();

  @override
  State<_SwitchLineItemsPreview> createState() =>
      _SwitchLineItemsPreviewState();
}

class _SwitchLineItemsPreviewState extends State<_SwitchLineItemsPreview> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.switchControl,
          switchValue: _value,
          onSwitchChanged: (v) => setState(() => _value = v),
          enabled: true,
        ),
        const DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.switchControl,
          switchValue: false,
          enabled: false,
        ),
      ],
    );
  }
}

class _ButtonLineItemsPreview extends StatelessWidget {
  const _ButtonLineItemsPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.button,
          buttonLabel: 'Add',
          enabled: true,
        ),
        DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.button,
          buttonLabel: 'Add',
          enabled: false,
        ),
      ],
    );
  }
}

class _CheckboxLineItemsPreview extends StatefulWidget {
  const _CheckboxLineItemsPreview();

  @override
  State<_CheckboxLineItemsPreview> createState() =>
      _CheckboxLineItemsPreviewState();
}

class _CheckboxLineItemsPreviewState extends State<_CheckboxLineItemsPreview> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.checkbox,
          checkboxValue: _checked,
          onCheckboxChanged: (v) => setState(() => _checked = v ?? false),
          enabled: true,
        ),
        const DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.checkbox,
          checkboxValue: false,
          enabled: false,
        ),
      ],
    );
  }
}

class _RadioLineItemsPreview extends StatefulWidget {
  const _RadioLineItemsPreview();

  @override
  State<_RadioLineItemsPreview> createState() => _RadioLineItemsPreviewState();
}

class _RadioLineItemsPreviewState extends State<_RadioLineItemsPreview> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.radioButton,
          radioSelected: _selected,
          onRadioChanged: (_) => setState(() => _selected = true),
          enabled: true,
        ),
        const DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.radioButton,
          radioSelected: false,
          enabled: false,
        ),
      ],
    );
  }
}

class _IconLineItemsPreview extends StatelessWidget {
  const _IconLineItemsPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.icon,
          enabled: true,
        ),
        DLLineItem(
          title: 'Title',
          description: 'Description',
          type: DLLineItemType.icon,
          enabled: false,
        ),
      ],
    );
  }
}

//
// DOC UI HELPERS
//

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _PreviewBlock extends StatelessWidget {
  const _PreviewBlock({super.key, required this.child, required this.code});
  final Widget child;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _SubHeader('Preview'),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: _surface(context),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 740),
              child: child,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _SubHeader('How to use'),
        const SizedBox(height: 8),
        _CodeBox(code: code),
      ],
    );
  }

  BoxDecoration _surface(BuildContext context) => BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    border: Border.all(color: Colors.black12),
    borderRadius: BorderRadius.circular(12),
  );
}

class _SubHeader extends StatelessWidget {
  const _SubHeader(this.title, {super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({super.key, required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).colorScheme.surfaceVariant;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: SelectableText(
        code,
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12.5),
      ),
    );
  }
}

//
// CODE SAMPLES
//

const _defaultCodeSample = '''
// Default and disabled, no trailing control
Column(
  children: const [
    DLLineItem(
      title: 'Title',
      description: 'Description',
      type: DLLineItemType.plain,
      enabled: true,
      showTopSeparator: true,
    ),
    DLLineItem(
      title: 'Title',
      description: 'Description',
      type: DLLineItemType.plain,
      enabled: false,
      showTopSeparator: false,
    ),
  ],
);
''';

const _switchCodeSample = '''
bool value = false;

DLLineItem(
  title: 'Title',
  description: 'Description',
  type: DLLineItemType.switchControl,
  switchValue: value,
  onSwitchChanged: (v) => setState(() => value = v),
);
''';

const _buttonCodeSample = '''
DLLineItem(
  title: 'Title',
  description: 'Description',
  type: DLLineItemType.button,
  buttonLabel: 'Add',
  onButtonPressed: () {
    // handle tap
  },
);
''';

const _checkboxCodeSample = '''
bool checked = false;

DLLineItem(
  title: 'Title',
  description: 'Description',
  type: DLLineItemType.checkbox,
  checkboxValue: checked,
  onCheckboxChanged: (v) => setState(() => checked = v ?? false),
);
''';

const _radioCodeSample = '''
bool selected = false;

DLLineItem(
  title: 'Title',
  description: 'Description',
  type: DLLineItemType.radioButton,
  radioSelected: selected,
  onRadioChanged: (_) => setState(() => selected = true),
);
''';

const _iconCodeSample = '''
DLLineItem(
  title: 'Title',
  description: 'Description',
  type: DLLineItemType.icon,
  onTap: () {
    // navigate or open details
  },
);
''';
