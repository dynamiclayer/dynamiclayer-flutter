import 'package:flutter/material.dart';
import '../dynamiclayers.dart'; // exposes DynamicLayers.buttons, DLButtonType, DLButtonSize, DLButtonState

class DemoButtonsCatalogPage extends StatelessWidget {
  const DemoButtonsCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons — Catalog')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            _SectionHeader('Variants'),
            _PreviewBlock(child: _VariantsPreview(), code: _variantsCode),
            SizedBox(height: 20),
            _SectionHeader('Size'),
            _PreviewBlock(child: _SizesPreview(), code: _sizesCode),
            SizedBox(height: 20),
            _SectionHeader('Disabled'),
            _PreviewBlock(child: _DisabledPreview(), code: _disabledCode),
            SizedBox(height: 20),
            _SectionHeader('With Icon'),
            _PreviewBlock(child: _WithIconPreview(), code: _withIconCode),
          ],
        ),
      ),
    );
  }
}

/// ---------- Variants ----------
class _VariantsPreview extends StatelessWidget {
  const _VariantsPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        DynamicLayers.buttons(
          type: DLButtonType.primary,
          label: 'Primary',
          onPressed: () {},
        ),
        DynamicLayers.buttons(
          type: DLButtonType.secondary,
          label: 'Secondary',
          onPressed: () {},
        ),
        DynamicLayers.buttons(
          type: DLButtonType.tertiary,
          label: 'Tertiary',
          onPressed: () {},
        ),
        DynamicLayers.buttons(
          type: DLButtonType.ghost,
          label: 'Ghost',
          onPressed: () {},
        ),
      ],
    );
  }
}

/// ---------- Sizes ----------
class _SizesPreview extends StatelessWidget {
  const _SizesPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        DynamicLayers.buttons(
          type: DLButtonType.primary,
          size: DLButtonSize.lg,
          label: 'Button',
          onPressed: () {},
        ),
        DynamicLayers.buttons(
          type: DLButtonType.primary,
          size: DLButtonSize.md,
          label: 'Button',
          onPressed: () {},
        ),
        DynamicLayers.buttons(
          type: DLButtonType.primary,
          size: DLButtonSize.sm,
          label: 'Button',
          onPressed: () {},
        ),
        DynamicLayers.buttons(
          type: DLButtonType.primary,
          size: DLButtonSize.xs,
          label: 'Button',
          onPressed: () {},
        ),
      ],
    );
  }
}

/// ---------- Disabled ----------
class _DisabledPreview extends StatelessWidget {
  const _DisabledPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        DynamicLayers.buttons(
          type: DLButtonType.primary,
          label: 'Primary',
          enabled: false,
          onPressed: null,
        ),
        DynamicLayers.buttons(
          type: DLButtonType.secondary,
          label: 'Secondary',
          enabled: false,
          onPressed: null,
        ),
        DynamicLayers.buttons(
          type: DLButtonType.tertiary,
          label: 'Tertiary',
          enabled: false,
          onPressed: null,
        ),
        DynamicLayers.buttons(
          type: DLButtonType.ghost,
          label: 'Ghost',
          enabled: false,
          onPressed: null,
        ),
      ],
    );
  }
}

/// ---------- With Icon ----------
class _WithIconPreview extends StatelessWidget {
  const _WithIconPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        DynamicLayers.buttons(
          type: DLButtonType.primary,
          label: 'Button',
          iconLeft: const Icon(Icons.add, size: 18),
          onPressed: () {},
        ),
        DynamicLayers.buttons(
          type: DLButtonType.secondary,
          label: 'Button',
          iconRight: const Icon(Icons.chevron_right, size: 18),
          onPressed: () {},
        ),
      ],
    );
  }
}

/// ---------- UI Bits ----------
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
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
  const _PreviewBlock({required this.child, required this.code});
  final Widget child;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SubHeader('Preview'),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: _surface(context),
          child: child,
        ),
        const SizedBox(height: 12),
        _SubHeader('Code'),
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
  const _SubHeader(this.title);
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
  const _CodeBox({required this.code});
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

/// ---------- Code Samples (kept as raw strings so they render nicely) ----------
const _variantsCode = '''
// Variants
DynamicLayers.buttons(
  type: DLButtonType.primary,
  label: 'Primary',
  onPressed: () {},
);

DynamicLayers.buttons(
  type: DLButtonType.secondary,
  label: 'Secondary',
  onPressed: () {},
);

DynamicLayers.buttons(
  type: DLButtonType.tertiary,
  label: 'Tertiary',
  onPressed: () {},
);

DynamicLayers.buttons(
  type: DLButtonType.ghost,
  label: 'Ghost',
  onPressed: () {},
);
''';

const _sizesCode = '''
// Sizes (lg, md, sm, xs)
DynamicLayers.buttons(
  type: DLButtonType.primary,
  size: DLButtonSize.lg,
  label: 'Button',
  onPressed: () {},
);

DynamicLayers.buttons(
  type: DLButtonType.primary,
  size: DLButtonSize.md,
  label: 'Button',
  onPressed: () {},
);

DynamicLayers.buttons(
  type: DLButtonType.primary,
  size: DLButtonSize.sm,
  label: 'Button',
  onPressed: () {},
);

DynamicLayers.buttons(
  type: DLButtonType.primary,
  size: DLButtonSize.xs,
  label: 'Button',
  onPressed: () {},
);
''';

const _disabledCode = '''
// Disabled (either enabled: false or onPressed: null)
DynamicLayers.buttons(
  type: DLButtonType.primary,
  label: 'Primary',
  enabled: false,
  onPressed: null,
);

DynamicLayers.buttons(
  type: DLButtonType.secondary,
  label: 'Secondary',
  enabled: false,
  onPressed: null,
);

DynamicLayers.buttons(
  type: DLButtonType.tertiary,
  label: 'Tertiary',
  enabled: false,
  onPressed: null,
);

DynamicLayers.buttons(
  type: DLButtonType.ghost,
  label: 'Ghost',
  enabled: false,
  onPressed: null,
);
''';

const _withIconCode = '''
// With Icon (left/right)
DynamicLayers.buttons(
  type: DLButtonType.primary,
  label: 'Button',
  iconLeft: Icon(Icons.add, size: 18),
  onPressed: () {},
);

DynamicLayers.buttons(
  type: DLButtonType.secondary,
  label: 'Button',
  iconRight: Icon(Icons.chevron_right, size: 18),
  onPressed: () {},
);
''';
