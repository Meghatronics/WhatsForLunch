import 'package:flutter/material.dart';

import '../../../base/view_base_classes/style/style.dart';
import '../../../base/view_base_classes/widgets/simple_text.dart';

class RecipesFAB extends StatelessWidget {
  final VoidCallback onTap;
  const RecipesFAB({
    Key key,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      constraints: const BoxConstraints.tightForFinite(),
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
      fillColor: textBrownColor,
      elevation: 2,
      focusElevation: 0,
      highlightElevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.fastfood,
            color: textWhiteColor,
            size: 24,
          ),
          SizedBox(width: 8),
          SimpleText(
            'Recipes',
            color: textWhiteColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}
