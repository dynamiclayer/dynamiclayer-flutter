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
          _SectionHeader('OTP Row Example'),
          SizedBox(height: 8),
          _PreviewBlock(child: _OtpRowPreview(), code: _otpRowCode),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW 1 – all states in a Wrap
/// ---------------------------------------------------------------------------

class _OtpStatesPreview extends StatelessWidget {
  const _OtpStatesPreview();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: const [
        // default (empty)
        DLInputOtpCell(value: '', state: DLOtpCellState.normal),
        // active caret
        DLInputOtpCell(value: '', state: DLOtpCellState.active),
        // filled digit
        DLInputOtpCell(value: '3', state: DLOtpCellState.filled),
        // invisible (black dot)
        DLInputOtpCell(
          value: '4',
          state: DLOtpCellState.invisible,
          obscure: true,
        ),
        // error (red dot + red border / bg)
        DLInputOtpCell(value: '5', state: DLOtpCellState.error, obscure: true),
        // success (green dot + green border / bg)
        DLInputOtpCell(
          value: '6',
          state: DLOtpCellState.success,
          obscure: true,
        ),
        // disabled (dash)
        DLInputOtpCell(value: '', state: DLOtpCellState.disabled),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// PREVIEW 2 – typical OTP row
/// ---------------------------------------------------------------------------

class _OtpRowPreview extends StatelessWidget {
  const _OtpRowPreview();

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(width: 8);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        DLInputOtpCell(value: '1', state: DLOtpCellState.filled),
        gap,
        DLInputOtpCell(value: '2', state: DLOtpCellState.filled),
        gap,
        DLInputOtpCell(value: '3', state: DLOtpCellState.filled),
        gap,
        DLInputOtpCell(value: '', state: DLOtpCellState.active),
        gap,
        DLInputOtpCell(value: '', state: DLOtpCellState.normal),
        gap,
        DLInputOtpCell(value: '', state: DLOtpCellState.normal),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// Shared demo helpers
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

/// ---------------------------------------------------------------------------
/// Code samples
/// ---------------------------------------------------------------------------

const String _otpStatesCode = '''
Wrap(
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
    DLInputOtpCell(
      value: '5',
      state: DLOtpCellState.error,
      obscure: true,
    ),
    DLInputOtpCell(
      value: '6',
      state: DLOtpCellState.success,
      obscure: true,
    ),
    DLInputOtpCell(value: '', state: DLOtpCellState.disabled),
  ],
);
''';

const String _otpRowCode = '''
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    DLInputOtpCell(value: '1', state: DLOtpCellState.filled),
    SizedBox(width: 8),
    DLInputOtpCell(value: '2', state: DLOtpCellState.filled),
    SizedBox(width: 8),
    DLInputOtpCell(value: '3', state: DLOtpCellState.filled),
    SizedBox(width: 8),
    DLInputOtpCell(value: '', state: DLOtpCellState.active),
    SizedBox(width: 8),
    DLInputOtpCell(value: '', state: DLOtpCellState.normal),
    SizedBox(width: 8),
    DLInputOtpCell(value: '', state: DLOtpCellState.normal),
  ],
);
''';
