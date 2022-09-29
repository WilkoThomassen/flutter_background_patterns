import 'package:flutter/material.dart';

extension ShapePointLocationExtension on Offset {
  Offset withDepth({required double depth, required double size}) {
    // correct with depth, relative to size

    // invert height for calculation heightFactor because top of the shape is depth adjustment point
    double y = size - dy;

    // height of the location in shape determines the amount of depth correction of the point
    double locationHeightFactor = y > 0 ? y / size : 0;
    // division by 2 is because depth correction is for one half (left or right) of the shape
    double correction = size * (depth / 2) * locationHeightFactor;

    // if location is in first half, correct to the right else correct to the left
    if (dx < (size / 2)) {
      return Offset(dx + correction, dy);
    } else {
      return Offset(dx - correction, dy);
    }
  }

  Offset withPerspective({required double perspective, required double size}) {
    // correct with perspective, relative to size

    // invert height for calculation heightFactor because top of the shape is depth adjustment point
    double y = size - dy;
    // height of the location in shape determines the amount of perspective correction of the point
    double locationHeightFactor = y > 0 ? y / size : 0;

    double correction = size * perspective * locationHeightFactor;
    return Offset(dx + correction, dy);
  }
}
