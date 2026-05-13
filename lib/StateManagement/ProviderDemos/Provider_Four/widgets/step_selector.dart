import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';

// ═══════════════════════════════════════════════════════════════
// StepSelector — lets the user choose increment/decrement step
// ═══════════════════════════════════════════════════════════════
class StepSelector extends StatelessWidget {
  const StepSelector({super.key});

  static const _steps = [1, 5, 10, 25];

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (_, counter, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Step: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ..._steps.map((step) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text('$step'),
                    selected: counter.step == step,
                    onSelected: (_) =>
                        context.read<CounterProvider>().setStep(step),
                  ),
                )),
          ],
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// ActionButtons — increment, decrement, reset
// context.read is used — buttons don't need to rebuild themselves
// ═══════════════════════════════════════════════════════════════
class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (_, counter, __) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Decrement
              _ActionButton(
                icon: Icons.remove,
                label: 'Decrement',
                color: Colors.red,
                enabled: !counter.isAtMin,
                onPressed: () => context.read<CounterProvider>().decrement(),
              ),
              // Reset
              _ActionButton(
                icon: Icons.refresh,
                label: 'Reset',
                color: Colors.grey.shade700,
                enabled: counter.count != 0,
                onPressed: () => context.read<CounterProvider>().reset(),
              ),
              // Increment
              _ActionButton(
                icon: Icons.add,
                label: 'Increment',
                color: Colors.green.shade700,
                enabled: !counter.isAtMax,
                onPressed: () => context.read<CounterProvider>().increment(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool enabled;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: enabled ? color : Colors.grey.shade300,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
          ),
          child: Icon(icon, size: 28),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 11,
                color: enabled ? color : Colors.grey.shade400)),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// HistoryList — displays operation history, newest first
// ═══════════════════════════════════════════════════════════════
class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (_, counter, __) {
        if (!counter.hasHistory) {
          return const Center(
            child: Text('No history yet.\nStart incrementing!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey)),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                'History (last ${counter.history.length} operations)',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: counter.history.length,
                itemBuilder: (_, i) {
                  final entry = counter.history[i];
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 14,
                      backgroundColor: i == 0
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Colors.grey.shade200,
                      child: Text('${i + 1}',
                          style: const TextStyle(fontSize: 11)),
                    ),
                    title: Text(entry.description),
                    trailing: Text(
                      '${entry.timestamp.hour}:${entry.timestamp.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                          fontSize: 11, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
