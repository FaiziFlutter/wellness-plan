import 'dart:math';

import 'package:flutter/painting.dart';

/// A rectangular border with rounded corners.
///
/// Typically used with [ShapeDecoration] to draw a box with a rounded
/// rectangle for which each side/corner has different specifications such as color, width....
///
///
/// See also:
///
///  * [CustomRoundedRectangleBorder], which is similar to this class, but with less options to controll the appearance of each side/corner.
///  * [BorderSide], which is used to describe each side of the box.
///  * [Border], which, when used with [BoxDecoration], can also
///    describe a rounded rectangle.
class CustomRoundedRectangleBorder extends ShapeBorder {
  /// Creates a custom rounded rectangle border.
  /// Custom meaning that every single side/corner is controlled individually
  /// which grants the possibility to leave out borders, give each border a different color...
  ///
  /// The arguments must not be null.
  const CustomRoundedRectangleBorder({
    this.leftSide,
    this.rightSide,
    this.topSide,
    this.bottomSide,
    this.topLeftCornerSide,
    this.topRightCornerSide,
    this.bottomLeftCornerSide,
    this.bottomRightCornerSide,
    this.borderRadius: BorderRadius.zero,
  }) : assert(borderRadius != null);

  /// The style for the left side border.
  final BorderSide? leftSide;

  /// The style for the right side border.
  final BorderSide? rightSide;

  /// The style for the top side border.
  final BorderSide? topSide;

  /// The style for the bottom side border.
  final BorderSide? bottomSide;

  /// The style for the top left corner side border.
  final BorderSide? topLeftCornerSide;

  /// The style for the top right corner side border.
  final BorderSide? topRightCornerSide;

  /// The style for the bottom left corner side border.
  final BorderSide? bottomLeftCornerSide;

  /// The style for the bottom right corner side border.
  final BorderSide? bottomRightCornerSide;

  double get biggestWidth => max(
      max(
          max(
              max(
                  max(
                      max(max(topSide?.width ?? 0.0, rightSide?.width ?? 0.0),
                          bottomSide?.width ?? 0.0),
                      leftSide?.width ?? 0.0),
                  bottomRightCornerSide?.width ?? 0.0),
              bottomLeftCornerSide?.width ?? 0.0),
          topRightCornerSide?.width ?? 0.0),
      topLeftCornerSide?.width ?? 0.0);

  /// The radii for each corner.
  final BorderRadius borderRadius;

  @override
  EdgeInsetsGeometry get dimensions {
    return new EdgeInsets.all(biggestWidth);
  }

  @override
  ShapeBorder scale(double t) {
    return new CustomRoundedRectangleBorder(
      topSide: topSide?.scale(t),
      leftSide: leftSide?.scale(t),
      bottomSide: bottomSide?.scale(t),
      rightSide: bottomSide?.scale(t),
      topLeftCornerSide: topLeftCornerSide?.scale(t),
      topRightCornerSide: topRightCornerSide?.scale(t),
      bottomLeftCornerSide: bottomLeftCornerSide?.scale(t),
      bottomRightCornerSide: bottomRightCornerSide?.scale(t),
      borderRadius: borderRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    assert(t != null);
    if (a is CustomRoundedRectangleBorder) {
      return new CustomRoundedRectangleBorder(
        topSide:
            topSide == null ? null : BorderSide.lerp(a.topSide!, topSide!, t),
        leftSide: leftSide == null
            ? null
            : BorderSide.lerp(a.leftSide!, leftSide!, t),
        bottomSide: bottomSide == null
            ? null
            : BorderSide.lerp(a.bottomSide!, bottomSide!, t),
        rightSide: rightSide == null
            ? null
            : BorderSide.lerp(a.rightSide!, rightSide!, t),
        topLeftCornerSide: topLeftCornerSide == null
            ? null
            : BorderSide.lerp(a.topLeftCornerSide!, topLeftCornerSide!, t),
        topRightCornerSide: topRightCornerSide == null
            ? null
            : BorderSide.lerp(a.topRightCornerSide!, topRightCornerSide!, t),
        bottomLeftCornerSide: bottomLeftCornerSide == null
            ? null
            : BorderSide.lerp(
                a.bottomLeftCornerSide!, bottomLeftCornerSide!, t),
        bottomRightCornerSide: bottomRightCornerSide == null
            ? null
            : BorderSide.lerp(
                a.bottomRightCornerSide!, bottomRightCornerSide!, t),
        borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    assert(t != null);
    if (b is CustomRoundedRectangleBorder) {
      return new CustomRoundedRectangleBorder(
        topSide:
            topSide == null ? null : BorderSide.lerp(topSide!, b.topSide!, t),
        leftSide: leftSide == null
            ? null
            : BorderSide.lerp(leftSide!, b.leftSide!, t),
        bottomSide: bottomSide == null
            ? null
            : BorderSide.lerp(bottomSide!, b.bottomSide!, t),
        rightSide: rightSide == null
            ? null
            : BorderSide.lerp(rightSide!, b.rightSide!, t),
        topLeftCornerSide: topLeftCornerSide == null
            ? null
            : BorderSide.lerp(topLeftCornerSide!, b.topLeftCornerSide!, t),
        topRightCornerSide: topRightCornerSide == null
            ? null
            : BorderSide.lerp(topRightCornerSide!, b.topRightCornerSide!, t),
        bottomLeftCornerSide: bottomLeftCornerSide == null
            ? null
            : BorderSide.lerp(
                bottomLeftCornerSide!, b.bottomLeftCornerSide!, t),
        bottomRightCornerSide: bottomRightCornerSide == null
            ? null
            : BorderSide.lerp(
                bottomRightCornerSide!, b.bottomRightCornerSide!, t),
        borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return new Path()
      ..addRRect(borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(biggestWidth));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return new Path()
      ..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint? paint;

    paint = createPaintForBorder(topLeftCornerSide);
    if (borderRadius.topLeft.x != 0.0 && paint != null) {
      canvas.drawArc(
        rectForCorner(
            topLeftCornerSide?.width, rect.topLeft, borderRadius.topLeft, 1, 1),
        pi / 2 * 2,
        pi / 2,
        false,
        paint,
      );
    }

    paint = createPaintForBorder(topSide);
    if (paint != null) {
      canvas.drawLine(
          rect.topLeft +
              new Offset(
                  borderRadius.topLeft.x +
                      (borderRadius.topLeft.x == 0
                          ? (leftSide?.width ?? 0.0)
                          : 0.0),
                  (topSide?.width ?? 0.0) / 2),
          rect.topRight +
              new Offset(-borderRadius.topRight.x, (topSide?.width ?? 0.0) / 2),
          paint);
    }

    paint = createPaintForBorder(topRightCornerSide);
    if (borderRadius.topRight.x != 0.0 && paint != null) {
      canvas.drawArc(
        rectForCorner(topRightCornerSide?.width, rect.topRight,
            borderRadius.topRight, -1, 1),
        pi / 2 * 3,
        pi / 2,
        false,
        paint,
      );
    }

    paint = createPaintForBorder(rightSide);
    if (paint != null) {
      canvas.drawLine(
          rect.topRight +
              new Offset(
                  -1 * (rightSide?.width ?? 0.0) / 2,
                  borderRadius.topRight.y +
                      (borderRadius.topRight.x == 0
                          ? (topSide?.width ?? 0.0)
                          : 0.0)),
          rect.bottomRight +
              new Offset(-1 * (rightSide?.width ?? 0.0) / 2,
                  -borderRadius.bottomRight.y),
          paint);
    }

    paint = createPaintForBorder(bottomRightCornerSide);
    if (borderRadius.bottomRight.x != 0.0 && paint != null) {
      canvas.drawArc(
        rectForCorner(bottomRightCornerSide?.width, rect.bottomRight,
            borderRadius.bottomRight, -1, -1),
        pi / 2 * 0,
        pi / 2,
        false,
        paint,
      );
    }

    paint = createPaintForBorder(bottomSide);
    if (paint != null) {
      canvas.drawLine(
          rect.bottomRight +
              new Offset(
                  -borderRadius.bottomRight.x -
                      (borderRadius.bottomRight.x == 0
                          ? (rightSide?.width ?? 0.0)
                          : 0.0),
                  -1 * (bottomSide?.width ?? 0.0) / 2),
          rect.bottomLeft +
              new Offset(borderRadius.bottomLeft.x,
                  -1 * (bottomSide?.width ?? 0.0) / 2),
          paint);
    }

    paint = createPaintForBorder(bottomLeftCornerSide);
    if (borderRadius.bottomLeft.x != 0.0 && paint != null) {
      canvas.drawArc(
        rectForCorner(bottomLeftCornerSide?.width, rect.bottomLeft,
            borderRadius.bottomLeft, 1, -1),
        pi / 2 * 1,
        pi / 2,
        false,
        paint,
      );
    }

    paint = createPaintForBorder(leftSide);
    if (paint != null) {
      canvas.drawLine(
          rect.bottomLeft +
              new Offset(
                  (leftSide?.width ?? 0.0) / 2,
                  -borderRadius.bottomLeft.y -
                      (borderRadius.bottomLeft.x == 0
                          ? (bottomSide?.width ?? 0.0)
                          : 0.0)),
          rect.topLeft +
              new Offset((leftSide?.width ?? 0.0) / 2, borderRadius.topLeft.y),
          paint);
    }
  }

  Rect rectForCorner(
      double? sideWidth, Offset offset, Radius radius, num signX, num signY) {
    if (sideWidth == null) sideWidth = 0.0;
    double d = sideWidth / 2;
    double borderRadiusX = radius.x - d;
    double borderRadiusY = radius.y - d;
    Rect rect = Rect.fromPoints(
        offset + Offset(signX.sign * d, signY.sign * d),
        offset +
            Offset(signX.sign * d, signY.sign * d) +
            Offset(signX.sign * 2 * borderRadiusX,
                signY.sign * 2 * borderRadiusY));

    return rect;
  }

  Paint? createPaintForBorder(BorderSide? side) {
    if (side == null) return null;

    return new Paint()
      ..style = PaintingStyle.stroke
      ..color = side.color
      ..strokeWidth = side.width;
  }
}
