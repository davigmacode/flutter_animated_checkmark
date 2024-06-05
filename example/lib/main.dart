import 'package:flutter/material.dart';
import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:wx_text/wx_text.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _size = 50;
  bool? _active = true;
  bool _rounded = false;
  bool _drawCross = false;
  bool _drawDash = true;
  Color? _color;

  void setActive(bool? value) {
    setState(() => _active = value);
  }

  void setRounded(bool value) {
    setState(() => _rounded = value);
  }

  void setDrawCross(bool value) {
    setState(() => _drawCross = value);
  }

  void setDrawDash(bool value) {
    setState(() => _drawDash = value);
  }

  void setColor(Color color) {
    setState(() => _color = color);
  }

  void setSize(double size) {
    setState(() => _size = size);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 35),
                child: Center(
                  child: WxText.displayMedium(
                    'AnimatedCheckmark',
                    gradient: LinearGradient(
                      colors: [
                        Colors.green,
                        Colors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    fontWeight: FontWeight.bold,
                    letterSpacing: -2,
                  ),
                ),
              ),
              ColoredBox(
                color: Colors.yellow.shade100,
                child: AnimatedCheckmark(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.linear,
                  value: _active,
                  size: _size,
                  color: _color,
                  rounded: _rounded,
                  drawCross: _drawCross,
                  drawDash: _drawDash,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: Slider(
                  value: _size,
                  max: 200,
                  min: 10,
                  label: _size.round().toString(),
                  onChanged: setSize,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  StackedCheckmark(
                    value: _active == true,
                    child: OutlinedButton(
                      onPressed: () => setActive(true),
                      child: const Text('CHECK'),
                    ),
                  ),
                  StackedCheckmark(
                    value: _active == false,
                    child: OutlinedButton(
                      onPressed: () => setActive(false),
                      child: const Text('UNCHECK'),
                    ),
                  ),
                  StackedCheckmark(
                    value: _active == null,
                    child: OutlinedButton(
                      onPressed: () => setActive(null),
                      child: const Text('UNDETERMINED'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  StackedCheckmark(
                    value: _drawCross,
                    child: OutlinedButton(
                      onPressed: () => setDrawCross(!_drawCross),
                      child: const Text('DRAW CROSS'),
                    ),
                  ),
                  StackedCheckmark(
                    value: _drawDash,
                    child: OutlinedButton(
                      onPressed: () => setDrawDash(!_drawDash),
                      child: const Text('DRAW DASH'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  StackedCheckmark(
                    value: _rounded == true,
                    child: OutlinedButton(
                      onPressed: () => setRounded(true),
                      child: const Text('ROUNDED'),
                    ),
                  ),
                  StackedCheckmark(
                    value: _rounded == false,
                    child: OutlinedButton(
                      onPressed: () => setRounded(false),
                      child: const Text('SHARPEN'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => setColor(color),
                        child: AnimatedCheckmark(
                          weight: 4,
                          color: Colors.white70,
                          value: _color == color,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StackedCheckmark extends StatelessWidget {
  const StackedCheckmark({
    super.key,
    this.value,
    required this.child,
  });

  final bool? value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: -8,
          right: -8,
          child: AnimatedCheckmark(
            value: value,
            color: Colors.blueGrey,
            weight: 5,
            size: 32,
          ),
        ),
      ],
    );
  }
}
