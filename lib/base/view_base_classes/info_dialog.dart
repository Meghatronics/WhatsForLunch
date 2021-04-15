import 'package:flutter/material.dart';

import 'style/style.dart';
import 'widgets/simple_text.dart';

class InfoDialog extends StatelessWidget {
  final String infoText;
  final TextSpan infoTextSpan;
  final Function() onDismiss;

  const InfoDialog({
    Key key,
    this.infoText = '',
    this.infoTextSpan = const TextSpan(),
    this.onDismiss,
  })  : assert(
          infoText != null && infoTextSpan != null,
          'Provide either text or textspan for info dialog',
        ),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      backgroundColor: backgroundWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SimpleText(
              infoText,
            ),
            // SmallButton(
            //   onTap: onDismiss,
            //   label: 'Okay',
            // ),
          ],
        ),
      ),
    );
  }
}
