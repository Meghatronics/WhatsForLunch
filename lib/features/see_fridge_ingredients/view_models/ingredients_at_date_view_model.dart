import 'package:meta/meta.dart';

import '../../../base/view_model_base_classes/base_view_model.dart';
import '../models/ingredient_model.dart';

class IngredientsAtDateViewModel extends BaseViewModel {
  IngredientsAtDateViewModel({
    @required DateTime date,
    @required List<IngredientModel> allIngredients,
  }) {
    filterAvailableIngredients(
      date: date,
      allIngredients: allIngredients,
    );
  }

  final _selectedIngredients = <IngredientModel>[];
  final _availableIngredients = <IngredientModel>[];
  List<IngredientModel> get availableIngredients =>
      List.from(_availableIngredients);
  List<IngredientModel> get selectedIngredients =>
      List.from(_selectedIngredients);

  bool isSelected(IngredientModel ingredient) =>
      _selectedIngredients.contains(ingredient);

  void toggleIngredientSelection(IngredientModel ingredient) {
    isSelected(ingredient)
        ? _selectedIngredients.remove(ingredient)
        : _selectedIngredients.add(ingredient);
    setState();
  }

  void filterAvailableIngredients({
    @required DateTime date,
    @required List<IngredientModel> allIngredients,
  }) async {
    setState(viewState: ViewState.busy);
    final availableIngredients = allIngredients
        .where((ingredient) => date.isBefore(ingredient.finishedBy))
        .toList();
    _availableIngredients.addAll(availableIngredients);
    setState(viewState: ViewState.done);
  }
}
