import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

enum AppNoticeType { success, info }

abstract final class AppNotice {
  static OverlayEntry? _current;

  static void show(
    BuildContext context,
    String message, {
    AppNoticeType type = AppNoticeType.success,
  }) {
    _current?.remove();

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (overlayContext) {
        final isSuccess = type == AppNoticeType.success;
        final color = isSuccess ? AppColors.success : AppColors.blue;
        return Positioned(
          top: MediaQuery.paddingOf(overlayContext).top + 14,
          left: 14,
          right: 14,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 220),
                tween: Tween(begin: 0, end: 1),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Transform.translate(
                  offset: Offset(0, -12 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                ),
                child: Material(
                  color: AppColors.surface,
                  elevation: 12,
                  shadowColor: AppColors.navy.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: color.withValues(alpha: .25)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(
                            isSuccess
                                ? Icons.check_rounded
                                : Icons.info_outline_rounded,
                            color: color,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Text(
                            message,
                            style: const TextStyle(
                              color: AppColors.ink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _remove(entry),
                          tooltip: 'Fechar',
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(
                            Icons.close_rounded,
                            color: AppColors.muted,
                            size: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    _current = entry;
    Overlay.of(context, rootOverlay: true).insert(entry);
    unawaited(
      Future<void>.delayed(const Duration(seconds: 3), () => _remove(entry)),
    );
  }

  static void _remove(OverlayEntry entry) {
    if (_current != entry) return;
    entry.remove();
    _current = null;
  }
}
