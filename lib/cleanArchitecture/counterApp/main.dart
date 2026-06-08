import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersample1/cleanArchitecture/counterApp/presentation/bloc/counter_event.dart';
import 'data/repositories/counter_repository_impl.dart';
import 'domain/usecases/counter_usecases.dart';
import 'presentation/bloc/counter_bloc.dart';
import 'presentation/pages/counter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = CounterRepositoryImpl();
    final getCounterUseCase = GetCounterUseCase(repository);
    final incrementCounterUseCase = IncrementCounterUseCase(repository);
    final decrementCounterUseCase = DecrementCounterUseCase(repository);
    final resetCounterUseCase = ResetCounterUseCase(repository);

    return MaterialApp(
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => CounterBloc(
          getCounterUseCase: getCounterUseCase,
          incrementCounterUseCase: incrementCounterUseCase,
          decrementCounterUseCase: decrementCounterUseCase,
          resetCounterUseCase: resetCounterUseCase,
        )..add(const FetchCounterEvent()),
        child: const CounterPage(),
      ),
    );
  }
}
