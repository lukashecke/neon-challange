import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon/feature/age_estimation/bloc/age_estimation_bloc.dart';

/// Initial page of the application.
class AgeEstimationPage extends StatefulWidget {
  /// This is the main page constructor.
  const AgeEstimationPage({required this.title, super.key});

  /// The title of the page.
  final String title;

  @override
  State<AgeEstimationPage> createState() => _AgeEstimationPageState();
}

class _AgeEstimationPageState extends State<AgeEstimationPage> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _isButtonEnabled.value = _controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isButtonEnabled,
        builder: (context, isEnabled, child) {
          return FloatingActionButton(
            backgroundColor: isEnabled ? null : Colors.grey,
            onPressed: isEnabled
                ? () {
                    context
                        .read<AgeEstimationBloc>()
                        .add(NameEntered(_controller.text));
                  }
                : null,
            child: const Icon(Icons.search),
          );
        },
      ),
    );
  }
}
