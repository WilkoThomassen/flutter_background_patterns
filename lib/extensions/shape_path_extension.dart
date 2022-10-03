import 'package:flutter/material.dart';

extension ShapePathExtension on List<Offset> {
  /// transform custom path to resized custom path
  List<Offset> resizeAll({required double originalSize, required double transformSize}) {
    double resizeFactor = transformSize / originalSize;
    List<Offset> resizedCustomPath = [];

    for (final point in this) {
      resizedCustomPath.add(Offset(point.dx * resizeFactor, point.dy * resizeFactor));
    }
    return resizedCustomPath;
  }
}
