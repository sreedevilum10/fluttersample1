import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

/// Demonstrates StateProvider — the simplest Riverpod provider.
/// ConsumerWidget gives us a 'ref' object in build() instead of context.
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() subscribes to the provider → rebuilds on change
    final count = ref.watch(counterProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Concept Label ─────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepOrange.shade200),
            ),
            child: const Text(
              'StateProvider<int>',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // ── Count Display ────────────────────────────────────
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontSize: count == 0 ? 80 : 96,
              fontWeight: FontWeight.bold,
              color: count > 0
                  ? Colors.green.shade700
                  : count < 0
                  ? Colors.red.shade700
                  : Colors.grey.shade700,
            ),
            child: Text('$count'),
          ),
          const SizedBox(height: 8),
          Text(
            count == 0
                ? 'Start counting!'
                : count > 0
                ? 'Positive'
                : 'Negative',
            style: TextStyle(color: Colors.grey.shade500),
          ),

          const SizedBox(height: 40),

          // ── Buttons ──────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Decrement — ref.read in callbacks (no rebuild needed)
              FilledButton.tonal(
                onPressed: () => ref.read(counterProvider.notifier).state--,
                child: const Icon(Icons.remove, size: 28),
              ),
              const SizedBox(width: 16),
              // Reset
              OutlinedButton(
                onPressed: () => ref.read(counterProvider.notifier).state = 0,
                child: const Text('Reset'),
              ),
              const SizedBox(width: 16),
              // Increment
              FilledButton(
                onPressed: () => ref.read(counterProvider.notifier).state++,
                child: const Icon(Icons.add, size: 28),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // ── Key insight card ─────────────────────────────────
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: const Column(
              children: [
                Text(
                  '💡 Key Differences from Provider',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '• No BuildContext needed to define provider\n'
                  '• ref.watch() = context.watch()\n'
                  '• ref.read()  = context.read()\n'
                  '• Providers are global — defined outside any class',
                  style: TextStyle(fontSize: 13, height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
