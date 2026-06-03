// Import Flutter Material widgets.
import 'package:flutter/material.dart';

// Import flutter_bloc package to access BlocBuilder and context.read().
import 'package:flutter_bloc/flutter_bloc.dart';

// Import TodoBloc.
import '../bloc/todo_bloc.dart';

// Import Todo events.
import '../bloc/todo_event.dart';

// Import Todo model.
import '../model/todo_model.dart';


class TodoScreen extends StatelessWidget {
  // Constructor.
  TodoScreen({super.key});
  // Controller used to read and clear text entered
  // inside TextField.
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Scaffold provides basic page structure.
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Todo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // Clear completed button.
          IconButton(
            // Icon displayed.
            icon: const Icon(Icons.cleaning_services),
            // Tooltip shown on long press.
            tooltip: 'Clear completed',
            // Dispatch CompletedCleared event.
            onPressed: () => context
                    .read<TodoBloc>()
                    .add(CompletedCleared()),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // TextField occupies remaining space.
                Expanded(
                  child: TextField(
                    // Connect controller.
                    controller: _controller,
                    // Input decoration.
                    decoration: const InputDecoration(
                      // Placeholder text.
                      hintText: 'What needs to be done?',
                      // Border style.
                      border: OutlineInputBorder(),
                    ),
                    // Trigger when user presses Enter.
                    onSubmitted: (text) => _submit(context, text),
                  ),
                ),
                // Space between TextField and Button.
                const SizedBox(width: 8),
                // Add Button.
                ElevatedButton(
                  // Called when button is clicked.
                  onPressed: () => _submit(context, _controller.text),
                  // Button text.
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          // ==========================
          // COUNTER SECTION
          // ==========================
          BlocBuilder<TodoBloc, List<Todo>>(
            // Rebuild whenever state changes.
            builder: (context, todos) {
              // Count pending todos.
              final pending = todos.where((t) => !t.isDone).length;
              // Count completed todos.
              final done = todos.length - pending;
              return Container(
                // Inner spacing.
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                // Background color.
                color: Colors.blue.shade50,
                child: Row(
                  // Spread items evenly.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Pending count.
                    Text('Pending: $pending'),
                    // Completed count.
                    Text('Done: $done'),
                    // Total count.
                    Text('Total: ${todos.length}'),
                  ],
                ),
              );
            },
          ),

          // ==========================
          // TODO LIST SECTION
          // ==========================
          Expanded(
            child: BlocBuilder<TodoBloc, List<Todo>>(
              // Rebuild whenever state changes.
              builder: (context, todos) {
                // If list is empty.
                if (todos.isEmpty) {
                  return const Center(
                    child: Text(
                      'No todos yet — add one above!',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                // Display Todo list.
                return ListView.builder(
                  // Number of items.
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    // Current todo.
                    final todo = todos[index];
                    return ListTile(
                      // ==================
                      // CHECKBOX
                      // ==================
                      leading: Checkbox(
                        // Current checked state.
                        value: todo.isDone,
                        // Toggle event.
                        onChanged: (_) => context
                            .read<TodoBloc>()
                            .add(TodoToggled(todo.id),),
                      ),
                      // ==================
                      // TITLE
                      // ==================
                      title: Text(
                        // Todo title.
                        todo.title,
                        style: TextStyle(
                          // Strike-through when completed.
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : null,
                          // Grey color when completed.
                          color: todo.isDone
                              ? Colors.grey
                              : Colors.black87,
                        ),
                      ),
                      // ==================
                      // DELETE BUTTON
                      // ==================
                      trailing: IconButton(
                        // Delete icon.
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        // Dispatch remove event.
                        onPressed: () => context
                                .read<TodoBloc>()
                                .add(TodoRemoved(todo.id),),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ==========================
  // ADD TODO METHOD
  // ==========================
  //
  // Called when:
  // 1. User presses Enter
  // 2. User clicks Add button
  //
  void _submit(BuildContext context, String text,) {
    // Send TodoAdded event to BLoC.
    context.read<TodoBloc>().add(TodoAdded(text));
    // Clear TextField.
    _controller.clear();
  }
}