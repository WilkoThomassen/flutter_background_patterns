import 'package:background_patterns/extensions/shape_point_location_extension.dart';
import 'package:flutter/material.dart';

class BaseShapePainter extends CustomPainter {
  late Paint _paint;
  final Offset shapeOffset;
  final List<Offset> shapePointLocations;
  final double shapeSize;

  /// the top-to-bottom depth creating a depth look on the shape
  final double depth;

  /// the left-to-right perspective creating a perspective look on the shape
  final double perspective;

  BaseShapePainter(
      {required Color color,
      required this.shapeSize,
      required this.shapePointLocations,
      this.shapeOffset = Offset.zero,
      this.depth = 0,
      this.perspective = 0}) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  BaseShapePainter.stroke(
      {required Color color,
      required this.shapeSize,
      required this.shapePointLocations,
      this.shapeOffset = Offset.zero,
      this.depth = 0,
      this.perspective = 0}) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // paint square
    var path = Path();

    // transform point locations with depth and perspective dimensions
    List<Offset> transformedShape = [];
    for (Offset pointLocation in shapePointLocations) {
      transformedShape.add(pointLocation.withDepth(depth: depth, size: shapeSize).withPerspective(perspective: perspective, size: shapeSize));
    }

    // increasing on shapeOffset is because shapes points offsets are relative to the shape offset
    path.moveTo(shapeOffset.dx + transformedShape.first.dx, shapeOffset.dy + transformedShape.first.dy);

    for (int i = 1; i < transformedShape.length; i++) {
      path.lineTo(shapeOffset.dx + transformedShape[i].dx, shapeOffset.dy + transformedShape[i].dy);
    }

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
