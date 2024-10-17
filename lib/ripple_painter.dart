import 'package:flutter/material.dart';

///class to create the ripple
class RipplePainter extends CustomPainter{
  /// tapPoints: the point where the user tapped
  final List<Offset> tapPoints;
  /// rippleRadius: the radius of the ripple created
  final List<double> rippleRadius;
  /// rippleOpacity: the opacity of the ripple created
  final List<double> rippleOpacity;
  /// _rippleColor: the random color of the ripple
  final Color _rippleColor;

  ///
  RipplePainter(this.tapPoints,
      this.rippleRadius, this.rippleOpacity, this._rippleColor,);

  @override
  void paint(Canvas canvas, Size size){
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke // stroke style for ripple effect
      ..strokeWidth = 3.0;

    for (int i =0; i< tapPoints.length; i++){
      paint.color = _rippleColor.withOpacity(rippleOpacity[i]);
      canvas.drawCircle(tapPoints[i], rippleRadius[i], paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}
