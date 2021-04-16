import 'package:flutter/material.dart';
import '../../../base/view_base_classes/style/style.dart';
import '../../../base/view_base_classes/widgets/simple_text.dart';

class IngredientChip extends StatelessWidget {
  final String ingredient;
  const IngredientChip(this.ingredient, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: darkGreenColor,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: SimpleText(
        '$ingredient',
        color: textBlackColor,
        size: 12,
        weight: FontWeight.w300,
      ),
    );
  }
}
