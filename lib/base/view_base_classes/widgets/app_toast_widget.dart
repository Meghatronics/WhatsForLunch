import 'package:flutter/material.dart';

import '../style/style.dart';
import 'simple_text.dart';

class AppToastWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String title;
  final String message;

  const AppToastWidget({
    Key key,
    @required this.backgroundColor,
    @required this.textColor,
    @required this.title,
    @required this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            SimpleText(
              '$title',
              size: 20,
              weight: FontWeight.w400,
              color: textWhiteColor,
            ),
            const SizedBox(height: 16),
          ],
          SimpleText(
            '$message',
            color: textColor,
            weight: FontWeight.w500,
            size: 16,
          ),
        ],
      ),
    );
  }
}
