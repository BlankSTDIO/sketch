

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

abstract class Sketch {
  void start();

  void update();
}

Sketch userSketch;
bool isFirstTime = true;
Canvas currentCanvas;

void runSketch(Sketch sketchToRun) {
  userSketch = sketchToRun;

  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

void renderSketch(Sketch sketchToRender) {
  userSketch = sketchToRender;

  window.onBeginFrame = beginRenderFrame;
  window.scheduleFrame();
}

Scene composite(Picture picture, Rect paintBounds) {
  final devicePixelRatio = window.devicePixelRatio;
  final deviceTransform = Float64List(16)
    ..[0] = devicePixelRatio
    ..[5] = devicePixelRatio
    ..[10] = 1.0
    ..[15] = 1.0;
  final sceneBuilder = SceneBuilder()
    ..pushTransform(deviceTransform)
    ..addPicture(Offset.zero, picture)
    ..pop();
  return sceneBuilder.build();
}

Picture drawFrame(Duration timeStamp, Rect paintBounds) {
  final recorder = PictureRecorder();
  currentCanvas = Canvas(recorder, paintBounds);

  if(isFirstTime) {
    userSketch.start();
    isFirstTime = false;
  } else {
    userSketch.update();
  }

  return recorder.endRecording();
}

void beginFrame(Duration timeStamp) {
  final Rect paintBounds = Offset.zero & (window.physicalSize / window.devicePixelRatio); // Rect.fromLTWH(0, 0, 1920, 1080);

  final Picture picture = drawFrame(timeStamp, paintBounds);

  final Scene scene = composite(picture, paintBounds);
  window.render(scene);

  window.scheduleFrame();
}

void beginRenderFrame(Duration timeStamp) async {
  final Rect paintBounds = Offset.zero & (window.physicalSize / window.devicePixelRatio); // Rect.fromLTWH(0, 0, 1920, 1080);

  final Picture picture = drawFrame(timeStamp, paintBounds);

  Image image = await picture.toImage(window.physicalSize.width.round(), window.physicalSize.height.round());
  var data = await image.toByteData(format: ImageByteFormat.png);

  if (data != null) {
    var file = File("./test/test_${timeStamp.inMicroseconds}.png");
    file.createSync(recursive: true);
    file.writeAsBytesSync(data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  image.dispose();

  final Scene scene = composite(picture, paintBounds);
  window.render(scene);

  window.scheduleFrame();
}
