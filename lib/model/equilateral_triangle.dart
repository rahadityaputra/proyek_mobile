import 'package:proyek_mobile/model/pyramid_base.dart';

class EquilateralTriangle extends PyramidBase {
  final double side;

  EquilateralTriangle({required this.side});
  @override
  double getArea() {
    return (1.7320508075688772 / 4) * side * side;
  }

  @override
  double getApothem() {
    return side / 1.7320508075688772;
  }
}
