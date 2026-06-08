import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart';
import '../bloc/counter_state.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: BlocListener<CounterBloc, CounterState>(
          listener: (context, state) {
            if (state is CounterError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(content: Text(
                    'Error: ${state.message}')),
              );
            }
          },
          child: BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              if (state is CounterLoading) {
                return const CircularProgressIndicator();
              } else if (state is CounterLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Count',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${state.counter.count}',
                      style: const TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<CounterBloc>().add(
                              const DecrementCounterEvent(),
                            );
                          },
                          icon: const Icon(Icons.remove),
                          label: const Text('Decrement'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<CounterBloc>().add(
                              const ResetCounterEvent(),
                            );
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<CounterBloc>().add(
                              const IncrementCounterEvent(),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Increment'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (state is CounterError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text('Error: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CounterBloc>().add(
                          const FetchCounterEvent(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
