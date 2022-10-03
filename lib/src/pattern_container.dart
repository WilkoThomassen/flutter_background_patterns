import 'package:background_patterns/src/shapes/custom.dart';
import 'package:background_patterns/src/shapes/polygon.dart';
import 'package:background_patterns/src/shapes/square.dart';
import 'package:background_patterns/src/shapes/star.dart';
import 'package:flutter/material.dart';

enum Shape { square, squareOutlined, polygon, polygonOutlined, star, starOutlined, custom, customOutlined }

class PatternContainer extends StatelessWidget {
  final Widget child;

  /// the shapes that are rendered on the background
  /// a minimum of 1 shape must be set
  final List<Shape> shapes;
  final Color shapeColor;
  final double shapeSize;

  /// the top-to-bottom depth creating a depth look on the shape
  /// min: 0 (no depth) max: 1 (max depth)
  final double shapeDepth;

  /// the top-to-bottom depth inside the container which set upper shapes smaller than lower shapes
  /// min: 0 (no depth) max: 1 (max depth)
  final double containerDepth;

  /// the left-to-right perspective creating a perspective look on the shape
  /// only has effect when there is also depth
  /// min: -1 (perspective most from the left)
  /// max: 1 (perspective most from the right)
  final double perspective;

  /// margin between shapes on a row
  final double margin;

  /// sets the shape aligned vertically
  /// when false, the uneven rows will start with a half-shape margin
  final bool alignShapesVertical;

  /// sets the shape path of the customshape
  /// at least 'custom' or 'customOutlined' should be set in the shapes parameter
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
      this.perspective = 0,
      this.alignShapesVertical = false});

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
    // this margin sets a space for every uneven row to ensure that shapes are not aligned vertically

    final double unAlignVerticalMargin = !alignShapesVertical && rowIndex % 2 == 0 ? rowShapeSize / 2 : 0;
    final Offset shapeOffset =
        Offset((margin + unAlignVerticalMargin + columnIndex * (rowShapeSize + margin) - shapeSize), rowIndex * (rowShapeSize + margin));
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
      case Shape.star:
        return Star(size: rowShapeSize, color: shapeColor, depth: shapeDepth, perspective: perspective, offset: shapeOffset);
      case Shape.starOutlined:
        return Star(size: rowShapeSize, color: shapeColor, depth: shapeDepth, perspective: perspective, offset: shapeOffset, isOutlined: true);
      case Shape.custom:
        return Custom(
            size: rowShapeSize,
            originalSize: shapeSize,
            color: shapeColor,
            depth: shapeDepth,
            perspective: perspective,
            offset: shapeOffset,
            customPath: customPath!);
      case Shape.customOutlined:
        return Custom(
            size: rowShapeSize,
            originalSize: shapeSize,
            color: shapeColor,
            depth: shapeDepth,
            perspective: perspective,
            offset: shapeOffset,
            isOutlined: true,
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
