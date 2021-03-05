# sketch

A simple way to create sketches. This is (as of now) not intended to be used inside a normal flutter application. sketch does not support the rendering structure of normal Widgets and is instead intended to be used on its own isolated from any other app structure. This might change in the future.

## Getting Started

Here is what a sketch might look like:

```dart
import 'package:sketch/sketch.dart';

class MySketch implements Sketch {
  void start() {

  }

  void update() {
    fill(Paint()..color = Colors.greenAccent);
    circle(100, 100, 80, Paint()..color = Colors.purple);
    roundedRectangle(200, 200, 300, 200, 15, Paint()..color = Colors.orange);
    rectangle(350, 50, 200, 100, Paint()..color = Colors.cyan);

    arc(300, 380, 200, 0, 2,
      Paint()
        ..strokeWidth = 10
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..shader = Gradient.linear(Offset(380, 380), Offset(600, 500), [Colors.green, Colors.purple])
    );
  }
}


main() => runSketch(MySketch());
```
