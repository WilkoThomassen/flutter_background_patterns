import 'package:background_patterns/src/shapes/custom.dart';
import 'package:background_patterns/src/shapes/polygon.dart';
import 'package:background_patterns/src/shapes/square.dart';
import 'package:flutter/material.dart';

enum Shape { square, squareOutlined, polygon, polygonOutlined, custom, customOutlined }

class PatternContainer extends StatelessWidget {
  final Widget child;
  final List<Shape> shapes;
  final Color shapeColor;
  final double shapeSize;
  final double shapeDepth;
  final double containerDepth;
  final double perspective;
  final double margin;
  final List<Offset>? customPath;

  const PatternContainer(
      {super.key,
      required this.child,
      required this.shapeColor,
      required this.shapes,
      this.customPath,
      this.margin = 5,
      this.shapeSize = 30,
      this.shapeDepth = 0,
      this.containerDepth = 0,
      this.perspective = 0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [_getShapesStack(constraints.maxWidth, constraints.maxHeight), child],
      );
    });
  }

  Stack _getShapesStack(double width, double height) {
    int rows = (height / shapeSize).round();

    List<Widget> shapes = [];

    for (int ri = 0; ri < rows; ri++) {
      double rowShapeSize = shapeSize.withContainerDepth(depth: containerDepth, row: ri, rows: rows);
      int columns = (width / rowShapeSize).round();
      for (int ci = 0; ci < columns; ci++) {
        shapes.add(_getShape(ri, ci, rowShapeSize));
      }
    }

    return Stack(children: shapes);
  }

  Widget _getShape(int rowIndex, int columnIndex, double rowShapeSize) {
    final Offset shapeOffset = Offset((margin + columnIndex * (rowShapeSize + margin) - shapeSize), rowIndex * (rowShapeSize + margin));
    final shapeIndex = columnIndex % shapes.length;
    Shape shape = shapes[shapeIndex];

    switch (shape) {
      case Shape.square:
        return Square(size: rowShapeSize, color: shapeColor, depth: shapeDepth, perspective: perspective, offset: shapeOffset);
      case Shape.squareOutlined:
        return Square(size: rowShapeSize, color: shapeColor, depth: shapeDepth, perspective: perspective, offset: shapeOffset, isOutlined: true);
      case Shape.polygon:
        return Polygon(size: rowShapeSize, color: shapeColor, depth: shapeDepth, perspective: perspective, offset: shapeOffset);
      case Shape.polygonOutlined:
        return Polygon(
          size: rowShapeSize,
          color: shapeColor,
          depth: shapeDepth,
          perspective: perspective,
          offset: shapeOffset,
          isOutlined: true,
        );
      case Shape.customOutlined:
        return Custom(
            size: rowShapeSize,
            originalSize: shapeSize,
            color: shapeColor,
            depth: shapeDepth,
            perspective: perspective,
            offset: shapeOffset,
            customPath: customPath!);
      default:
        return Container();
    }
  }
}

extension ContainerDepthExtension on double {
  double withContainerDepth({required double depth, required int row, required int rows}) {
    double rowFactor = 1 / rows;
    double rowCorrection = this * rowFactor * (rows - row);

    return this - (rowCorrection * depth);
  }
}
