import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_task/base/data_base_classes/api_response.dart';
import 'package:tech_task/base/data_base_classes/base_datasource.dart';
import 'package:tech_task/base/data_base_classes/data_base_classes.dart';
import 'package:tech_task/features/see_fridge_ingredients/data/fridge_ingredients_datasource.dart';
import 'package:tech_task/features/see_fridge_ingredients/models/ingredient_model.dart';

class MockBaseDatasource extends Mock implements BaseDatasource {}

void main() {
  group('Fridge Ingredients Datasource', () {
    final mockDatasource = MockBaseDatasource();
    final fridgeIngredientsDatasource =
        FridgeIngredientsDatasourceV1(baseDatasource: mockDatasource);
    group(
      'returns data',
      () {
        when(mockDatasource.sendGet(endpoint: '/ingredients')).thenAnswer(
          (_) => Future.value(
            ApiResponse(
              data: {
                'data': [
                  {
                    'title': 'test',
                    'use-by': '2020-04-07',
                  },
                  {
                    'title': 'test',
                    'use-by': '2020-04-07',
                  },
                  {
                    'title': 'test',
                    'use-by': '2020-04-07',
                  }
                ]
              },
            ),
          ),
        );

        test(
          'returns List of IngredientModel',
          () async {
            final datasourceResponse =
                await fridgeIngredientsDatasource.fridgeIngredients();
            expect(
              datasourceResponse,
              isA<ApiResponse<List<IngredientModel>>>(),
            );
          },
        );
        test(
          'returns all the data from the api',
          () async {
            final apiResponse =
                await mockDatasource.sendGet(endpoint: '/ingredients');
            final datasourceResponse =
                await fridgeIngredientsDatasource.fridgeIngredients();
            expect(
              datasourceResponse.data.length,
              apiResponse.data['data'].length,
            );
          },
        );
      },
    );
    test('returns error', () async {
      when(mockDatasource.sendGet(endpoint: '/ingredients')).thenAnswer(
        (_) => Future.value(
          ApiResponse(
            error: ServerFailure(),
          ),
        ),
      );

      final apiResponse =
          await mockDatasource.sendGet(endpoint: '/ingredients');
      final datasourceResponse =
          await fridgeIngredientsDatasource.fridgeIngredients();
      expect(datasourceResponse.hasError, isTrue);
      expect(
        datasourceResponse.error.runtimeType,
        apiResponse.error.runtimeType,
      );
    });
  });
}
