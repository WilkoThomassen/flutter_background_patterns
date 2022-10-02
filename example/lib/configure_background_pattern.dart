import 'package:background_patterns/background_patterns.dart';
import 'package:flutter/material.dart';

class ConfigureBackgroundPattern extends StatefulWidget {
  const ConfigureBackgroundPattern({super.key});

  @override
  ConfigureBackgroundPatternState createState() => ConfigureBackgroundPatternState();
}

class ConfigureBackgroundPatternState extends State<ConfigureBackgroundPattern> {
  double _shapeSize = 80;
  double _margin = 20;
  double _shapeDepth = 0.0;
  double _containerDepth = 0.0;
  double _perspective = 0.0;

  @override
  Widget build(BuildContext context) {
    // star shape
    List<Offset> customStarPath = [];

    // build up a star
    customStarPath.add(Offset(_shapeSize / 2, 0));
    customStarPath.add(Offset(_shapeSize, _shapeSize));
    customStarPath.add(Offset(0, _shapeSize / 3));
    customStarPath.add(Offset(_shapeSize, _shapeSize / 3));
    customStarPath.add(Offset(0, _shapeSize));
    customStarPath.add(Offset(_shapeSize / 2, 0));

    return PatternContainer(
        shapeSize: _shapeSize,
        perspective: _perspective,
        shapeDepth: _shapeDepth,
        containerDepth: _containerDepth,
        customPath: customStarPath,
        alignShapesVertical: true,
        shapes: const [Shape.polygon, Shape.polygonOutlined, Shape.square, Shape.squareOutlined, Shape.custom, Shape.customOutlined],
        margin: _margin,
        shapeColor: Colors.black12,
        child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const Text('Shape size'),
                Slider(
                    value: _shapeSize,
                    min: 5,
                    max: 200,
                    divisions: 8,
                    label: _shapeSize.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _shapeSize = value;
                      });
                    }),
                const Text('Margin between shapes'),
                Slider(
                    value: _margin,
                    min: 0,
                    max: 80,
                    divisions: 8,
                    label: _margin.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _margin = value;
                      });
                    }),
                const Text('Shape depth'),
                Slider(
                    value: _shapeDepth,
                    max: 1,
                    divisions: 8,
                    label: _shapeDepth.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _shapeDepth = value;
                      });
                    }),
                const Text('Shape perspective'),
                Slider(
                  activeColor: Colors.blue.withAlpha(50),
                  inactiveColor: Colors.blue.withAlpha(50),
                  thumbColor: Colors.blue,
                  value: _perspective,
                  min: -1,
                  max: 1,
                  divisions: 8,
                  label: _perspective.toString(),
                  onChanged: (double value) {
                    setState(() {
                      _perspective = value;
                    });
                  },
                ),
                const Text('Container depth'),
                Slider(
                    value: _containerDepth,
                    max: 1,
                    divisions: 8,
                    label: _containerDepth.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _containerDepth = value;
                      });
                    })
              ],
            )));
  }
}
