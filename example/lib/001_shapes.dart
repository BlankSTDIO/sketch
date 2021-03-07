


import 'package:flutter/widgets.dart';
import 'package:sketch/sketch.dart';

class MySketch extends Sketch {
  @override
  void start() {

  }

  @override
  void update() {
    fill(Paint()..color = Colors.orange);
    setStyle(Paint()..color = Colors.red);

    circle(40, 40, 20);

    pointers.forEach((key, position) {
      circle(position.dx, position.dy, 60);
    });
  }
}

main() => runApp(MySketch());