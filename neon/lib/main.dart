import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon/feature/age_estimation/bloc/age_estimation_bloc.dart';
import 'package:neon/feature/age_estimation/view/age_estimation_page.dart';

void main() {
  runApp(const MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  /// This is the main application constructor.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => AgeEstimationBloc(),
        child: const AgeEstimationPage(title: 'Estimate the Age of a Name'),
      ),
    );
  }
}
