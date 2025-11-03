import 'package:flutter/material.dart';
import '../dynamiclayers.dart';

/// ---------------------------------------------------------------------------
/// 🧩 DynamicLayers — Badge Component Demo
/// ---------------------------------------------------------------------------
///
/// ## Overview
/// The `DLBadge` system lets you show small notification indicators
/// or status dots either:
///
/// 1️⃣ **Standalone** — as a simple count badge or red dot
/// 2️⃣ **Anchored** — positioned over another widget (e.g., icon, avatar)
///
/// ## Usage Examples
///
/// ### 🔹 Standalone (shows count)
/// ```dart
/// const DLBadge(size: DLBadgeSize.md, count: 7)
/// ```
/// Displays a pill-shaped badge (height: 16px, rounded_full)
/// with white text and red background.
///
///
/// ### 🔹 Standalone (dot only)
/// ```dart
/// const DLBadge(size: DLBadgeSize.sm)
/// ```
/// Displays a circular 8×8 dot, ideal for online presence or small status.
///
///
/// ### 🔹 Overlay on an Icon
/// ```dart
/// DLBadgeAnchor(
///   child: Icon(Icons.notifications),
///   badge: const DLBadge(size: DLBadgeSize.md, count: 3),
///   alignment: Alignment.topRight,
///   offset: const Offset(2, -2),
/// )
/// ```
/// Positions the badge relative to the `Icon`.
///
///
/// ### 🔹 Overlay on an Avatar
/// ```dart
/// DLBadgeAnchor(
///   child: CircleAvatar(radius: 20, child: Text('AA')),
///   badge: const DLBadge(size: DLBadgeSize.sm),
///   alignment: Alignment.bottomRight,
///   offset: const Offset(2, 2),
/// )
/// ```
/// Adds a small red presence dot at the bottom-right of the avatar.
///
///
/// ## Properties
///
/// | Property | Type | Default | Description |
/// |-----------|------|----------|--------------|
/// | `size` | `DLBadgeSize` | `DLBadgeSize.md` | `md` shows a number; `sm` is a red dot. |
/// | `count` | `int` | `1` | Number to display (ignored for `sm`). |
/// | `backgroundColor` | `Color` | `DLColors.red500` | Background color. |
/// | `foregroundColor` | `Color` | `DLColors.white` | Text color. |
/// | `DLBadgeAnchor.alignment` | `Alignment` | `Alignment.topRight` | Where to attach relative to child. |
/// | `DLBadgeAnchor.offset` | `Offset` | `(0,0)` | Fine-tune badge position. |
/// | `DLBadgeAnchor.showIfZero` | `bool` | `false` | Hide when count == 0 for md badges. |
///
///
/// ## Integration with Factories (Optional)
/// ```dart
/// DynamicLayers.badge(size: DLBadgeSize.md, count: 5)
/// DynamicLayers.badge.anchor(child: Icon(...), badge: DLBadge(...))
/// ```
///
/// ---------------------------------------------------------------------------
class DemoBadgePage extends StatelessWidget {
  const DemoBadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Badges — Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _Section('Standalone — Size: md (shows count)'),
          SizedBox(height: 8),
          _PreviewBox(child: _StandaloneMdRow()),
          SizedBox(height: 24),

          _Section('Standalone — Size: sm (dot only)'),
          SizedBox(height: 8),
          _PreviewBox(child: _StandaloneSmRow()),
          SizedBox(height: 24),

          _Section('Anchored — Icon + Count'),
          SizedBox(height: 8),
          _PreviewBox(child: _IconWithBadgeRow()),
          SizedBox(height: 24),

          _Section('Anchored — Avatar + Presence Dot'),
          SizedBox(height: 8),
          _PreviewBox(child: _AvatarWithDotRow()),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sections
// ─────────────────────────────────────────────────────────────────────────────

class _StandaloneMdRow extends StatelessWidget {
  const _StandaloneMdRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [
        DLBadge(size: DLBadgeSize.md, count: 0), // 0
        DLBadge(size: DLBadgeSize.md, count: 1), // 1
        DLBadge(size: DLBadgeSize.md, count: 7), // 7
        DLBadge(size: DLBadgeSize.md, count: 42), // 42
        DLBadge(size: DLBadgeSize.md, count: 123), // 99+ (capped)
      ],
    );
  }
}

class _StandaloneSmRow extends StatelessWidget {
  const _StandaloneSmRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: const [
        DLBadge(size: DLBadgeSize.sm),
        DLBadge(size: DLBadgeSize.sm),
        DLBadge(size: DLBadgeSize.sm),
      ],
    );
  }
}

class _IconWithBadgeRow extends StatelessWidget {
  const _IconWithBadgeRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 28,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: const [
        _IconBadge(icon: Icons.notifications, count: 1),
        _IconBadge(icon: Icons.email, count: 5),
        _IconBadge(icon: Icons.shopping_cart, count: 12),
        _IconBadge(icon: Icons.chat_bubble, count: 0),
      ],
    );
  }
}

class _AvatarWithDotRow extends StatelessWidget {
  const _AvatarWithDotRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      children: const [
        _AvatarDot(label: 'AA', color: DLColors.grey200),
        _AvatarDot(label: 'BB', color: DLColors.grey200),
        _AvatarDot(label: 'CC', color: DLColors.grey200),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small helper widgets
// ─────────────────────────────────────────────────────────────────────────────

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.count});
  final IconData icon;
  final int count;

  @override
  Widget build(BuildContext context) {
    return DLBadgeAnchor(
      child: Icon(icon, size: 28, color: DLColors.grey800),
      badge: DLBadge(size: DLBadgeSize.md, count: count),
      alignment: Alignment.topRight,
      offset: const Offset(2, -2),
      showIfZero: false,
    );
  }
}

class _AvatarDot extends StatelessWidget {
  const _AvatarDot({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DLBadgeAnchor(
      child: CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: Text(label, style: DLTypos.textSmBold(color: DLColors.grey800)),
      ),
      badge: const DLBadge(size: DLBadgeSize.sm),
      alignment: Alignment.bottomRight,
      offset: const Offset(2, 2),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// UI chrome
// ─────────────────────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _PreviewBox extends StatelessWidget {
  const _PreviewBox({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}
