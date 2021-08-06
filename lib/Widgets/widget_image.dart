import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui show Image;

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyWidgetState();
  }
}

class MyWidgetState extends State<MyWidget> {
  double posx = 100.0;
  double posy = 100.0;

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject() as RenderBox;

    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: new Stack(fit: StackFit.expand, children: <Widget>[
        // Hack to expand stack to fill all the space. There must be a better
        // way to do it.
        new Container(height: 200, color: Colors.black),
        new Positioned(
          child: new Text('hello'),
          left: posx,
          top: posy,
        )
      ]),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final ui.Image myBackground;
  const ShapesPainter(this.myBackground);

  @override
  void paint(Canvas canvas, Size size) {
    // final paint = Paint();
    // // set the color property of the paint
    // paint.color = Colors.yellow;
    // // center of the canvas is (x,y) => (width/2, height/2)
    // final center = Offset(size.width / 2, size.height / 2);

    // // draw the circle on centre of canvas having radius 75.0
    // //canvas.drawCircle(center, size.width / 2, paint);
    // var recorder = ui.PictureRecorder();
    // var imageCanvas = new Canvas(recorder);

    // canvas.drawImage(myBackground, Offset.zero, Paint());
    final ui.Rect rect = ui.Offset.zero & size;
    final Size imageSize =
        new Size(myBackground.width.toDouble(), myBackground.height.toDouble());

    FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, size);

    // if you don't want it centered for some reason change this.
    final Rect inputSubrect =
        Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final Rect outputSubrect =
        Alignment.center.inscribe(sizes.destination, rect);

    canvas.drawImageRect(
        myBackground, inputSubrect, outputSubrect, new Paint());
    //canvas.drawRect(Offset(0, 0) & Size(400, 400), new Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    final Offset center = Offset(0, 0);
    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: center,
            width: myBackground.width.toDouble(),
            height: myBackground.height.toDouble()),
        Radius.circular(center.dx)));
    path.close();
    return path.contains(position);
  }
}

class ShapesPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the color property of the paint
    paint.color = Colors.red;
    // center of the canvas is (x,y) => (width/2, height/2)
    var center = Offset(size.width / 2, size.height / 2);

    // draw the circle on centre of canvas having radius 75.0
    canvas.drawCircle(center, size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  @override
  bool hitTest(Offset position) {
    final Offset center = Offset(100, 100);
    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 200, height: 200),
        Radius.circular(center.dx)));
    path.close();
    return path.contains(position);
  }
}
