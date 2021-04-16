import 'package:flutter/material.dart';

import '../style/style.dart';

class CustomDot extends StatelessWidget {
  final double size;
  const CustomDot({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 16,
      width: size ?? 16,
      decoration: BoxDecoration(
          color: darkGreenColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: strokeBrownColor,
          )),
    );
  }
}
