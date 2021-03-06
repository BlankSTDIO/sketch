
import 'dart:typed_data' show Float64List;
import 'dart:ui';
import 'sketch.dart';

Paint latestStyle = Paint();

void fill([Paint style]) {
  currentCanvas.drawPaint(style);
}

void circle(num x, num y, num radius, [Paint style]) {
  currentCanvas.drawCircle(Offset(x.toDouble(), y.toDouble()), radius.toDouble(), style);
}

void arc(num x, num y, num radius, num startAngle, num sweepAngle, [Paint style]) {
  currentCanvas.drawArc(Offset(x.toDouble(), y.toDouble()) & Size(radius.toDouble(), radius.toDouble()), startAngle.toDouble(), sweepAngle.toDouble(), true, style);
}

void rectangle(num x, num y, num width, num height, [Paint style]) {
  currentCanvas.drawRect(Offset(x.toDouble(), y.toDouble()) & Size(width.toDouble(), height.toDouble()), style);
}

void roundedRectangle(num x, num y, num width, num height, num cornerRadius, [Paint style]) {
  currentCanvas.drawRRect(RRect.fromRectAndRadius(Offset(x.toDouble(), y.toDouble()) & Size(width.toDouble(), height.toDouble()), Radius.circular(cornerRadius.toDouble())), style);
}

void save() => currentCanvas.save();
void restore() => currentCanvas.restore();
void rotate(num radians) => currentCanvas.rotate(radians);
void translate(num dx, num dy) => currentCanvas.translate(dx.toDouble(), dy.toDouble());
void skew(num sx, sy) => currentCanvas.skew(sx, sy);
void transform(Float64List matrix4) => currentCanvas.transform(matrix4);
void saveLayer(Rect bounds, [Paint style]) => currentCanvas.saveLayer(bounds, style);
