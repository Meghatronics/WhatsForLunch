
import 'package:flutter/material.dart';

import '../../../base/data_base_classes/base_datasource.dart';
import '../../../base/view_base_classes/base_page_builder.dart';
import '../../../base/view_base_classes/style/style.dart';
import '../../../base/view_base_classes/widgets/custom_dot_widget.dart';
import '../../../base/view_base_classes/widgets/simple_text.dart';
import '../data/fridge_ingredients_datasource.dart';
import '../view_models/fridge_view_model.dart';
import '../view_models/ingredients_at_date_view_model.dart';
import '../widgets/ingredient_list_tile.dart';
import '../widgets/recipes_floating_action_button.dart';


class FridgeView extends StatelessWidget {
  const FridgeView({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BaseViewBuilder<FridgeViewModel>(
      model: FridgeViewModel(
        datasource: FridgeIngredientsDatasourceV1(
          baseDatasource: BaseDatasource(),
        ),
      ),
      builder: (fridgeViewModel, _) => Scaffold(
          floatingActionButton: fridgeViewModel.showRecipesButton
              ? RecipesFAB(onTap: fridgeViewModel.seeRecipes)
              : null,
          body: StateBasedWidget(
            state: fridgeViewModel.viewState,
            successWidget: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 560,
                  maxHeight: MediaQuery.of(context).size.height.clamp(
                        560.0,
                        double.infinity,
                      ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: kToolbarHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        'In the fridge',
                        style: GoogleFonts.quicksand(
                          color: textBrownColor,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          const CustomDot(),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              '${fridgeViewModel.dateDescription}',
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
                        children: [
                          const Expanded(child: Divider()),
                          const SizedBox(width: 40),
                          InkWell(
                            onTap: () async {
                              final today = DateTime.now();
                              final dateSelected = await showDatePicker(
                                context: context,
                                initialDate: fridgeViewModel.date,
                                firstDate: DateTime(2019),
                                lastDate: today.add(const Duration(days: 366)),
                                helpText: 'SELECT YOUR LUNCH DATE',
                                fieldHintText: 'Enter your lunch date',
                              );
                              fridgeViewModel.lunchDate = dateSelected;
                            },
                            child: const Text(
                              'Check for another day',
                              style: TextStyle(
                                color: Color(0xFFB2B2B2),
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (fridgeViewModel.showDateText)
                        SimpleText(
                          '${fridgeViewModel.dateText}',
                          color: textBrownColor,
                          size: 12,
                        ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 24,
                          bottom: 16,
                          right: 56,
                        ),
                        child: SimpleText(
                          'Select some stuff, '
                          'let’s tell you what you could make with ‘em',
                          color: textGreyColor,
                          size: 16,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: BaseViewBuilder<IngredientsAtDateViewModel>(
                          model: fridgeViewModel.fridgeContent,
                          builder: (fridge, _) => StateBasedWidget(
                            state: fridge.viewState,
                            successWidget: fridge.availableIngredients.isEmpty
                                ? Center(
                                    child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SimpleText(
                                        'Oops!\nFridge is empty',
                                        size: 32,
                                        color: strokeBrownColor,
                                        weight: FontWeight.w500,
                                        align: TextAlign.center,
                                      ),
                                      const SizedBox(height: 16),
                                      SimpleText(
                                        'Nothing in the fridge '
                                        '${fridgeViewModel.dateDescription}',
                                        size: 16,
                                        color: darkGreenColor,
                                        align: TextAlign.center,
                                      )
                                    ],
                                  ))
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount:
                                        fridge.availableIngredients.length,
                                    itemBuilder: (_, index) {
                                      final ingredient =
                                          fridge.availableIngredients[index];
                                      return IngredientListTile(
                                        ingredient: ingredient,
                                        selected: fridge.isSelected(ingredient),
                                        onTap: fridge.toggleIngredientSelection,
                                      );
                                    },
                                  ),

                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ),
            ),
          )),
    );

  }
}
