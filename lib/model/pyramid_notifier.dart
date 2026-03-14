import 'package:flutter/material.dart';
import 'package:proyek_mobile/model/circle.dart';
import 'package:proyek_mobile/model/equilateral_triangle.dart';
import 'package:proyek_mobile/model/pyramid_base.dart';
import 'package:proyek_mobile/model/pyramid_model.dart';
import 'package:proyek_mobile/model/square.dart';

enum PyramidBaseType { square, circle, equilateralTriangle }

class PyramidNotifier with ChangeNotifier {
  PyramidBaseType _baseType = PyramidBaseType.square;
  double _baseValue = 0;
  double _height = 0;

  double _volume = 0;
  double _surfaceArea = 0;

  PyramidBaseType get baseType => _baseType;
  double get baseValue => _baseValue;
  double get height => _height;
  double get volume => _volume;
  double get surfaceArea => _surfaceArea;

  void updateBaseType(PyramidBaseType newType) {
    _baseType = newType;
    _recalculate();
  }

  void updateBaseValue(String value) {
    _baseValue = double.tryParse(value) ?? 0;
    _recalculate();
  }

  void updateHeight(String value) {
    _height = double.tryParse(value) ?? 0;
    _recalculate();
  }

  String get baseInputLabel {
    switch (_baseType) {
      case PyramidBaseType.square:
        return 'Square side';
      case PyramidBaseType.circle:
        return 'Circle radius';
      case PyramidBaseType.equilateralTriangle:
        return 'Triangle side';
    }
  }

  void _recalculate() {
    if (_baseValue <= 0 || _height <= 0) {
      _volume = 0;
      _surfaceArea = 0;
      notifyListeners();
      return;
    }

    final PyramidBase baseShape;
    switch (_baseType) {
      case PyramidBaseType.square:
        baseShape = Square(side: _baseValue);
      case PyramidBaseType.circle:
        baseShape = Circle(radius: _baseValue);
      case PyramidBaseType.equilateralTriangle:
        baseShape = EquilateralTriangle(side: _baseValue);
    }

    final pyramid = PyramidModel(pyramidBase: baseShape, height: _height);
    _volume = pyramid.getVolume();
    _surfaceArea = pyramid.getSurfaceArea();

    notifyListeners();
  }
}
