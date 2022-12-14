<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A Flutter package for making widgets with a pattern in the background.
background patterns can be placed anywhere whether it is the background of a page or for example on a button

## Preview

Features

![The example app running](https://github.com/WilkoThomassen/flutter_background_patterns/blob/feature/setup-flutter-package-deliverables/assets/preview/preview-background-patterns-video.gif)

Example

![The example app in game](https://github.com/WilkoThomassen/flutter_background_patterns/blob/feature/setup-flutter-package-deliverables/assets/preview/background-patterns-game-sample.png)


## Features

* Implement a pattern container in any widget
* Shape can be a package default shape (square, triangle, hexagon)
* Shape can be a custom shape where the custom path should be provided
* Several different shapes can be combined in the container
* Shape size, depth, perspective can be set
* Perspective in container can be set and margins between shapes
    
## Install

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  background_patterns: <latest_version>
```

In your library add the following import:

```dart
import 'package:background_patterns/background_patterns.dart';
```

## Getting started

Example: 



## Minimal usage 

```dart

return PatternContainer(
        shapes: [SquareConfig()],
        shapeColor: Colors.black);

```

## Configure usage 

```dart

return PatternContainer(
        shapeSize: 40,
        perspective: 0.8,
        shapeDepth: 0.5,
        containerDepth: 0.2,
        alignShapesVertical: true,
        shapes: [
          PolygonConfig(),
          PolygonConfig(isOutlined: true),
          StarConfig(),
          StarConfig(isOutlined: true, innerCirclePoints: 7, innerRadius: 30, innerOuterRadiusRatio: 2, angleOffsetToCenter: 40)
        ],
        shapeColor: Colors.green);

```

## Custom shapes 

```dart

List<Offset> customStarPath = [];

double shapeSize = 120;

// build up a star
customStarPath.add(Offset(shapeSize / 2, 0));
customStarPath.add(Offset(shapeSize, shapeSize));
customStarPath.add(Offset(0, shapeSize / 3));
customStarPath.add(Offset(shapeSize, shapeSize / 3));
customStarPath.add(Offset(0, shapeSize));
customStarPath.add(Offset(shapeSize / 2, 0));

return PatternContainer(
        customPath: customStarPath,
        shapes: const [Shape.customOutlined],
        shapeColor: Colors.black);

```

