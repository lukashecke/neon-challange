import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon/feature/age_estimation/bloc/age_estimation_bloc.dart';

/// Initial page of the application.
class AgeEstimationPage extends StatelessWidget {
  /// This is the main page constructor.
  AgeEstimationPage({required this.title, super.key});

  /// The title of the page.
  final String title;

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<AgeEstimationBloc, AgeEstimationState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: switch (state) {
                      AgeEstimationInitial() => const Text(
                          'Wie alt mag dein Name wohl sein? 🤔',
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      AgeEstimationLoading() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      AgeEstimationLoaded() => Text(
                          'Das Alter des Namens beträgt ${state.age} Jahre. 🥳',
                          style: const TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      AgeEstimationError() => const Text(
                          'Oopsie! Es scheint, es ist etwas schiefgelaufen. 😢',
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                    },
                  ),
                ),
                Expanded(
                  child: Center(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Gib hier einen Namen ein',
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.text.isEmpty) {
            return;
          }
          context.read<AgeEstimationBloc>().add(NameEntered(_controller.text));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
