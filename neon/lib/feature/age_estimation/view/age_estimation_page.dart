import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon/constants.dart';
import 'package:neon/feature/age_estimation/bloc/age_estimation_bloc.dart';

/// Initial page of the application.
class AgeEstimationPage extends StatefulWidget {
  /// This is the main page constructor.
  const AgeEstimationPage({super.key});

  @override
  State<AgeEstimationPage> createState() => _AgeEstimationPageState();
}

class _AgeEstimationPageState extends State<AgeEstimationPage> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);
  String _lastEnteredName = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _isButtonEnabled.value =
          _controller.text.isNotEmpty && _controller.text != _lastEnteredName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AgeEstimationBloc, AgeEstimationState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: Center(
                      child: switch (state) {
                        AgeEstimationInitial() => const Text(
                            'Wie alt bin ich laut Name?',
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        AgeEstimationLoading() => const Center(
                            child: SizedBox(
                              height: Constants.indicatorSize,
                              width: Constants.indicatorSize,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        AgeEstimationLoaded() => Text(
                            'Das Alter des Namens ${state.name} '
                            'beträgt ${state.age} Jahre.',
                            style: const TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        AgeEstimationError() => const Text(
                            'Oopsie! Es scheint, es ist etwas '
                            'schiefgelaufen.',
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('lib/assets/age-icons.png'),
                        _VisualAgeScaleIndicator(
                          age: state is AgeEstimationLoaded ? state.age : null,
                        ),
                      ],
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
                    _lastEnteredName = _controller.text;
                    // disables the button immediately after it was pressed
                    // otherwise a reffocus on the text field would be needed
                    _isButtonEnabled.value = false;
                  }
                : null,
            child: const Icon(Icons.search),
          );
        },
      ),
    );
  }
}

/// Represents a Indicator for the visual scale of the age.
class _VisualAgeScaleIndicator extends StatelessWidget {
  /// This is the visual age scale constructor.
  const _VisualAgeScaleIndicator({
    required this.age,
  });

  /// The age to be visualized.
  final int? age;
  @override
  Widget build(BuildContext context) {
    if (age == null) {
      return const SizedBox(
        height: Constants.indicatorSize,
      );
    }
    final indicatorArrowIcon = Icon(
      Icons.arrow_upward_outlined,
      size: Constants.indicatorSize,
      color: Theme.of(context).textTheme.bodyLarge?.color,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: age! < 10 ? 1 : 0,
          child: indicatorArrowIcon,
        ),
        Opacity(
          opacity: age! >= 10 && age! < 25 ? 1 : 0,
          child: indicatorArrowIcon,
        ),
        Opacity(
          opacity: age! >= 25 && age! < 50 ? 1 : 0,
          child: indicatorArrowIcon,
        ),
        Opacity(
          opacity: age! >= 50 ? 1 : 0,
          child: indicatorArrowIcon,
        ),
      ],
    );
  }
}
