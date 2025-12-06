import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/buttons/dl_icon_button.dart';

class DemoIconButtonPage extends StatelessWidget {
  const DemoIconButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icon Buttons — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('LG — primary / secondary / tertiary'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _IconButtonsPreview(size: DLIconButtonSize.lg),
            code: _iconButtonsCode,
          ),
          SizedBox(height: 24),
          _SectionHeader('MD — primary / secondary / tertiary'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _IconButtonsPreview(size: DLIconButtonSize.md),
            code: _iconButtonsCode,
          ),
          SizedBox(height: 24),
          _SectionHeader('SM — primary / secondary / tertiary'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _IconButtonsPreview(size: DLIconButtonSize.sm),
            code: _iconButtonsCode,
          ),
          SizedBox(height: 24),
          _SectionHeader('XS — primary / secondary / tertiary'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _IconButtonsPreview(size: DLIconButtonSize.xs),
            code: _iconButtonsCode,
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Icon Buttons Preview
/// ---------------------------------------------------------------------------
class _IconButtonsPreview extends StatelessWidget {
  const _IconButtonsPreview({required this.size});

  final DLIconButtonSize size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RowLabel('Primary'),
        const SizedBox(height: 8),
        _IconTypeRow(type: DLIconButtonType.primary, size: size),
        const SizedBox(height: 16),
        _RowLabel('Secondary'),
        const SizedBox(height: 8),
        _IconTypeRow(type: DLIconButtonType.secondary, size: size),
        const SizedBox(height: 16),
        _RowLabel('Tertiary'),
        const SizedBox(height: 8),
        _IconTypeRow(type: DLIconButtonType.tertiary, size: size),
      ],
    );
  }
}

class _RowLabel extends StatelessWidget {
  const _RowLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

/// One row of 4 states: default / hover / pressed / disabled
class _IconTypeRow extends StatelessWidget {
  const _IconTypeRow({required this.type, required this.size});

  final DLIconButtonType type;
  final DLIconButtonSize size;

  @override
  Widget build(BuildContext context) {
    const spacing = 16.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children:
          const [
            // Default
            _StateButton(label: 'Default', state: DLIconButtonState.normal),
            SizedBox(width: spacing),
            // Hover
            _StateButton(label: 'Hover', state: DLIconButtonState.hover),
            SizedBox(width: spacing),
            // Pressed
            _StateButton(label: 'Pressed', state: DLIconButtonState.pressed),
            SizedBox(width: spacing),
            // Disabled
            _StateButton(label: 'Disabled', state: DLIconButtonState.disabled),
          ].map((w) {
            // We need access to type & size for each button; wrap later.
            // This dummy map will be replaced below in build() body.
            return w;
          }).toList(),
    );
  }
}

/// Small helper to inject type/size into each state button
class _StateButton extends StatelessWidget {
  const _StateButton({required this.label, required this.state});

  final String label;
  final DLIconButtonState state;

  @override
  Widget build(BuildContext context) {
    // We'll get the parent type/size via an InheritedWidget or simple
    // pattern: for demo simplicity, we just hardcode a fullscreen icon.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DLIconButton(
          type: (context.findAncestorWidgetOfExactType<_IconTypeRow>()!).type,
          size: (context.findAncestorWidgetOfExactType<_IconTypeRow>()!).size,
          state: state,
          icon: const Icon(Icons.fullscreen),
        ),
      ],
    );
  }
}

/// ---------- DOC UI helpers (same pattern as other catalog pages) ----------
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
        const _SubHeader('Code'),
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

/// ---------- Code Sample (generic) ----------
const _iconButtonsCode = '''
// Icon buttons for all states of a given type/size
Row(
  mainAxisSize: MainAxisSize.min,
  children: const [
    // Default
    DLIconButton(
      type: DLIconButtonType.primary,
      size: DLIconButtonSize.lg,
      icon: Icon(Icons.fullscreen),
    ),
    SizedBox(width: 16),

    // Hover (forced visual state)
    DLIconButton(
      type: DLIconButtonType.primary,
      size: DLIconButtonSize.lg,
      state: DLIconButtonState.hover,
      icon: Icon(Icons.fullscreen),
    ),
    SizedBox(width: 16),

    // Pressed (forced visual state)
    DLIconButton(
      type: DLIconButtonType.primary,
      size: DLIconButtonSize.lg,
      state: DLIconButtonState.pressed,
      icon: Icon(Icons.fullscreen),
    ),
    SizedBox(width: 16),

    // Disabled
    DLIconButton(
      type: DLIconButtonType.primary,
      size: DLIconButtonSize.lg,
      state: DLIconButtonState.disabled,
      icon: Icon(Icons.fullscreen),
    ),
  ],
);
''';
