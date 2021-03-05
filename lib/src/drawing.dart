
import 'dart:typed_data' show Float64List;
import 'dart:ui';
import 'sketch.dart';


void fill(Paint style) {
  currentCanvas.drawPaint(style);
}

void circle(double x, double y, double radius, Paint style) {
  currentCanvas.drawCircle(Offset(x, y), radius, style);
}

void arc(double x, double y, double radius, double startAngle, double sweepAngle, Paint style) {
  currentCanvas.drawArc(Offset(x, y) & Size(radius, radius), startAngle, sweepAngle, true, style);
}

void rectangle(double x, double y, double width, double height, Paint style) {
  currentCanvas.drawRect(Offset(x, y) & Size(width, height), style);
}

void roundedRectangle(double x, double y, double width, double height, double cornerRadius, Paint style) {
  currentCanvas.drawRRect(RRect.fromRectAndRadius(Offset(x, y) & Size(width, height), Radius.circular(cornerRadius)), style);
}

void save() => currentCanvas.save();
void restore() => currentCanvas.restore();
void rotate(double radians) => currentCanvas.rotate(radians);
void translate(double dx, double dy) => currentCanvas.translate(dx, dy);
void skew(double sx, sy) => currentCanvas.skew(sx, sy);
void transform(Float64List matrix4) => currentCanvas.transform(matrix4);
void saveLayer(Rect bounds, Paint style) => currentCanvas.saveLayer(bounds, style);
