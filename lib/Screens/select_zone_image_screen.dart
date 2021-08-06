import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kids_care/Widgets/select_zone_image_widget.dart';
import 'package:kids_care/Widgets/widget_image.dart';

import 'dart:ui' as ui show Image;

import 'package:kids_care/blocs/zone_bloc/zone_bloc.dart';

class SelectZoneImageScreen extends StatefulWidget {
  SelectZoneImageScreen();
  SelectZoneImageScreenState createState() => SelectZoneImageScreenState();
}

class SelectZoneImageScreenState extends State<SelectZoneImageScreen>
    with WidgetsBindingObserver {
  ZoneBLoC zoneBLoC = new ZoneBLoC();
  GlobalKey _keyYellow = GlobalKey();
  GlobalKey _keyRectangle = GlobalKey();
  ui.Image? imageUi;
  LayoutBox _layoutBoxModel = new LayoutBox(0.0, 0.0, 0, 0);

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    imageUi = await getImage('http://198.199.72.194:1880/imageFromApp');
    setState(() {});
  }

  Future<ui.Image> getImage(String path) async {
    Completer<ImageInfo> completer = Completer();
    var img = new NetworkImage(path);
    img
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Red Zone Detection", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: <Widget>[],
      ),
      body: Center(
        child: Container(
          child: Listener(
            onPointerMove: (PointerEvent details) {
              //final RenderBox box =
              //   _keyRed.currentContext!.findRenderObject() as RenderBox;
              final RenderBox boxYellow =
                  _keyYellow.currentContext!.findRenderObject() as RenderBox;
              final RenderBox boxRec =
                  _keyRectangle.currentContext!.findRenderObject() as RenderBox;
              final result = BoxHitTestResult();
              //Offset localRed = box.globalToLocal(details.position);
              Offset localYellow = boxYellow.globalToLocal(details.position);
              Offset recPosition = new Offset(this._layoutBoxModel.retLeft(),
                  this._layoutBoxModel.retTop());
              print("HIT...  " +
                  this._layoutBoxModel.retTop().toString() +
                  ", " +
                  this._layoutBoxModel.retLeft().toString());

              // Offset localRec = boxYellow.globalToLocal(recPosition);
              // double x = _keyYellow.globalPosition!.dx -
              //     _keyRectangle.globalPosition!.dx;
              // double y = _keyYellow.globalPosition!.dy -
              //     _keyRectangle.globalPosition!.dy;
              final positionRed = boxRec.localToGlobal(details.position);
              print("POSITION of Red: $positionRed ");
              // if (box.hitTest(result, position: localRed)) {
              //   print("HIT...RED ");
              // } else
              if (boxYellow.hitTest(result, position: localYellow)) {
                print(localYellow.dx.toString() +
                    " " +
                    localYellow.dy.toString());
                print("HIT...YELLOW ");
              }
            },
            child: Stack(
              children: <Widget>[
                imageUi != null
                    ? CustomPaint(
                        key: _keyYellow,
                        painter: ShapesPainter(imageUi!),
                        child: Container(
                          height: (imageUi!.height.toDouble() /
                                  imageUi!.width.toDouble()) *
                              MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                          child: ResizebleWidget(
                            LayoutBoxModel: _layoutBoxModel,
                            key: _keyRectangle,
                            child: Text(
                              '',
                            ),
                          ),
                        ))
                    : SizedBox(),

                // CustomPaint(
                //   key: _keyRed,
                //   painter: ShapesPainter1(),
                //   child: Container(
                //     height: 200,
                //     width: 200,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
