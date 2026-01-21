import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoTopNavigationPage extends StatelessWidget {
  const DemoTopNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Navigation — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Top Navigation (md / lg)', style: DLTypos.textLgBold()),
          const SizedBox(height: 12),

          // Preview card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F0F7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE6D9E6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Preview', style: DLTypos.textBaseSemibold()),
                const SizedBox(height: 12),

                // MD
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: const DLTopNavigation(
                    size: DLTopNavigationSize.md,
                    title: 'Title',
                    iconLeft: true,
                    iconRight: true,
                    separator: true,
                  ),
                ),
                const SizedBox(height: 24),

                // LG
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: const DLTopNavigation(
                    size: DLTopNavigationSize.lg,
                    title: 'Title',
                    iconLeft: true,
                    iconRight: true,
                    separator: true,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Text('Code', style: DLTypos.textBaseSemibold()),
          const SizedBox(height: 8),

          // Code preview block
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE9E1EA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFD2C5D4)),
            ),
            child: Text('''
// MD (center title)
DLTopNavigation(
  size: DLTopNavigationSize.md,
  title: 'Title',
  iconLeft: true,
  iconRight: true,
  separator: true,
);

// LG (left title, icons on right)
DLTopNavigation(
  size: DLTopNavigationSize.lg,
  title: 'Title',
  iconLeft: true,
  iconRight: true,
  separator: true,
);
''', style: DLTypos.textSmRegular()),
          ),
        ],
      ),
    );
  }
}
