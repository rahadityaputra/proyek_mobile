import 'package:proyek_mobile/model/pyramid_base.dart';

class PyramidModel {
  final PyramidBase pyramidBase;
  final double height;

  PyramidModel({required this.pyramidBase, required this.height});

  double getSurfaceArea() {
    final surfaceArea = 1 / 3 * pyramidBase.getArea() * height;
    return surfaceArea;
  }

  double getVolume() {
    final volume = 1 / 3 * pyramidBase.getArea() * height;
    return volume;
  }
}
