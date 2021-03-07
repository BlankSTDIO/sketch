import 'dart:math';

import 'package:complex/complex.dart';
import 'package:flutter/material.dart';
import 'package:sketch/sketch.dart';

class Test extends Sketch {
  Test({Widget? child}) : super(child: child);

  void start() {}

  List<double> diverges(Complex c) {
    var i = 0;
    Complex z = c;
    for (i = 0; i < 255; i++) {
      z = z * z + c;
      if (z.abs() > 255.0) {
        return [0.8, (1 - log(z.abs())) * 50.0];
      }
    }

    return [0.0, z.abs()];
  }

  void update() {
    fill(Paint()..color = Colors.black);
    var w = 1.0;
    var res = 20.0;

    for (var x = -2.3; x < 1.0; x += 1.0 / res) {
      for (var y = -1.3; y < 1.3; y += 1.0 / res) {
        var values = diverges(Complex(x, y));

        circle((x + 2.3) * 55, (y + 1.3) * 55, w, Paint()..color = HSVColor.fromAHSV(1.0, values[1] % 360.0, 1.0, values[0]).toColor());
      }
    }
  }

}

main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Test Sketch"),
          ),
          body: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
              itemCount: 20,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                  alignment: Alignment.center,
                  child: Test(),
                );
              }),
        ),
      ),
    );
