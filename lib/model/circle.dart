import 'dart:math';

import 'package:proyek_mobile/model/pyramid_base.dart';

class Circle extends PyramidBase {
  final double radius;

  Circle({required this.radius});
  @override
  double getArea() {
    final area = radius * radius * pi;
    return area;
  }

  @override
  double getApothem() {
    return radius;
  }
}
