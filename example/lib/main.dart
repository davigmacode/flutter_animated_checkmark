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
  bool _rounded = true;
  Color? _color;

  void setActive(bool? value) {
    setState(() => _active = value);
  }

  void setRounded(bool value) {
    setState(() => _rounded = value);
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
                  child: WxText.displaySmall('AnimatedCheckmark'),
                ),
              ),
              ColoredBox(
                color: Colors.yellow.shade100,
                child: AnimatedCheckmark(
                  value: _active,
                  size: _size,
                  color: _color,
                  rounded: _rounded,
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
                spacing: 5,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setActive(true);
                    },
                    child: const Text('CHECK'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setActive(false);
                    },
                    child: const Text('UNCHECK'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setActive(null);
                    },
                    child: const Text('UNDETERMINED'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 5,
                children: [
                  OutlinedButton(
                    onPressed: () => setRounded(true),
                    child: const Text('ROUNDED'),
                  ),
                  OutlinedButton(
                    onPressed: () => setRounded(false),
                    child: const Text('SHARPEN'),
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
