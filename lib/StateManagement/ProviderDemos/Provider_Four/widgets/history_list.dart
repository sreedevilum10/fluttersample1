import 'package:flutter/material.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Four/providers/counter_provider.dart';
import 'package:provider/provider.dart';

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
