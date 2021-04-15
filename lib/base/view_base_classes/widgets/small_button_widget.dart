import 'package:flutter/material.dart';

import '../style/style.dart';
import 'simple_text.dart';

class SmallButton extends StatelessWidget {
  final Function() onPressed;
  final String label;
  final Color fillColor;
  final Color textColor;
  final bool constrainWidth;

  const SmallButton({
    Key key,
    @required this.onPressed,
    @required this.label,
    this.fillColor,
    this.textColor,
    this.constrainWidth = true,
  }) : super(key: key);

  factory SmallButton.light({
    @required Function() onPressed,
    @required String label,
    bool constrainWidth = true,
  }) {
    return SmallButton(
      onPressed: onPressed,
      label: label,
      fillColor: const Color(0xFFFFEFEF),
      textColor: themePrimaryColor,
      constrainWidth: constrainWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      fillColor: fillColor ?? themePrimaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      constraints: BoxConstraints.tightFor(
        height: 40,
        width: constrainWidth ? 96 : null,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: FittedBox(
        child: SimpleText(
          '$label',
          size: 14,
          weight: FontWeight.w400,
          color: textColor ?? textWhite,
        ),
      ),
    );
  }
}
