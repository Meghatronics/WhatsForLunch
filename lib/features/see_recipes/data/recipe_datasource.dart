import 'package:meta/meta.dart';

import '../../../base/data_base_classes/api_response.dart';
import '../../../base/data_base_classes/base_datasource.dart';
import '../models/recipe_model.dart';

abstract class RecipeDatasource {
  Future<ApiResponse<List<RecipeModel>>> recipesForIngredients(
    List<String> ingredients,
  );
}

class RecipeDatasourceV1 implements RecipeDatasource {
  final BaseDatasource baseDatasource;

  RecipeDatasourceV1({@required this.baseDatasource});

  @override
  Future<ApiResponse<List<RecipeModel>>> recipesForIngredients(
      List<String> ingredients) async {
    final endpoint = '/recipes?ingredients=${ingredients.join(',')}';
    final apiResponse = await baseDatasource.sendGet(endpoint: endpoint);
    final response = apiResponse.transform(
      (data) {
        final jsonList = data['data'] as List;
        final recipes =
            jsonList.map((json) => RecipeModel.fromJson(json)).toList();
        return recipes;
      },
    );
    return response;
  }
}
