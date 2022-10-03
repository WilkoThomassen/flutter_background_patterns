import 'dart:math';

import 'package:background_patterns/src/painters/base_shape_painter.dart';
import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  final double size;

  final Color color;

  /// the top-to-bottom depth creating a depth look on the shape
  /// min: 0 (no depth) max: 1 (max depth)
  final double depth;

  /// the left-to-right perspective creating a perspective look on the shape
  /// only has effect when there is also depth
  /// min: -1 (perspective most from the left)
  /// max: 1 (perspective most from the right)
  final double perspective;

  /// the location of the shape in its parent
  final Offset offset;

  /// determines whether the shape is filled or outlined
  final bool isOutlined;

  const Star(
      {super.key,
      required this.size,
      required this.color,
      required this.depth,
      this.perspective = 0,
      this.offset = Offset.zero,
      this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    // TODO: not scaling properly on container depth
    // TODO: make these constants configurable for pattern container
    const int innerCirclePoints = 5;
    const int innerRadius = 25;
    const int innerOuterRadiusRatio = 2;
    const int outerRadius = innerRadius * innerOuterRadiusRatio;
    const int angleOffsetToCenter = 0;
    final double center = size / 2;

    List<Offset> shapePointLocations = [];
    var angle = pi / innerCirclePoints;

    // build up a the star

    // number of points are sum of inner and outer points
    var points = 1 + innerCirclePoints * 2;
    for (int i = 0; i < points; i++) {
      var radius = i % 2 == 0 ? outerRadius : innerRadius;
      var x = center + cos(i * angle + angleOffsetToCenter - 0.3) * radius;
      var y = center + sin(i * angle + angleOffsetToCenter - 0.3) * radius;
      shapePointLocations.add(Offset(x, y));
    }

    return CustomPaint(
        painter: isOutlined
            ? BaseShapePainter.stroke(
                shapeSize: size, shapeOffset: offset, depth: depth, perspective: perspective, color: color, shapePointLocations: shapePointLocations)
            : BaseShapePainter(
                shapeSize: size,
                shapeOffset: offset,
                depth: depth,
                perspective: perspective,
                color: color,
                shapePointLocations: shapePointLocations));
  }
}
