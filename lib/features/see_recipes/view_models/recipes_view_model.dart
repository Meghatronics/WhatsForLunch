import 'package:meta/meta.dart';

import '../../../app_routing/app_navigator.dart';
import '../../../base/view_base_classes/app_toast.dart';
import '../../../base/view_model_base_classes/base_view_model.dart';
import '../data/recipe_datasource.dart';
import '../models/recipe_model.dart';

class RecipesViewModel extends BaseViewModel {
  final RecipeDatasource datasource;
  final _applicableRecipes = <RecipeModel>[];

  RecipesViewModel({@required this.datasource});

  List<RecipeModel> get myRecipes => List.from(_applicableRecipes);
  
  Future<void> getRecipes(List<String> ingredients) async {
    if (ingredients == null || ingredients.isEmpty) {
      AppToast.instance.message(null, 'No ingredients selected yet.');
      AppNavigator.pop();
      return;
    }

    setState(viewState: ViewState.busy);
    final recipes = await datasource.recipesForIngredients(ingredients);

    if (recipes.hasError) {
      handleFailure(recipes.error);
    } else {
      _applicableRecipes.clear();
      _applicableRecipes.addAll(recipes.data);
      setState(viewState: ViewState.done);
    }
  }
}
