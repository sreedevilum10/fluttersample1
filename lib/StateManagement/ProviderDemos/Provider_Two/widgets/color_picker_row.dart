import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

/// A row of color chips. Tapping one calls setAccentColor on the provider.
class ColorPickerRow extends StatelessWidget {
  static const _colors = [
    'Blue',
    'Red',
    'Green',
    'Purple'];
  static const _swatches = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple];

  @override
  Widget build(BuildContext context) {
    // context.watch subscribes this widget to ThemeProvider changes.
    final current = context.watch<ThemeProvider>()
        .accentColor;

    return Row(
      children: List.generate(_colors.length, (i) {
        final name = _colors[i];
        final color = _swatches[i];
        final isSelected = current == name;

        return GestureDetector(
          onTap: () => context.read<ThemeProvider>()
              .setAccentColor(name),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(right: 12),
            width: isSelected ? 56 : 48,
            height: isSelected ? 56 : 48,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                  color: Colors.white,
                  width: 3)
                  : null,
              boxShadow: isSelected
                  ? [BoxShadow(
                  color: color.withOpacity(0.6),
                  blurRadius: 8)]
                  : [],
            ),
            child: isSelected
                ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 20)
                : null,
          ),
        );
      }),
    );
  }
}
