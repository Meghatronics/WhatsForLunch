import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../base/data_base_classes/base_datasource.dart';
import '../../../base/view_base_classes/base_page_builder.dart';
import '../../../base/view_base_classes/style/style.dart';
import '../../../base/view_base_classes/widgets/custom_dot_widget.dart';
import '../../../base/view_base_classes/widgets/simple_text.dart';
import '../data/recipe_datasource.dart';
import '../view_models/recipes_view_model.dart';
import '../widgets/edit_recipe_button.dart';
import '../widgets/recipe_card.dart';
import '../widgets/recipe_description_text.dart';

class SeeRecipesView extends StatelessWidget {
  const SeeRecipesView({
    Key key,
    @required this.ingredientsForSearch,
    @required this.dateDescription,
  }) : super(key: key);
  final List<String> ingredientsForSearch;
  final String dateDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 560,
          maxHeight: MediaQuery.of(context).size.height.clamp(
                560.0,
                double.infinity,
              ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 2 * kToolbarHeight, 16, 0),
          child: Column(
            children: [
              Row(
                children: [
                  const CustomDot(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Recipes',
                      style: GoogleFonts.quicksand(
                        color: textBlackColor,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  SizedBox(width: 40),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RecipeDescriptionText(
                      ingredients: ingredientsForSearch,
                      dateDescription: dateDescription,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const EditRecipeButton(),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BaseViewBuilder<RecipesViewModel>(
                  initState: (recipesViewModel) {
                    recipesViewModel.getRecipes(ingredientsForSearch);
                  },
                  model: RecipesViewModel(
                      datasource:
                          RecipeDatasourceV1(baseDatasource: BaseDatasource())),
                  builder: (recipesViewModel, _) => StateBasedWidget(
                    state: recipesViewModel.viewState,
                    successWidget: recipesViewModel.myRecipes.isEmpty
                        ? Align(
                            alignment: const Alignment(0, -0.3),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SimpleText(
                                  'Uh-oh!',
                                  size: 32,
                                  color: strokeBrownColor,
                                  weight: FontWeight.w500,
                                  align: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                const SimpleText(
                                  'We cannot suggest any recipes '
                                  'from those items',
                                  size: 16,
                                  color: darkGreenColor,
                                  align: TextAlign.center,
                                )
                              ],
                            ))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: recipesViewModel.myRecipes.length,
                            itemBuilder: (_, index) => RecipeCard(
                              recipe: recipesViewModel.myRecipes[index],
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
