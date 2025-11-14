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
      appBar: AppBar(title: const Text('Badges — Catalog')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionHeader('Standalone — Size: md (shows count)'),
          SizedBox(height: 8),
          _PreviewBlock(child: _StandaloneMdRow(), code: _standaloneMdCode),
          SizedBox(height: 24),

          _SectionHeader('Standalone — Size: sm (dot only)'),
          SizedBox(height: 8),
          _PreviewBlock(child: _StandaloneSmRow(), code: _standaloneSmCode),
          SizedBox(height: 24),

          _SectionHeader('Anchored — Icon + Count'),
          SizedBox(height: 8),
          _PreviewBlock(child: _IconWithBadgeRow(), code: _iconWithBadgeCode),
          SizedBox(height: 24),

          _SectionHeader('Anchored — Avatar + Presence Dot'),
          SizedBox(height: 8),
          _PreviewBlock(child: _AvatarWithDotRow(), code: _avatarWithDotCode),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sections (previews)
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
// DOC UI chrome (same pattern as other catalog pages)
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
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
  const _PreviewBlock({required this.child, required this.code});
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
  const _SubHeader(this.title);
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
  const _CodeBox({required this.code});
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

// ─────────────────────────────────────────────────────────────────────────────
// Code Samples (for docs panel)
// ─────────────────────────────────────────────────────────────────────────────

const _standaloneMdCode = '''
// Standalone — Size: md (shows count)
const Wrap(
  spacing: 12,
  runSpacing: 12,
  children: [
    DLBadge(size: DLBadgeSize.md, count: 0),   // 0
    DLBadge(size: DLBadgeSize.md, count: 1),   // 1
    DLBadge(size: DLBadgeSize.md, count: 7),   // 7
    DLBadge(size: DLBadgeSize.md, count: 42),  // 42
    DLBadge(size: DLBadgeSize.md, count: 123), // 99+ (capped)
  ],
);
''';

const _standaloneSmCode = '''
// Standalone — Size: sm (dot only)
const Wrap(
  spacing: 16,
  children: [
    DLBadge(size: DLBadgeSize.sm),
    DLBadge(size: DLBadgeSize.sm),
    DLBadge(size: DLBadgeSize.sm),
  ],
);
''';

const _iconWithBadgeCode = '''
// Anchored — Icon + Count
Wrap(
  spacing: 28,
  runSpacing: 20,
  crossAxisAlignment: WrapCrossAlignment.center,
  children: const [
    DLBadgeAnchor(
      child: Icon(Icons.notifications, size: 28, color: DLColors.grey800),
      badge: DLBadge(size: DLBadgeSize.md, count: 1),
      alignment: Alignment.topRight,
      offset: Offset(2, -2),
      showIfZero: false,
    ),
    DLBadgeAnchor(
      child: Icon(Icons.email, size: 28, color: DLColors.grey800),
      badge: DLBadge(size: DLBadgeSize.md, count: 5),
      alignment: Alignment.topRight,
      offset: Offset(2, -2),
      showIfZero: false,
    ),
    DLBadgeAnchor(
      child: Icon(Icons.shopping_cart, size: 28, color: DLColors.grey800),
      badge: DLBadge(size: DLBadgeSize.md, count: 12),
      alignment: Alignment.topRight,
      offset: Offset(2, -2),
      showIfZero: false,
    ),
    DLBadgeAnchor(
      child: Icon(Icons.chat_bubble, size: 28, color: DLColors.grey800),
      badge: DLBadge(size: DLBadgeSize.md, count: 0),
      alignment: Alignment.topRight,
      offset: Offset(2, -2),
      showIfZero: false,
    ),
  ],
);
''';

const _avatarWithDotCode = '''
// Anchored — Avatar + Presence Dot
Wrap(
  spacing: 24,
  runSpacing: 16,
  children: const [
    DLBadgeAnchor(
      child: CircleAvatar(
        radius: 20,
        backgroundColor: DLColors.grey200,
        child: Text(
          'AA',
          style: DLTypos.textSmBold(color: DLColors.grey800),
        ),
      ),
      badge: DLBadge(size: DLBadgeSize.sm),
      alignment: Alignment.bottomRight,
      offset: Offset(2, 2),
    ),
    DLBadgeAnchor(
      child: CircleAvatar(
        radius: 20,
        backgroundColor: DLColors.grey200,
        child: Text(
          'BB',
          style: DLTypos.textSmBold(color: DLColors.grey800),
        ),
      ),
      badge: DLBadge(size: DLBadgeSize.sm),
      alignment: Alignment.bottomRight,
      offset: Offset(2, 2),
    ),
    DLBadgeAnchor(
      child: CircleAvatar(
        radius: 20,
        backgroundColor: DLColors.grey200,
        child: Text(
          'CC',
          style: DLTypos.textSmBold(color: DLColors.grey800),
        ),
      ),
      badge: DLBadge(size: DLBadgeSize.sm),
      alignment: Alignment.bottomRight,
      offset: Offset(2, 2),
    ),
  ],
);
''';
