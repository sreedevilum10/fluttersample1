import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';

/// HomeScreen reads state from CounterProvider using Provider.of<T>().
/// listen: true  → widget rebuilds when notifyListeners() is called.
/// listen: false → reads value once, no rebuild (used inside callbacks).

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Subscribes to CounterProvider — this widget rebuilds on every change.
    final counter = Provider.of<CounterProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session 1 – Provider Setup'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Counter Value',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              '${counter.count}',
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            // ── Action Buttons ────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrement
                ElevatedButton.icon(
                  onPressed: () {
                    // listen: false in callbacks — no rebuild needed here
                    Provider.of<CounterProvider>(context, listen: false)
                        .decrement();
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('Decrement'),
                ),
                const SizedBox(width: 12),
                // Reset
                OutlinedButton(
                  onPressed: () =>
                      Provider.of<CounterProvider>(context, listen: false)
                          .reset(),
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 12),
                // Increment
                ElevatedButton.icon(
                  onPressed: () =>
                      Provider.of<CounterProvider>(context, listen: false)
                          .increment(),
                  icon: const Icon(Icons.add),
                  label: const Text('Increment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
