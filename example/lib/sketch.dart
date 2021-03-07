import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sketch/sketch.dart';

class Test extends Sketch {
  Test({Widget? child}) : super(child: child);

  void start() {

  }

  void update() {
    fill(Paint()..color = Colors.orange);
    setStyle(Paint()..color = Colors.red);

    circle(40, 40, 20);

    pointers.forEach((key, position) {
      circle(position.dx, position.dy, 60);
    });
  }
}

main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text("Test Sketch"),
    ),
    body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
        ),
        itemCount: 250,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
            alignment: Alignment.center,
            child: Test(),
          );
        }),
  ),
),);
