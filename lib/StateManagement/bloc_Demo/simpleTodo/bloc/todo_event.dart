// Events are the INPUTS sent to the BLoC.
// Whenever the user performs an action
// (add, update, delete, toggle, etc.),
// an Event is dispatched to the BLoC.

import 'package:equatable/equatable.dart';

// Abstract base class for all Todo events.
// All event classes will extend this class.
abstract class TodoEvent extends Equatable {
  // Constant constructor.
  const TodoEvent();
  // Equatable uses props to compare objects.
  // Empty list means no properties in base class.
  @override
  List<Object?> get props => [];
}

// =======================================================
// EVENT 1 : ADD TODO
// =======================================================
// Triggered when user enters a task and presses the Add button.
class TodoAdded extends TodoEvent {
  // Stores the task title entered by the user.
  final String title;
  // Constructor receives title.
  const TodoAdded(this.title);
  // Used by Equatable for object comparison.
  @override
  List<Object?> get props => [title];
}

// =======================================================
// EVENT 2 : TOGGLE TODO
// =======================================================

// Triggered when user taps the checkbox.
//
// Example:
// Study Flutter [ ]
//
// becomes
//
// Study Flutter [✓]
class TodoToggled extends TodoEvent {
  // Id of the todo to toggle.
  final int id;
  // Constructor receives todo id.
  const TodoToggled(this.id);
  // Used by Equatable for comparison.
  @override
  List<Object?> get props => [id];
}

// =======================================================
// EVENT 3 : REMOVE TODO
// =======================================================

// Triggered when user taps Delete icon.
class TodoRemoved extends TodoEvent {
  // Id of the todo to remove.
  final int id;
  // Constructor receives todo id.
  const TodoRemoved(this.id);
  // Used by Equatable for comparison.
  @override
  List<Object?> get props => [id];
}

// =======================================================
// EVENT 4 : CLEAR COMPLETED TODOS
// =======================================================

// Triggered when user presses
// "Clear Completed" button.
class CompletedCleared extends TodoEvent {
  // No data required because
  // all completed items will be removed.
}

// =======================================================
// EVENT FLOW
// =======================================================
//
// User Action
//      |
//      V
// Event Created
//      |
//      V
// bloc.add(Event)
//      |
//      V
// Event Handler Executes
//      |
//      V
// New State Emitted
//
// Example:
//
// bloc.add(TodoAdded("Learn BLoC"));
//
// bloc.add(TodoToggled(1));
//
// bloc.add(TodoRemoved(1));
//
// bloc.add(CompletedCleared());
//