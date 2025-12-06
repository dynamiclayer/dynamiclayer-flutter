// lib/demo/demo_chip_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/chip/dl_chip.dart';

class DemoChipPage extends StatelessWidget {
  const DemoChipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chip — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Chip sizes & states'),
          SizedBox(height: 8),
          _PreviewBlock(child: _ChipStatesPreview(), code: _chipCodeSample),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Preview: each row shows lg / md / sm in default, active, disabled
/// ---------------------------------------------------------------------------

class _ChipStatesPreview extends StatelessWidget {
  const _ChipStatesPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _SubHeader('Large (lg)'),
        SizedBox(height: 8),
        _ChipRow(size: DLChipSize.lg),
        SizedBox(height: 24),

        _SubHeader('Medium (md)'),
        SizedBox(height: 8),
        _ChipRow(size: DLChipSize.md),
        SizedBox(height: 24),

        _SubHeader('Small (sm)'),
        SizedBox(height: 8),
        _ChipRow(size: DLChipSize.sm),
      ],
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({super.key, required this.size});
  final DLChipSize size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          const [
            // 1) Interactive default chip (toggles active on tap)
            _InteractiveChipDemo(),
            SizedBox(width: 48),

            // 2) Active (selected)
            _ActiveChipSample(),
            SizedBox(width: 48),

            // 3) Disabled
            DLChip(
              label: 'Chip',
              size: DLChipSize.lg, // will be overridden in build below
              active: false,
              enabled: false,
              onTap: null,
            ),
          ].map((w) {
            // We need the size from this row, so wrap with Builder
            if (w is DLChip) {
              return DLChip(
                label: w.label,
                size: size,
                active: w.active,
                enabled: w.enabled,
                onTap: w.onTap,
              );
            }
            return w;
          }).toList(),
    );
  }
}

/// Interactive chip: toggles active state when tapped
class _InteractiveChipDemo extends StatefulWidget {
  const _InteractiveChipDemo({super.key});

  @override
  State<_InteractiveChipDemo> createState() => _InteractiveChipDemoState();
}

class _InteractiveChipDemoState extends State<_InteractiveChipDemo> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    // Size will be injected by _ChipRow wrapper
    return DLChip(
      label: 'Chip',
      size: DLChipSize.lg,
      active: _active,
      enabled: true,
      onTap: () {
        setState(() => _active = !_active);
      },
    );
  }
}

/// Active sample – enabled but non-interactive (no-op tap)
class _ActiveChipSample extends StatelessWidget {
  const _ActiveChipSample({super.key});

  @override
  Widget build(BuildContext context) {
    // Size will be injected by _ChipRow wrapper
    return DLChip(
      label: 'Chip',
      size: DLChipSize.lg,
      active: true,
      enabled: true,
      onTap: () {},
    );
  }
}

/// ---------- DOC UI helpers (same pattern as other catalog pages) ----------

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

/// ---------- Code sample shown in the docs ---------------------------------

const _chipCodeSample = '''// Interactive chip – toggles active state
class _InteractiveChipDemo extends StatefulWidget {
  const _InteractiveChipDemo({super.key});

  @override
  State<_InteractiveChipDemo> createState() => _InteractiveChipDemoState();
}

class _InteractiveChipDemoState extends State<_InteractiveChipDemo> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return DLChip(
      label: 'Chip',
      size: DLChipSize.lg,
      active: _active,
      enabled: true,
      onTap: () {
        setState(() => _active = !_active);
      },
    );
  }
}

// Active (selected) chip
DLChip(
  label: 'Chip',
  size: DLChipSize.md,
  active: true,
  enabled: true,
  onTap: () {}, // no-op to keep it enabled
);

// Disabled chip
const DLChip(
  label: 'Chip',
  size: DLChipSize.sm,
  active: false,
  enabled: false,
  onTap: null,
);
''';
