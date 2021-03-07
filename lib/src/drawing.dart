
import 'dart:typed_data' show Float64List;
import 'dart:ui';
import 'sketch.dart';

Paint currentStyle = Paint();

void setStyle(Paint? style) {
  if(style == null) return;

  currentStyle = style;
}

void fill([Paint? style]) {
  setStyle(style);
  currentCanvas.drawPaint(style!);
}

void circle(num x, num y, num radius, [Paint? style]) {
  setStyle(style);
  currentCanvas.drawCircle(Offset(x as double, y as double), radius as double, currentStyle);
}

void arc(num x, num y, num radius, num startAngle, num sweepAngle, [Paint? style]) {
  setStyle(style);
  currentCanvas.drawArc(Offset(x as double, y as double) & Size(radius as double, radius as double), startAngle as double, sweepAngle as double, true, currentStyle);
}

void rectangle(num x, num y, num width, num height, [Paint? style]) {
  setStyle(style);
  currentCanvas.drawRect(Offset(x as double, y as double) & Size(width as double, height as double), currentStyle);
}

void roundedRectangle(num x, num y, num width, num height, num cornerRadius, [Paint? style]) {
  setStyle(style);
  currentCanvas.drawRRect(RRect.fromRectAndRadius(Offset(x as double, y as double) & Size(width as double, height as double), Radius.circular(cornerRadius as double)), currentStyle);
}

void save() => currentCanvas.save();
void restore() => currentCanvas.restore();
void rotate(num radians) => currentCanvas.rotate(radians as double);
void translate(num dx, num dy) => currentCanvas.translate(dx as double, dy as double);
void skew(num sx, sy) => currentCanvas.skew(sx as double, sy);
void transform(Float64List matrix4) => currentCanvas.transform(matrix4);

void saveLayer(Rect bounds, [Paint? style]) {
  setStyle(style);
  currentCanvas.saveLayer(bounds, currentStyle);
}
