import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffe_app_ui/application/providers/user_prefs_providers.dart';

class FadeIn extends ConsumerWidget {
  const FadeIn({super.key, required this.child, this.delayMs = 0, this.durationMs = 300});
  final Widget child;
  final int delayMs;
  final int durationMs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(userPrefsProvider);
    final reduceMotion = prefs.value?.reduceMotion ?? false;
    if (reduceMotion) return child;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: durationMs),
      curve: Curves.easeOut,
      delay: Duration(milliseconds: delayMs),
      builder: (context, value, _) => Opacity(
        opacity: value,
        child: Transform.translate(offset: Offset(0, (1 - value) * 8), child: child),
      ),
    );
  }
}
