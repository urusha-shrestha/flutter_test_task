import 'package:flutter/material.dart';
import 'package:flutter_test_task/ripple_painter.dart';

///the main page of the application
class HomePage extends StatefulWidget {
  ///
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  Color _rippleColor = Colors.red;
  late int _seed = DateTime.now().millisecondsSinceEpoch;

  final List<Offset> _tapPoints = [];
  final List<double> _rippleRadius = [];
  final List<double> _rippleOpacity = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..addListener(() {
        setState(() {
          for (int i = 0; i < _rippleRadius.length; i++) {
            // ignore: no_magic_number
            _rippleRadius[i] = _controller.value * 100;
            _rippleOpacity[i] = 1 - _controller.value;
          }
        });
      });
  }

  int _lcgAlgorithm() {
    //constants
    const int a = 1664525;
    const int c = 1013904223;
    const int m = 4294967296;

    return _seed = (a * _seed + c) % m;
  }

  //Function to generate a random color
  Color _generateRandomColor() {
    const int rgb = 256;

    return Color.fromRGBO(
      _lcgAlgorithm() % rgb,
      _lcgAlgorithm() % rgb,
      _lcgAlgorithm() % rgb,
      1.0,
    );
  }

  //Function to change both background and text color on tap
  void _changeColors(TapDownDetails details) {
    setState(() {
      _backgroundColor = _generateRandomColor();
      _textColor = _generateRandomColor();
      _rippleColor = _generateRandomColor();
      // Clear all previous ripple data
      _tapPoints.clear();
      _rippleRadius.clear();
      _rippleOpacity.clear();
      _tapPoints.add(details.localPosition);
      _rippleRadius.add(1);
      // ignore: no_magic_number
      _rippleOpacity.add(0.5);
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: _changeColors,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              color: _backgroundColor,
              child: Center(
                child: AnimatedDefaultTextStyle(
                  style: TextStyle(
                    fontSize: 40,
                    color: _textColor,
                    fontWeight: FontWeight.bold,
                  ),
                  duration: const Duration(seconds: 1),
                  child: const Text('Hello There'),
                ),
              ),
            ),
            CustomPaint(
              painter: RipplePainter(
                _tapPoints,
                _rippleRadius,
                _rippleOpacity,
                _rippleColor,
              ),
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
