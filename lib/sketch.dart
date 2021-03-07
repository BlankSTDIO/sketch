library sketch;

export 'src/sketch.dart' show Sketch;

// I know this is not very "best-practise", but It simplifies creating sketches a lot
export 'dart:ui' show Canvas, Color, Offset, Paint, PaintingStyle, StrokeCap, StrokeJoin, Gradient, Shader, BlendMode, ImageFilter, ColorFilter, FilterQuality, MaskFilter;
export 'package:flutter/widgets.dart' show runApp;
export 'package:flutter/material.dart' show Colors;