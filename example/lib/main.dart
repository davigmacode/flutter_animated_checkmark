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
  bool _active = true;
  bool _shrink = true;
  bool _sharp = true;
  Color? _color;

  void toggleActive() {
    setState(() => _active = !_active);
  }

  void toggleShrink() {
    setState(() => _shrink = !_shrink);
  }

  void toggleSharp() {
    setState(() => _sharp = !_sharp);
  }

  void setColor(Color color) {
    setState(() => _color = color);
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
              active: _active,
              weight: _shrink ? 20 : 30,
              size: _shrink ? const Size.square(100) : const Size.square(200),
              color: _color,
              style: _sharp ? CheckmarkStyle.sharp : CheckmarkStyle.round,
            ),
            const SizedBox(height: 10),
            Wrap(
              children: [
                TextButton(
                  onPressed: toggleActive,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _active ? const Text('Hide') : const Text('Show'),
                  ),
                ),
                TextButton(
                  onPressed: toggleShrink,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        _shrink ? const Text('Expand') : const Text('Shrink'),
                  ),
                ),
                TextButton(
                  onPressed: toggleSharp,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _sharp ? const Text('Round') : const Text('Sharp'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 200,
              alignment: Alignment.center,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: Colors.primaries.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  crossAxisCount: 6,
                ),
                itemBuilder: (_, i) {
                  final color = Colors.primaries[i];
                  return Card(
                    color: color,
                    child: InkWell(
                      onTap: () => setColor(color),
                      child: AnimatedCheckmark(
                        weight: 4,
                        color: Colors.white70,
                        active: _color == color,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
