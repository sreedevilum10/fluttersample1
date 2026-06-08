import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  int _count = 0;

  @override
  Future<Counter> getCounter() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Counter(count: _count);
  }

  @override
  Future<void> increment() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _count += 1;
  }

  @override
  Future<void> decrement() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _count -= 1;
  }

  @override
  Future<void> reset() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _count = 0;
  }
}
