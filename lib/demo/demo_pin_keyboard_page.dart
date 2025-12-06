// lib/demo/demo_pin_keyboard_page.dart
import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/pinkeyboard/dl_pin_key.dart';

class DemoPinKeyboardPage extends StatelessWidget {
  const DemoPinKeyboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PIN Keyboard — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('PIN keyboard layout'),
          SizedBox(height: 8),
          _PreviewBlock(
            child: _PinKeyboardPreview(),
            code: _pinKeyboardCodeSample,
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Preview: 3×4 PIN layout (1–9, 0, backspace) with live input
/// ---------------------------------------------------------------------------

class _PinKeyboardPreview extends StatefulWidget {
  const _PinKeyboardPreview({super.key});

  @override
  State<_PinKeyboardPreview> createState() => _PinKeyboardPreviewState();
}

class _PinKeyboardPreviewState extends State<_PinKeyboardPreview> {
  String _value = '';

  void _onDigit(String d) {
    setState(() {
      _value += d;
    });
  }

  void _onBackspace() {
    if (_value.isEmpty) return;
    setState(() {
      _value = _value.substring(0, _value.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _value.isEmpty ? 'Tap keys to enter PIN' : 'PIN: $_value',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            for (final d in ['1', '2', '3', '4', '5', '6', '7', '8', '9'])
              DLPinKey.text(
                number: d,
                alphabet: _alphabetForDigit(d),
                showAlphabet: d != '1',
                onPressed: () => _onDigit(d),
              ),
            // Row 4: [empty] [0] [back]
            const SizedBox(width: 80, height: 80),
            DLPinKey.text(
              number: '0',
              alphabet: '',
              showAlphabet: false,
              onPressed: () => _onDigit('0'),
            ),
            DLPinKey.icon(onPressed: _onBackspace),
          ],
        ),
      ],
    );
  }

  String _alphabetForDigit(String d) {
    switch (d) {
      case '2':
        return 'ABC';
      case '3':
        return 'DEF';
      case '4':
        return 'GHI';
      case '5':
        return 'JKL';
      case '6':
        return 'MNO';
      case '7':
        return 'PQRS';
      case '8':
        return 'TUV';
      case '9':
        return 'WXYZ';
      default:
        return '';
    }
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
              constraints: const BoxConstraints(maxWidth: 400),
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

const _pinKeyboardCodeSample = '''// Number key
DLPinKey.text(
  number: '2',
  alphabet: 'ABC',
  showAlphabet: true,
  onPressed: () => onDigitPressed('2'),
);

// Backspace key
DLPinKey.icon(
  onPressed: onBackspacePressed,
);

// Example 3×4 layout
Wrap(
  spacing: 16,
  runSpacing: 16,
  alignment: WrapAlignment.center,
  children: [
    for (final d in ['1','2','3','4','5','6','7','8','9'])
      DLPinKey.text(
        number: d,
        alphabet: alphabetForDigit(d),
        showAlphabet: d != '1',
        onPressed: () => onDigitPressed(d),
      ),
    const SizedBox(width: 80, height: 80),
    DLPinKey.text(
      number: '0',
      alphabet: '',
      showAlphabet: false,
      onPressed: () => onDigitPressed('0'),
    ),
    DLPinKey.icon(onPressed: onBackspacePressed),
  ],
);
''';
