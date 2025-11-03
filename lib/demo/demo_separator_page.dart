import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

class DemoSeparatorPage extends StatelessWidget {
  const DemoSeparatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Separator — Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Horizontal (length: 80, thickness: 2)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Center(
            child: DLSeparator(
              direction: DLSeparatorDirection.horizontal,
              length: 80, // width: 80, height: 0 (visually)
              thickness: 2,
              opacity: 1,
            ),
          ),
          const SizedBox(height: 32),

          Text(
            'Vertical (length: 80, thickness: 2)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: Center(
              child: DLSeparator(
                direction: DLSeparatorDirection.vertical,
                length: 80, // height: 80, width: 0 (visually)
                thickness: 2,
                opacity: 1,
              ),
            ),
          ),

          const SizedBox(height: 32),
          Text(
            'Full-width horizontal (expand)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          DLSeparator(
            direction: DLSeparatorDirection.horizontal,
            length: null, // expands to parent constraints
            thickness: 1,
            opacity: 1,
            margin: const EdgeInsets.symmetric(vertical: 8),
          ),
        ],
      ),
    );
  }
}
