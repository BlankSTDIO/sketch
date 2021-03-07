


import 'package:sketch/sketch.dart';

class MySketch implements Sketch {
  double t = 0.0;

  void start() {

  }

  void update() {
    fill(Paint().. color = Colors.red);
    setStyle(Paint().. color = Colors.orange);

    rectangle(10 + t, 10, 100, 100);
    circle(190, 90 + t, 50);
    t += 0.1;
  }
}

main() => runSketch(MySketch());