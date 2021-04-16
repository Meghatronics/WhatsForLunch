import 'package:flutter/material.dart';

import '../../../base/view_base_classes/style/style.dart';
import '../../../base/view_base_classes/widgets/simple_text.dart';
import '../models/recipe_model.dart';
import 'ingredient_chip.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeCard({
    Key key,
    @required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: backgroundWhiteColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 1,
              color: Color(0x33FFCBAB),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            '${recipe.name}',
            color: textBlackColor,
            size: 16,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              for (String ingredient in recipe.ingredients)
                IngredientChip('$ingredient')
            ],
          )
        ],
      ),
    );
  }
}
