import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/color_picker_row.dart';
import '../widgets/info_card.dart';

/// HomeScreen demonstrates:
///  - Consumer<T>
///  → fine-grained rebuilds
///  - context.watch<T>()
///  → shorthand for Provider.of(listen:true)
///  - context.read<T>()
///  → shorthand for Provider.of(listen:false)
///  - Selector<T,S>
///  → rebuilds only on selected sub-value
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const
        Text('Session 2 – Consumer Widget'),
        // context.watch rebuilds the AppBar area when theme changes
        backgroundColor: Theme.of(context)
            .colorScheme.inversePrimary,
        actions: [
          // Toggle dark mode from the AppBar
          IconButton(
            icon: Consumer<ThemeProvider>(
              builder: (_, theme, __) =>
                  Icon(theme.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode,
              ),
            ),
            onPressed: () => context
                .read<ThemeProvider>()
                .toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Section 1: Consumer Demo ──────────────────────────
            const Text(
              'Consumer Widget',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Consumer rebuilds ONLY this Text when theme changes.
            // The rest of the screen is unaffected.
            Consumer<ThemeProvider>(
              // 'child' is static — it is built once and reused.
              child: const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'This label never rebuilds (passed as child)',
                  style: TextStyle(color: Colors.grey,
                      fontSize: 12),
                ),
              ),
              builder: (context, theme, staticChild) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCard(
                      label: 'Current Mode',
                      value: theme.isDarkMode
                          ? '🌙 Dark Mode'
                          : '☀️ Light Mode',
                    ),
                    InfoCard(
                      label: 'Accent Color',
                      value: theme.accentColor,
                    ),
                    staticChild!,
                    // ← The never-rebuilding widget
                  ],
                );
              },
            ),

            const SizedBox(height: 28),

            // ── Section 2: Selector Demo ──────────────────────────
            const Text(
              'Selector Widget (rebuild only on accent change)',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Selector rebuilds ONLY when accentColor changes,
            // not when dark/light mode changes.
            Selector<ThemeProvider, String>(
              selector: (_, p) => p.accentColor,
              builder: (_, accent, __) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Selected accent: $accent\n'
                    '(This rebuilds only when accent color changes)',
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            // ── Section 3: Color Picker ───────────────────────────
            const Text(
              'Pick Accent Color',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
             ColorPickerRow(),

            const SizedBox(height: 28),

            // ── Section 4: Toggle Button ──────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                // context.read() — no rebuild, just fire an action
                onPressed: () => context.read<ThemeProvider>().toggleTheme(),
                icon: const Icon(Icons.brightness_6),
                label: const Text('Toggle Light / Dark Mode'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
