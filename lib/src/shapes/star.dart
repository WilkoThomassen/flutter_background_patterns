import 'dart:math';

import 'package:background_patterns/extensions/shape_path_extension.dart';
import 'package:background_patterns/src/painters/base_shape_painter.dart';
import 'package:background_patterns/src/shapes/shape_configs.dart';
import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  final double size;
  final double originalSize;

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

  /// determines variables of the shape
  final StarConfig config;

  const Star(
      {super.key,
      required this.size,
      required this.originalSize,
      required this.color,
      required this.depth,
      required this.config,
      this.perspective = 0,
      this.offset = Offset.zero});

  @override
  Widget build(BuildContext context) {
    int outerRadius = config.innerRadius * config.innerOuterRadiusRatio;
    final double center = size / 2;

    List<Offset> shapePath = [];
    var angle = pi / config.innerCirclePoints;

    // build up a the star

    // number of points are sum of inner and outer points
    var points = 1 + config.innerCirclePoints * 2;
    for (int i = 0; i < points; i++) {
      var radius = i % 2 == 0 ? outerRadius : config.innerRadius;
      var x = center +
          cos(i * angle + config.angleOffsetToCenter - 0.3159) * radius;
      var y = center +
          sin(i * angle + config.angleOffsetToCenter - 0.3159) * radius;
      shapePath.add(Offset(x, y));
    }

    // resize for container depth (only if container depth is active)
    List<Offset> starPath = originalSize != size
        ? shapePath.resizeAll(originalSize: originalSize, transformSize: size)
        : shapePath;

    return CustomPaint(
        painter: config.isOutlined
            ? BaseShapePainter.stroke(
                shapeSize: size,
                shapeOffset: offset,
                depth: depth,
                perspective: perspective,
                color: color,
                shapePointLocations: starPath)
            : BaseShapePainter(
                shapeSize: size,
                shapeOffset: offset,
                depth: depth,
                perspective: perspective,
                color: color,
                shapePointLocations: starPath));
  }
}
