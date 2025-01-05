import 'package:flutter/material.dart';

/// Initial page of the application.
class AgeEstimationPage extends StatelessWidget {
  /// This is the main page constructor.
  const AgeEstimationPage({required this.title, super.key});

  /// The title of the page.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter a name',
            ),
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.search),
      ),
    );
  }
}
