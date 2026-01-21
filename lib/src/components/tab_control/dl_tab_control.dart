import 'package:flutter/material.dart';
import '../../../dynamiclayers.dart';
import 'dl_tab_control_tab.dart';

class DLTabControl extends StatelessWidget {
  const DLTabControl({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    assert(labels.isNotEmpty, 'DLTabControl.labels cannot be empty');

    // Figma: bottom border width 2px
    const baselineH = 2.0;
    const animDur = Duration(milliseconds: 180);
    const curve = Curves.easeOut;

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final count = labels.length;
        final segW = w / count;
        final clampedIndex = selectedIndex.clamp(0, count - 1);

        return SizedBox(
          height: 56, // matches tab height
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              // 1) One connected baseline (grey) across full width
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(height: baselineH, color: DLColors.grey200),
              ),

              // 2) Selected indicator (black) – animated position, SAME height as baseline
              AnimatedPositioned(
                duration: animDur,
                curve: curve,
                left: segW * clampedIndex,
                bottom: 0,
                child: Container(
                  width: segW,
                  height: baselineH,
                  color: DLColors.black,
                ),
              ),

              // 3) Tabs row
              Row(
                children: List.generate(count, (i) {
                  final isSelected = i == clampedIndex;
                  return Expanded(
                    child: DLTabControlTab(
                      label: labels[i],
                      state: isSelected
                          ? DLTabControlTabState.selected
                          : DLTabControlTabState.defaultState,
                      badge: false,
                      onTap: () => onChanged(i),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
