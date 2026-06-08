// lib/presentation/providers/counter_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/counter_repository_impl.dart';
import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';
import '../../domain/usecases/counter_usecases.dart';

final counterRepositoryProvider = Provider<CounterRepository>((ref) {
  return CounterRepositoryImpl();
});

final getCounterUseCaseProvider = Provider((ref) {
  final repository = ref.watch(counterRepositoryProvider);
  return GetCounterUseCase(repository);
});

final incrementCounterUseCaseProvider = Provider((ref) {
  final repository = ref.watch(counterRepositoryProvider);
  return IncrementCounterUseCase(repository);
});

final decrementCounterUseCaseProvider = Provider((ref) {
  final repository = ref.watch(counterRepositoryProvider);
  return DecrementCounterUseCase(repository);
});

final resetCounterUseCaseProvider = Provider((ref) {
  final repository = ref.watch(counterRepositoryProvider);
  return ResetCounterUseCase(repository);
});

final counterProvider = FutureProvider<Counter>((ref) async {
  final useCase = ref.watch(getCounterUseCaseProvider);
  return await useCase.call();
});

final incrementCounterProvider = FutureProvider<void>((ref) async {
  final useCase = ref.watch(incrementCounterUseCaseProvider);
  await useCase.call();
  ref.refresh(counterProvider);
});

final decrementCounterProvider = FutureProvider<void>((ref) async {
  final useCase = ref.watch(decrementCounterUseCaseProvider);
  await useCase.call();
  ref.refresh(counterProvider);
});

final resetCounterProvider = FutureProvider<void>((ref) async {
  final useCase = ref.watch(resetCounterUseCaseProvider);
  await useCase.call();
  ref.refresh(counterProvider);
});
