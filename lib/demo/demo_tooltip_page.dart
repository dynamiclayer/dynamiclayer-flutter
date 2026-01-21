import 'package:flutter/material.dart';
import '../dynamiclayers.dart';
import '../src/components/tooltip/dl_tooltip.dart';

class DemoTooltipPage extends StatelessWidget {
  const DemoTooltipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tooltip — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Tooltip variants (top / bottom / left / right)',
            style: DLTypos.textSmRegular(),
          ),
          const SizedBox(height: 12),

          // Preview card (keep consistent with your other demo cards)
          _DemoCard(
            title: 'Preview',
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: const [
                _TooltipTile(
                  title: 'Top',
                  child: DLTooltip(
                    label: 'Lorem ipsum',
                    direction: DLTooltipDirection.top,
                  ),
                ),
                _TooltipTile(
                  title: 'Bottom',
                  child: DLTooltip(
                    label: 'Lorem ipsum',
                    direction: DLTooltipDirection.bottom,
                  ),
                ),
                _TooltipTile(
                  title: 'Left',
                  child: DLTooltip(
                    label: 'Lorem ipsum',
                    direction: DLTooltipDirection.left,
                  ),
                ),
                _TooltipTile(
                  title: 'Right',
                  child: DLTooltip(
                    label: 'Lorem ipsum',
                    direction: DLTooltipDirection.right,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Text('Code', style: DLTypos.textBaseBold()),
          const SizedBox(height: 8),

          _CodeCard(
            code: '''
// Top (130x50)
const DLTooltip(
  label: 'Lorem ipsum',
  direction: DLTooltipDirection.top,
);

// Bottom (130x50)
const DLTooltip(
  label: 'Lorem ipsum',
  direction: DLTooltipDirection.bottom,
);

// Left (140x40)
const DLTooltip(
  label: 'Lorem ipsum',
  direction: DLTooltipDirection.left,
);

// Right (140x40)
const DLTooltip(
  label: 'Lorem ipsum',
  direction: DLTooltipDirection.right,
);
''',
          ),
        ],
      ),
    );
  }
}

class _TooltipTile extends StatelessWidget {
  const _TooltipTile({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343, // keep your demo grid stable
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DLTypos.textSmRegular()),
          const SizedBox(height: 8),
          Center(child: child),
        ],
      ),
    );
  }
}

/// Simple demo card (matches the style you've been using).
class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.title, required this.child});

  final String title;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: DLTypos.textBaseBold()),
          const SizedBox(height: 12),
          child,
        ],
      ),
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
