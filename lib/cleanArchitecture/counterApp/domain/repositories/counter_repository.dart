import '../entities/counter.dart';

abstract class CounterRepository {
  Future<Counter> getCounter();
  Future<void> increment();
  Future<void> decrement();
  Future<void> reset();
}
