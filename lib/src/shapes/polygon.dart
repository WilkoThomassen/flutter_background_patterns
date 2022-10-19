import 'dart:math';

import 'package:background_patterns/src/painters/base_shape_painter.dart';
import 'package:background_patterns/src/shapes/shape_configs.dart';
import 'package:flutter/material.dart';

class Polygon extends StatelessWidget {
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

  // the radians in which the polygon is rotated
  final double radians;

  final PolygonConfig config;

  const Polygon(
      {super.key,
      required this.size,
      required this.color,
      required this.depth,
      required this.config,
      this.radians = 0,
      this.perspective = 0,
      this.offset = Offset.zero});

  @override
  Widget build(BuildContext context) {
    List<Offset> shapePointLocations = [];
    var angle = (pi * 2) / config.sides;
    final shapeSize = size / 2;
    final radius = shapeSize;
    final center = size / 2;

    // build up a polygon
    Offset startPoint =
        Offset(radius * cos(radians) + center, radius * sin(radians) + center);
    shapePointLocations.add(startPoint);
    for (int i = 1; i <= config.sides; i++) {
      double x = radius * cos(radians + angle * i) + center;
      double y = radius * sin(radians + angle * i) + center;
      shapePointLocations.add(Offset(x, y));
    }

    return CustomPaint(
        painter: config.isOutlined
            ? BaseShapePainter.stroke(
                shapeSize: shapeSize,
                shapeOffset: offset,
                depth: depth,
                perspective: perspective,
                color: color,
                shapePointLocations: shapePointLocations)
            : BaseShapePainter(
                shapeSize: shapeSize,
                shapeOffset: offset,
                depth: depth,
                perspective: perspective,
                color: color,
                shapePointLocations: shapePointLocations));
  }
}
