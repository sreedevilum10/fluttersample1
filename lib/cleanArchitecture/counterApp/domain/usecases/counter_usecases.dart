import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

class GetCounterUseCase {
  final CounterRepository repository;
  GetCounterUseCase(this.repository);
  Future<Counter> call() async {
    return await repository.getCounter();
  }
}

class IncrementCounterUseCase {
  final CounterRepository repository;
  IncrementCounterUseCase(this.repository);
  Future<void> call() async {
    await repository.increment();
  }
}

class DecrementCounterUseCase {
  final CounterRepository repository;
  DecrementCounterUseCase(this.repository);
  Future<void> call() async {
    await repository.decrement();
  }
}

class ResetCounterUseCase {
  final CounterRepository repository;
  ResetCounterUseCase(this.repository);
  Future<void> call() async {
    await repository.reset();
  }
}
