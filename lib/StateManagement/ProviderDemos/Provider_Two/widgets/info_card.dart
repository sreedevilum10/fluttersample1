import 'package:flutter/material.dart';

/// Simple key-value display card used in demos.
class InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const InfoCard(
      {super.key,
    required this.label,
    required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          vertical: 4),
      child: ListTile(
        title: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w600)),
        trailing: Text(value,
            style: const TextStyle(
                fontSize: 16)),
      ),
    );
  }
}
