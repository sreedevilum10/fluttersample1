import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';

/// Displays the current count. Rebuilds ONLY when the count changes.
class CountDisplay extends StatelessWidget {
  const CountDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (_, counter, __) {
        // Determine color based on count limits
        Color countColor;
        if (counter.isAtMax) {
          countColor = Colors.red;
        } else if (counter.isAtMin) {
          countColor = Colors.orange;
        } else if (counter.count > 0) {
          countColor = Colors.green.shade700;
        } else if (counter.count < 0) {
          countColor = Colors.red.shade400;
        } else {
          countColor = Colors.grey.shade700;
        }

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 32),
          width: double.infinity,
          child: Column(
            children: [
              // Limit warning banner
              if (counter.isAtMax)
                const _LimitBanner(message: '⚠️ Maximum reached (100)', isMax: true),
              if (counter.isAtMin)
                const _LimitBanner(message: '⚠️ Minimum reached (-100)', isMax: false),

              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: counter.count.abs() >= 100 ? 64 : 80,
                  fontWeight: FontWeight.bold,
                  color: countColor,
                ),
                child: Text('${counter.count}'),
              ),
              Text(
                'Step size: ${counter.step}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LimitBanner extends StatelessWidget {
  final String message;
  final bool isMax;
  const _LimitBanner({required this.message, required this.isMax});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      color: isMax ? Colors.red.shade50 : Colors.orange.shade50,
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isMax ? Colors.red : Colors.orange.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
