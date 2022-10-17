import 'dart:math';

import 'package:background_patterns/extensions/shape_path_extension.dart';
import 'package:background_patterns/src/painters/base_shape_painter.dart';
import 'package:background_patterns/src/shapes/shape_configs.dart';
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

  final CustomConfig config;

  const Custom(
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
    // resize for container depth (only if container depth is active)
    List<Offset> resizedCustomPath =
        originalSize != size ? config.customPath.resizeAll(originalSize: originalSize, transformSize: size) : config.customPath;

    return CustomPaint(
        painter: config.isOutlined
            ? BaseShapePainter.stroke(
                shapeSize: size, shapeOffset: offset, depth: depth, perspective: perspective, color: color, shapePointLocations: resizedCustomPath)
            : BaseShapePainter(
                shapeSize: size, shapeOffset: offset, depth: depth, perspective: perspective, color: color, shapePointLocations: resizedCustomPath));
  }
}
