import 'package:proyek_mobile/model/pyramid_base.dart';

class Square extends PyramidBase{
  final double side;

  Square({required this.side});

  @override
  double getArea() {
    final area = side * side;
    return area;
  }

  @override
  double getApothem() {
    final apothem = side / 2;
    return apothem;
  }
}