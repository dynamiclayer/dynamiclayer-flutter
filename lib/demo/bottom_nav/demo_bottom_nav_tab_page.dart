import 'package:flutter/material.dart';
import '../../dynamiclayers.dart';
import '../../generated/assets.dart';

class DemoBottomNavTabPage extends StatelessWidget {
  const DemoBottomNavTabPage({super.key});

  Widget _cell({
    required bool showLabel,
    required bool selected,
    required DLBnavBadge badge,
    int badgeCount = 1,
  }) {
    return Center(
      child: DLBottomNavTab(
        label: 'Label',
        showLabel: showLabel,
        selected: selected,
        badge: badge,
        badgeCount: badgeCount,
        selectedColor: DLColors.black,
        unselectedColor: DLColors.grey400,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      // Label=true, Selected=true
      _cell(showLabel: true, selected: true, badge: DLBnavBadge.none),
      _cell(showLabel: true, selected: true, badge: DLBnavBadge.sm),
      _cell(
        showLabel: true,
        selected: true,
        badge: DLBnavBadge.md,
        badgeCount: 1,
      ),

      // Label=false, Selected=true
      _cell(showLabel: false, selected: true, badge: DLBnavBadge.none),
      _cell(showLabel: false, selected: true, badge: DLBnavBadge.sm),
      _cell(
        showLabel: false,
        selected: true,
        badge: DLBnavBadge.md,
        badgeCount: 1,
      ),

      // Label=true, Selected=false
      _cell(showLabel: true, selected: false, badge: DLBnavBadge.none),
      _cell(showLabel: true, selected: false, badge: DLBnavBadge.sm),
      _cell(
        showLabel: true,
        selected: false,
        badge: DLBnavBadge.md,
        badgeCount: 1,
      ),

      // Label=false, Selected=false
      _cell(showLabel: false, selected: false, badge: DLBnavBadge.none),
      _cell(showLabel: false, selected: false, badge: DLBnavBadge.sm),
      _cell(
        showLabel: false,
        selected: false,
        badge: DLBnavBadge.md,
        badgeCount: 1,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Nav Tab — Demo')),
      body: GridView.count(
        padding: const EdgeInsets.all(24),
        crossAxisCount: 3,
        mainAxisSpacing: 48,
        crossAxisSpacing: 48,
        children: items,
      ),
    );
  }
}
