import 'package:background_patterns/background_patterns.dart';
import 'package:background_patterns/extensions/shape_point_location_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('basic shape depth tests', () {
    expect(const Offset(0, 0).withDepth(depth: 1, size: 100),
        const Offset(50.0, 0.0));
    expect(const Offset(0, 25).withDepth(depth: 1, size: 100),
        const Offset(37.5, 25.0));

    expect(const Offset(80, 0).withDepth(depth: 1, size: 100),
        const Offset(30.0, 0.0));
    expect(const Offset(80, 75).withDepth(depth: 1, size: 100),
        const Offset(67.5, 75.0));

    expect(const Offset(80, 0).withDepth(depth: 0.6, size: 100),
        const Offset(50.0, 0.0));
    expect(const Offset(80, 75).withDepth(depth: 0.6, size: 100),
        const Offset(72.5, 75.0));
  });

  test('basic perspective tests', () {
    expect(const Offset(0, 0).withPerspective(perspective: 1, size: 100),
        const Offset(100.0, 0.0));
    expect(const Offset(0, 25).withPerspective(perspective: 1, size: 100),
        const Offset(75.0, 25.0));

    expect(const Offset(80, 0).withPerspective(perspective: 1, size: 100),
        const Offset(180.0, 0.0));
    expect(const Offset(80, 75).withPerspective(perspective: 1, size: 100),
        const Offset(105.0, 75.0));

    expect(const Offset(80, 0).withPerspective(perspective: 0.6, size: 100),
        const Offset(140.0, 0.0));
    expect(const Offset(80, 75).withPerspective(perspective: 0.6, size: 100),
        const Offset(95.0, 75.0));
  });

  test('basic container depth', () {
    expect(80.0.withContainerDepth(depth: 0, row: 1, rows: 8), 80);
    expect(80.0.withContainerDepth(depth: 0, row: 7, rows: 8), 80);
    expect(80.0.withContainerDepth(depth: 0, row: 8, rows: 8), 80);

    expect(80.0.withContainerDepth(depth: 1, row: 1, rows: 8), 10);
    expect(80.0.withContainerDepth(depth: 1, row: 7, rows: 8), 70);

    expect(80.0.withContainerDepth(depth: 0.5, row: 1, rows: 8), 45);
    expect(80.0.withContainerDepth(depth: 0.5, row: 7, rows: 8), 75);

    expect(50.0.withContainerDepth(depth: 0.2, row: 1, rows: 10), 41);
    expect(50.0.withContainerDepth(depth: 0.2, row: 8, rows: 10), 48);
    expect(50.0.withContainerDepth(depth: 0.2, row: 10, rows: 10), 50);

    expect(50.0.withContainerDepth(depth: 0.8, row: 1, rows: 10), 14);
    expect(50.0.withContainerDepth(depth: 0.8, row: 8, rows: 10), 42);
    expect(50.0.withContainerDepth(depth: 0.8, row: 10, rows: 10), 50);
  });
}
