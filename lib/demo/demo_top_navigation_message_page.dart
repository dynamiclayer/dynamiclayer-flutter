import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/top_navigation_message/dl_top_navigation_message.dart';

class DemoTopNavigationMessagePage extends StatelessWidget {
  const DemoTopNavigationMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Navigation Message — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Top Navigation Message (single-line / two-line)',
            style: DLTypos.textLgBold(),
          ),
          const SizedBox(height: 12),

          _DemoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Preview', style: DLTypos.textBaseSemibold()),
                const SizedBox(height: 12),

                // Variant A: title only
                const DLTopNavigationMessage(
                  title: 'Chat name',
                  showSeparator: true,
                ),
                const SizedBox(height: 12),
                // Variant B: title + description
                const DLTopNavigationMessage(
                  title: 'Chat name',
                  description: 'Andrew Doe, Matthew Black, Lisa Smith',
                  showSeparator: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Text('Code', style: DLTypos.textBaseSemibold()),
          const SizedBox(height: 8),

          _CodeCard(
            code: r'''
// Variant A (title only)
const DLTopNavigationMessage(
  title: 'Chat name',
  showSeparator: true,
);

// Variant B (title + description)
const DLTopNavigationMessage(
  title: 'Chat name',
  description: 'Andrew Doe, Matthew Black, Lisa Smith',
  showSeparator: true,
);
''',
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F0F7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6D9E6)),
      ),
      child: child,
    );
  }
}

class _CodeCard extends StatelessWidget {
  const _CodeCard({required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9E1EA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD2C5D4)),
      ),
      child: Text(code, style: DLTypos.textSmRegular()),
    );
  }
}
