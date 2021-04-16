import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../app_routing/app_navigator.dart';
import '../../../base/view_model_base_classes/base_view_model.dart';
import '../data/fridge_ingredients_datasource.dart';
import '../models/ingredient_model.dart';
import 'ingredients_at_date_view_model.dart';

class FridgeViewModel extends BaseViewModel {
  final FridgeIngredientsDatasource datasource;

  FridgeViewModel({@required this.datasource});
  @override
  void initialize() {
    openFridge();
  }

  DateTime get date => _lunchDate;
  String get dateDescription => _dateDescription;
  String get dateText => DateFormat('d-MM-yyyy').format(_lunchDate);
  bool showRecipesButton = false;
  bool get showDateText => _dateDescription != 'Today';

  DateTime _lunchDate = DateTime.now();
  String _dateDescription;
  final _ingredients = <IngredientModel>[];
  IngredientsAtDateViewModel fridgeContent;

  Future<void> openFridge() async {
    await _fetchFridgeIngredients();
    lunchDate = DateTime.now();
  }

  String makeDateDescription(DateTime date) {
    final today = DateTime.now();
    final dateDifference = date.difference(today);
    //daycount days ago
    if (dateDifference.inDays < 0)
      return '${dateDifference.inDays.abs()} days ago';
    //In daycount days
    else if (dateDifference > const Duration(days: (14)))
      return 'In ${dateDifference.inDays} days';
    //Next weekday
    else if (dateDifference > const Duration(days: 7))
      return 'Next ${DAY_STRING[date.weekday]}';
    //Today
    else if (date.day - today.day == 0)
      return 'Today';
    //Tomorrow
    else if (date.day - today.day == 1)
      return 'Tomorrow';
    //Next tomorrow
    else if (date.day - today.day == 2)
      return 'Next Tomorrow';
    else
      return 'This ${DAY_STRING[date.weekday]}';
  }

  void set lunchDate(DateTime date) {
    if (date == null) return;
    _lunchDate = date;
    fridgeContent = IngredientsAtDateViewModel(
      date: _lunchDate,
      allIngredients: _ingredients,
    );
    fridgeContent.addListener(_recipesButtonListener);
    _dateDescription = makeDateDescription(_lunchDate);
    setState();
  }

  Future<void> _fetchFridgeIngredients() async {
    setState(viewState: ViewState.busy);
    final ingredients = await datasource.fridgeIngredients();
    if (ingredients.hasError) {
      handleFailure(ingredients.error);
    } else {
      _ingredients.addAll(ingredients.data);
      setState(viewState: ViewState.done);
    }
  }

  void seeRecipes() {
    AppNavigator.pushNamed(
      recipesViewRoute,
      arguments: fridgeContent.selectedIngredients,
    );
  }

  void _recipesButtonListener() {
    final showTheButton =
        fridgeContent != null && fridgeContent.selectedIngredients.isNotEmpty;
    if (showTheButton != showRecipesButton) {
      showRecipesButton = showTheButton;
      setState();
    }
  }
}

const DAY_STRING = [
  '',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];
