import 'package:flutter/cupertino.dart';
import '../../../base/view_base_classes/style/style.dart';

class WelcomeViewBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final halfCircle = Path();
    final paint = Paint()
      ..color = inactiveGreyColor.withOpacity(0.05)
      ..style = PaintingStyle.fill;
    halfCircle.moveTo(w * 1.5, 0);
    halfCircle.arcToPoint(
      Offset(w, h * 0.65),
      radius: Radius.circular(w * 0.5),
      largeArc: true,
      clockwise: false,
    );
    // halfCircle.lineTo(w * 0.4, h * 0.3);
    // halfCircle.lineTo(w, h * 0.6);
    // halfCircle.conicTo(100, 250, 0, 2 * (h / 3), -1);
    // halfCircle.close();
    canvas.drawPath(halfCircle, paint);

    final fullCircle = Path();

    fullCircle.moveTo(w * 0.5, h);
    fullCircle.arcToPoint(
      Offset((w * 0.5) + 1, h),
      radius: Radius.circular(w * 0.45),
      largeArc: true,
    );
    // fullCircle.lineTo(w * 0.7, h * 0.8);
    // fullCircle.lineTo(w * 0.5, h);
    // fullCircle.lineTo(0, h);

    canvas.drawPath(fullCircle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
