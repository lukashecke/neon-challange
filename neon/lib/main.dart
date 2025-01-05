import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Estimate the Age of a Name'),
    );
  }
}

/// Initial page of the application.
class MyHomePage extends StatefulWidget {
  /// This is the main page constructor.
  const MyHomePage({required this.title, super.key});

  /// The title of the page.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Center(
            child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter a name',
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.search),
      ),
    );
  }
}
