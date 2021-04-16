import 'package:get_it/get_it.dart';

import 'base/data_base_classes/data_base_classes.dart';
import 'features/see_fridge_ingredients/data/fridge_ingredients_datasource.dart';
import 'features/see_fridge_ingredients/view_models/fridge_view_model.dart';
import 'features/see_recipes/data/recipe_datasource.dart';
import 'features/see_recipes/view_models/recipes_view_model.dart';

// import 'package:location/location.dart' as location;
final locator = GetIt.instance;

class AppDependencies {
  static Future<void> reset() async {
    locator.reset();
    register();
  }

  static Future<void> register() async {
    _baseDependencies();
    _fridgeDependencies();
    _recipeDependencies();
    await locator.allReady();
  }

  /// __________________________________________________________________________
  static void _baseDependencies() {
    locator.registerLazySingleton<BaseDatasource>(() => BaseDatasource());
  }

  /// __________________________________________________________________________
  static void _fridgeDependencies() {
    locator.registerLazySingleton(() => FridgeViewModel(datasource: locator()));

    locator.registerLazySingleton<FridgeIngredientsDatasource>(
        () => FridgeIngredientsDatasourceV1(
              baseDatasource: locator(),
            ));
  }

  /// __________________________________________________________________________
  static void _recipeDependencies() {
    locator.registerLazySingleton(() => RecipesViewModel(
          datasource: locator(),
        ));

    locator.registerLazySingleton<RecipeDatasource>(() => RecipeDatasourceV1(
          baseDatasource: locator(),
        ));
  }
}
