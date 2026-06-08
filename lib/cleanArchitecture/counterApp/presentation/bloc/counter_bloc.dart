import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/counter_usecases.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends
Bloc<CounterEvent, CounterState> {
  final GetCounterUseCase getCounterUseCase;
  final IncrementCounterUseCase incrementCounterUseCase;
  final DecrementCounterUseCase decrementCounterUseCase;
  final ResetCounterUseCase resetCounterUseCase;

  CounterBloc({
    required this.getCounterUseCase,
    required this.incrementCounterUseCase,
    required this.decrementCounterUseCase,
    required this.resetCounterUseCase,
  }) : super(const CounterInitial()) {

    on<FetchCounterEvent>(_onFetchCounter);
    on<IncrementCounterEvent>(_onIncrementCounter);
    on<DecrementCounterEvent>(_onDecrementCounter);
    on<ResetCounterEvent>(_onResetCounter);
  }

  Future<void> _onFetchCounter(
    FetchCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(const CounterLoading());
    try {
      final counter = await getCounterUseCase.call();
      emit(CounterLoaded(counter));
    } catch (e) {
      emit(CounterError(e.toString()));
    }
  }

  Future<void> _onIncrementCounter(
    IncrementCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(const CounterLoading());
    try {
      await incrementCounterUseCase.call();
      final counter = await getCounterUseCase.call();
      emit(CounterLoaded(counter));
    } catch (e) {
      emit(CounterError(e.toString()));
    }
  }

  Future<void> _onDecrementCounter(
    DecrementCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(const CounterLoading());
    try {
      await decrementCounterUseCase.call();
      final counter = await getCounterUseCase.call();
      emit(CounterLoaded(counter));
    } catch (e) {
      emit(CounterError(e.toString()));
    }
  }

  Future<void> _onResetCounter(
    ResetCounterEvent event,
    Emitter<CounterState> emit,
  ) async {
    emit(const CounterLoading());
    try {
      await resetCounterUseCase.call();
      final counter = await getCounterUseCase.call();
      emit(CounterLoaded(counter));
    } catch (e) {
      emit(CounterError(e.toString()));
    }
  }
}
