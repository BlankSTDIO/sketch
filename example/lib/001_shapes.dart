


import 'package:sketch/sketch.dart';

class MySketch implements Sketch {
  void start() {

  }

  void update() {
    fill(Paint().. color = Colors.red);

    rectangle(10, 10, 100, 100, Paint().. color = Colors.orange);
  }
}

main() => runSketch(MySketch());