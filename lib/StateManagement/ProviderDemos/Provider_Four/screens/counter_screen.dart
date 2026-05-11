import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';
import '../widgets/count_display.dart';
import '../widgets/step_selector.dart';
import '../widgets/action_buttons.dart';
import '../widgets/history_list.dart';

/// CounterScreen is intentionally lean — it only composes sub-widgets.
/// All business logic lives in CounterProvider.
/// Each sub-widget has its own Consumer so only it rebuilds when needed.
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session 4 – Counter App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Undo button — uses context.read (no rebuild needed here)
          Consumer<CounterProvider>(
            builder: (_, counter, __) => IconButton(
              icon: const Icon(Icons.undo),
              tooltip: 'Undo last action',
              onPressed:
                  counter.hasHistory ? () => context.read<CounterProvider>().undo() : null,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Clear history',
            onPressed: () => context.read<CounterProvider>().clearHistory(),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Count Display (rebuilds on count change) ──────────
          const CountDisplay(),

          const Divider(height: 1),

          // ── Step Selector (rebuilds on step change) ───────────
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: StepSelector(),
          ),

          // ── Action Buttons (static, uses context.read) ────────
          const ActionButtons(),

          const SizedBox(height: 12),
          const Divider(height: 1),

          // ── History List (rebuilds on history change) ─────────
          const Expanded(child: HistoryList()),
        ],
      ),
    );
  }
}
