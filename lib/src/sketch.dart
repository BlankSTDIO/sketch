import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

typedef DrawCall = Paint? Function(Canvas canvas, Size size, Paint currentStyle);

class Sketch extends SingleChildRenderObjectWidget {
  final Queue<DrawCall> userDrawCalls = Queue();
  final Map<int, Offset> pointers = <int, Offset>{};

  Sketch({Key? key, Widget? child}) : super(key: key, child: child == null ? Container(constraints: BoxConstraints.expand()) : child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SketchRenderer(
      size: Size(BoxConstraints.expand().maxWidth, BoxConstraints.expand().maxHeight),
      userSketch: this,
      context: context,
    );
  }

  void start() {}

  void update() {}

  void setStyle(Paint? style) {
    if (style != null) userDrawCalls.add((canvas, size, currentStyle) => style);
  }

  void circle(num x, num y, num radius, [Paint? style]) {
    setStyle(style);
    userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
      canvas.drawCircle(Offset(x.toDouble(), y.toDouble()), radius.toDouble(), currentStyle);
    });
  }

  void fill([Paint? style]) {
    setStyle(style);
    userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
      canvas.drawPaint(style!);
    });
  }

  void arc(num x, num y, num radius, num startAngle, num sweepAngle, [Paint? style]) {
    setStyle(style);
    userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
      canvas.drawArc(Offset(x.toDouble(), y.toDouble()) & Size(radius.toDouble(), radius.toDouble()), startAngle.toDouble(), sweepAngle.toDouble(), true, currentStyle);
    });
  }

  void rectangle(num x, num y, num width, num height, [Paint? style]) {
    setStyle(style);
    userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
      canvas.drawRect(Offset(x.toDouble(), y.toDouble()) & Size(width.toDouble(), height.toDouble()), currentStyle);
    });
  }

  void roundedRectangle(num x, num y, num width, num height, num cornerRadius, [Paint? style]) {
    setStyle(style);
    userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
      canvas.drawRRect(RRect.fromRectAndRadius(Offset(x.toDouble(), y.toDouble()) & Size(width.toDouble(), height.toDouble()), Radius.circular(cornerRadius.toDouble())), currentStyle);
    });
  }

  void saveLayer(Rect bounds, [Paint? style]) {
    setStyle(style);
    userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
      canvas.saveLayer(bounds, currentStyle);
    });
  }

  void save() => userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
        canvas.save();
      });
  void restore() => userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
        canvas.restore();
      });
  void rotate(num radians) => userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
        canvas.rotate(radians.toDouble());
      });
  void translate(num dx, num dy) => userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
        canvas.translate(dx.toDouble(), dy.toDouble());
      });
  void skew(num sx, num sy) => userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
        canvas.skew(sx.toDouble(), sy.toDouble());
      });
  void transform(Float64List matrix4) => userDrawCalls.add((Canvas canvas, Size size, Paint currentStyle) {
        canvas.transform(matrix4);
      });
}

class SketchRenderer extends RenderCustomPaint {
  Sketch userSketch;
  late Ticker ticker;

  @override
  bool hitTestSelf(Offset pos) => true;

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    if (event is PointerDownEvent) {
      userSketch.pointers[event.pointer] = globalToLocal(event.position);
    } else if (event is PointerUpEvent || event is PointerCancelEvent) {
      userSketch.pointers.remove(event.pointer);
    } else if (event is PointerMoveEvent) {
      userSketch.pointers[event.pointer] = globalToLocal(event.position);
    }
  }

  SketchRenderer({
    required BuildContext context,
    required this.userSketch,
    required Size size,
    RenderBox? child,
  }) : super(willChange: true, preferredSize: size, painter: SketchPainter(userSketch: userSketch), child: child) {
    this.ticker = Ticker((Duration duration) => markNeedsPaint());
    ticker.start();
  }
}

class SketchPainter extends CustomPainter {
  Sketch userSketch;
  bool isFirstTime = true;

  SketchPainter({
    required this.userSketch,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    Paint currentStyle = Paint();

    if (isFirstTime) {
      userSketch.start();
      isFirstTime = false;
    }

    userSketch.update();

    DrawCall currentDrawCall;
    while (userSketch.userDrawCalls.isNotEmpty) {
      currentDrawCall = userSketch.userDrawCalls.removeFirst();

      Paint? newPaint = currentDrawCall(canvas, size, currentStyle);
      if (newPaint != null) {
        currentStyle = newPaint;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
