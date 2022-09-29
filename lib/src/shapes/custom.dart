import 'dart:math';

import 'package:background_patterns/src/painters/base_shape_painter.dart';
import 'package:flutter/material.dart';

class Custom extends StatelessWidget {
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

  /// determines whether the shape is filled or outlined
  final bool isOutlined;
  final List<Offset> customPath;

  const Custom(
      {super.key,
      required this.size,
      required this.originalSize,
      required this.color,
      required this.depth,
      required this.customPath,
      this.perspective = 0,
      this.offset = Offset.zero,
      this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    // transform custom path to resized custom path
    double resizeFactor = size / originalSize;
    List<Offset> resizedCustomPath = [];

    for (final point in customPath) {
      resizedCustomPath.add(Offset(point.dx * resizeFactor, point.dy * resizeFactor));
    }

    return CustomPaint(
        painter: isOutlined
            ? BaseShapePainter.stroke(
                shapeSize: size, shapeOffset: offset, depth: depth, perspective: perspective, color: color, shapePointLocations: resizedCustomPath)
            : BaseShapePainter(
                shapeSize: size, shapeOffset: offset, depth: depth, perspective: perspective, color: color, shapePointLocations: resizedCustomPath));
  }
}
