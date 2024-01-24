import 'package:flutter/material.dart';

class SConstraint {
  double _sHeight = 0;
  double _sWidth = 0;

  SConstraint._();
  static final _singleton = SConstraint._();
  factory SConstraint() => _singleton;

  init(BoxConstraints constraints) {
    _sHeight = constraints.maxHeight;
    _sWidth = constraints.maxWidth;
  }

  double get height => _sHeight;
  double get width => _sWidth;
  double pHeight(double height) => (height / 949) * _sHeight;
  double pWidth(double width) => (width / 430) * _sWidth;

  double hP(double p) {
    _validateP(p);
    return p * _sHeight;
  }

  double wP(double p) {
    _validateP(p);
    return p * _sWidth;
  }

  _validateP(double p) {
    if (1 <= p || p <= 0) {
      throw const FormatException("Provided percentage value must be between 0 and 1.");
    }
  }
}
