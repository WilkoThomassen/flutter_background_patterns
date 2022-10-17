import 'package:flutter/material.dart';

abstract class BaseShapeConfig {
  final bool isOutlined;

  BaseShapeConfig(this.isOutlined);
}

class StarConfig extends BaseShapeConfig {
  StarConfig(
      {bool isOutlined = false, this.innerCirclePoints = 5, this.innerRadius = 25, this.innerOuterRadiusRatio = 2, this.angleOffsetToCenter = 0})
      : super(isOutlined);

  final int innerCirclePoints;
  final int innerRadius;
  final int innerOuterRadiusRatio;
  final int angleOffsetToCenter;
}

class SquareConfig extends BaseShapeConfig {
  SquareConfig({bool isOutlined = false}) : super(isOutlined);
}

class PolygonConfig extends BaseShapeConfig {
  PolygonConfig({bool isOutlined = false, this.sides = 6}) : super(isOutlined);
  final int sides;
}

class CustomConfig extends BaseShapeConfig {
  CustomConfig({bool isOutlined = false, required this.customPath}) : super(isOutlined);

  /// determines the path that has will be drawn
  final List<Offset> customPath;
}
