class Zone {
  final Point leftUp;
  final Point leftDown;
  final Point rightUp;
  final Point rightDown;

  Zone.fromJson(Map<String, dynamic> json)
      : leftUp = Point.fromJson(json['leftUp']),
        leftDown = Point.fromJson(json['leftDown']),
        rightUp = Point.fromJson(json['rightUp']),
        rightDown = Point.fromJson(json['rightDown']);
}

class Point {
  final int X;
  final int Y;
  Point.fromJson(Map<String, dynamic> json)
      : X = json['X'],
        Y = json['Y'];
}
