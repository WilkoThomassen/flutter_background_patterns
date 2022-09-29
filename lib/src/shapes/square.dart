import 'package:background_patterns/src/painters/base_shape_painter.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
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

  const Square(
      {super.key,
      required this.size,
      required this.color,
      required this.depth,
      this.perspective = 0,
      this.offset = Offset.zero,
      this.isOutlined = false});

  @override
  Widget build(BuildContext context) {
    List<Offset> shapePointLocations = [];

    // build up a square
    shapePointLocations.addAll([
      const Offset(0, 0), // start point
      Offset(0, size), // line from topleft to bottom left
      Offset(size, size), // line from bottom left to bottom right
      Offset(size, 0), // line from bottom right to top right
      const Offset(0, 0), // line from top right to top left
    ]);

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
