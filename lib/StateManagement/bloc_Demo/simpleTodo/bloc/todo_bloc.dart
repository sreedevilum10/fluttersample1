// Import flutter_bloc package.
// This provides Bloc, Emitter, and event handling functionality.
import 'package:flutter_bloc/flutter_bloc.dart';

// Import the file that contains all Todo events
// (TodoAdded, TodoToggled, TodoRemoved, CompletedCleared).
import 'todo_event.dart';

// Import the Todo model class.
import '../model/todo_model.dart';

// TodoBloc manages the state of the Todo application.
// Bloc<EventType, StateType>
// EventType = TodoEvent
// StateType = List<Todo>
// Here, the state is simply a List of Todo objects.
class TodoBloc extends Bloc<TodoEvent, List<Todo>> {

  // Constructor of TodoBloc.
  // super(const []) sets the initial state as an empty list.
  TodoBloc() : super(const []) {
    // Register handler for TodoAdded event.
    on<TodoAdded>(_onAdded);
    // Register handler for TodoToggled event.
    on<TodoToggled>(_onToggled);
    // Register handler for TodoRemoved event.
    on<TodoRemoved>(_onRemoved);
    // Register handler for CompletedCleared event.
    on<CompletedCleared>(_onClearCompleted);
  }

  // Generates a unique id using the current timestamp.
  // millisecondsSinceEpoch returns current time in milliseconds.
  int _newId() => DateTime.now().millisecondsSinceEpoch;

  // Handles TodoAdded event.
  void _onAdded(
      TodoAdded event, // Contains title entered by user.
      Emitter<List<Todo>> emit, // Used to emit new state.
      ) {

    // Remove extra spaces and check if title is empty.
    if (event.title.trim().isEmpty) return;

    // Create a new Todo object.
    final newTodo = Todo(
      id: _newId(), // Generate unique id.
      title: event.title.trim(), // Store cleaned title.
    );

    // Emit a NEW list containing:
    // Existing todos + newly created todo.
    //
    // state = current list
    // ...state = spread operator
    emit([...state, newTodo]);
  }

  // Handles TodoToggled event.
  void _onToggled(
      TodoToggled event, // Contains todo id.
      Emitter<List<Todo>> emit,
      ) {
    // Loop through all todos.
    final updated = state.map((todo) {
      // Check whether current todo matches clicked todo.
      if (todo.id == event.id) {
        // Return a copied Todo with opposite isDone value.
        return todo.copyWith(
          isDone: !todo.isDone,
        );
      }
      // Return unchanged todo.
      return todo;
      // Convert map result back into a list.
    }).toList();

    // Emit updated list.
    emit(updated);
  }

  // Handles TodoRemoved event.
  void _onRemoved(
      TodoRemoved event, // Contains id of todo to delete.
      Emitter<List<Todo>> emit,
      ) {
    // Keep only todos whose id does NOT match.
    final updated = state.where((todo) {
      return todo.id != event.id;
      // Convert result into list.
    }).toList();
    // Emit updated list.
    emit(updated);
  }

  // Handles CompletedCleared event.
  void _onClearCompleted(
      CompletedCleared event,
      Emitter<List<Todo>> emit,
      ) {
    // Keep only todos that are NOT completed.
    final updated = state.where((todo) {
      return !todo.isDone;
      // Convert result into list.
    }).toList();
    // Emit updated list.
    emit(updated);
  }
}