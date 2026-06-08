import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();
  @override
  List<Object?> get props => [];
}

class FetchCounterEvent extends CounterEvent {
  const FetchCounterEvent();
}

class IncrementCounterEvent extends CounterEvent {
  const IncrementCounterEvent();
}

class DecrementCounterEvent extends CounterEvent {
  const DecrementCounterEvent();
}

class ResetCounterEvent extends CounterEvent {
  const ResetCounterEvent();
}
