import '../../../base/data_base_classes/api_response.dart';
import '../../../base/data_base_classes/base_datasource.dart';
import '../models/ingredient_model.dart';
import 'package:meta/meta.dart';

abstract class FridgeIngredientsDatasource {
  Future<ApiResponse<List<IngredientModel>>> fridgeIngredients();
}

class FridgeIngredientsDatasourceV1 implements FridgeIngredientsDatasource {
  final BaseDatasource baseDatasource;

  FridgeIngredientsDatasourceV1({@required this.baseDatasource});
  @override
  Future<ApiResponse<List<IngredientModel>>> fridgeIngredients() async {
    const endpoint = '/ingredients';
    final apiResponse = await baseDatasource.sendGet(endpoint: endpoint);
    final response = apiResponse.transform(
      (data) {
        final jsonList = data['data'] as List;
        final ingredients = jsonList.map(
          (json) => IngredientModel.fromJson(json),
        );
        return ingredients.toList();
      },
    );
    return response;
  }
}
