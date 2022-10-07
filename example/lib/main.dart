import 'package:flutter/material.dart';
import 'package:animated_checkmark/animated_checkmark.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Checkmark Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Animated Checkmark Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool active = false;

  void toggleActive() {
    setState(() => active = !active);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedCheckmark(
              active: active,
              weight: 20,
              color: Theme.of(context).colorScheme.primary,
              style: CheckmarkStyle.round,
              size: const Size.square(100),
            ),
            TextButton(
              onPressed: toggleActive,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: active ? const Text('Hide') : const Text('Show'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
