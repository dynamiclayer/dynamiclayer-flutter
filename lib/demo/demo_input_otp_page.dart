// lib/demo/demo_input_otp_page.dart
import 'package:flutter/material.dart';

import '../dynamiclayers.dart';
import '../src/components/input/dl_input_otp_cell.dart';

class DemoInputOtpPage extends StatelessWidget {
  const DemoInputOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input OTP — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('OTP Cell States'),
          SizedBox(height: 8),
          _PreviewBlock(child: _OtpStatesPreview(), code: _otpStatesCode),
          SizedBox(height: 24),
          _SectionHeader('OTP Row Example (Interactive)'),
          SizedBox(height: 8),
          _PreviewBlock(child: _OtpRowPreview(), code: _otpRowCode),
        ],
      ),
    );
  }
}

class _OtpStatesPreview extends StatelessWidget {
  const _OtpStatesPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: const [
        DLInputOtpCell(value: '', state: DLOtpCellState.normal),
        DLInputOtpCell(value: '', state: DLOtpCellState.active),
        DLInputOtpCell(value: '3', state: DLOtpCellState.filled),
        DLInputOtpCell(
          value: '4',
          state: DLOtpCellState.invisible,
          obscure: true,
        ),
        DLInputOtpCell(value: '5', state: DLOtpCellState.error, obscure: true),
        DLInputOtpCell(
          value: '6',
          state: DLOtpCellState.success,
          obscure: true,
        ),
        DLInputOtpCell(value: '', state: DLOtpCellState.disabled),
      ],
    );
  }
}

class _OtpRowPreview extends StatefulWidget {
  const _OtpRowPreview();

  @override
  State<_OtpRowPreview> createState() => _OtpRowPreviewState();
}

class _OtpRowPreviewState extends State<_OtpRowPreview> {
  static const int _len = 6;

  late final List<TextEditingController> _controllers = List.generate(
    _len,
    (_) => TextEditingController(),
  );
  late final List<FocusNode> _nodes = List.generate(_len, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _focus(int index) {
    if (index < 0 || index >= _len) return;
    _nodes[index].requestFocus();
  }

  void _onChanged(int index, String v) {
    // Keep 1 char only (last).
    if (v.length > 1) {
      final last = v.characters.last;
      _controllers[index].text = last;
      _controllers[index].selection = const TextSelection.collapsed(offset: 1);
    }

    setState(() {});

    if (_controllers[index].text.isNotEmpty && index < _len - 1) {
      _focus(index + 1);
    }
  }

  void _onBackspaceEmpty(int index) {
    if (index <= 0) return;
    _controllers[index - 1].clear();
    setState(() {});
    _focus(index - 1);
  }

  DLOtpCellState _stateForIndex(int index) {
    if (_controllers[index].text.isNotEmpty) return DLOtpCellState.filled;
    if (_nodes[index].hasFocus) return DLOtpCellState.active;
    return DLOtpCellState.normal;
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(width: 8);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_len, (i) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DLInputOtpCell(
              value: '',
              controller: _controllers[i],
              focusNode: _nodes[i],
              state: _stateForIndex(i),
              keyboardType: TextInputType.number,
              textInputAction: i == _len - 1
                  ? TextInputAction.done
                  : TextInputAction.next,
              onTap: () => _focus(i),
              onChanged: (v) => _onChanged(i, v),
              onBackspaceWhenEmpty: () => _onBackspaceEmpty(i),
            ),
            if (i != _len - 1) gap,
          ],
        );
      }),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Shared demo helpers (unchanged)
/// ---------------------------------------------------------------------------

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

const String _otpStatesCode = '''
Wrap(
  spacing: 24,
  runSpacing: 16,
  alignment: WrapAlignment.center,
  children: const [
    DLInputOtpCell(value: '', state: DLOtpCellState.normal),
    DLInputOtpCell(value: '', state: DLOtpCellState.active),
    DLInputOtpCell(value: '3', state: DLOtpCellState.filled),
    DLInputOtpCell(value: '4', state: DLOtpCellState.invisible, obscure: true),
    DLInputOtpCell(value: '5', state: DLOtpCellState.error, obscure: true),
    DLInputOtpCell(value: '6', state: DLOtpCellState.success, obscure: true),
    DLInputOtpCell(value: '', state: DLOtpCellState.disabled),
  ],
);
''';

const String _otpRowCode = '''
// Interactive row: uses controllers + focus nodes and onBackspaceWhenEmpty.
''';
