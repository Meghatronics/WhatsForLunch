import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_task/base/data_base_classes/api_response.dart';
import 'package:tech_task/base/data_base_classes/base_datasource.dart';
import 'package:tech_task/base/data_base_classes/failures.dart';
import 'package:tech_task/features/see_recipes/data/recipe_datasource.dart';
import 'package:tech_task/features/see_recipes/models/recipe_model.dart';

class MockBaseDatasource extends Mock implements BaseDatasource {}

void main() {
  group('Recipe Datasource', () {
    final mockDatasource = MockBaseDatasource();
    final recipeDatasource = RecipeDatasourceV1(baseDatasource: mockDatasource);
    final mockIngredients = ['Ham', 'Cucumber', 'Tomoto'];
    group(
      'returns data',
      () {
        when(mockDatasource.sendGet(
                endpoint: '/recipes?ingredients=${mockIngredients.join(',')}'))
            .thenAnswer(
          (_) => Future.value(
            ApiResponse(
              data: {
                'data': [
                  {
                    'title': 'Ham and Cheese Toastie',
                    'ingredients': ['Ham', 'Cheese', 'Bread', 'Butter']
                  },
                  {
                    'title': 'Salad',
                    'ingredients': ['Beetroot', 'Salad Dressing']
                  },
                  {
                    'title': 'Hotdog',
                    'ingredients': ['Sausage', 'Ketchup', 'Mustard']
                  }
                ]
              },
            ),
          ),
        );

        test(
          'returns List of RecipeModel',
          () async {
            final datasourceResponse =
                await recipeDatasource.recipesForIngredients(mockIngredients);
            expect(
              datasourceResponse,
              isA<ApiResponse<List<RecipeModel>>>(),
            );
          },
        );
        test(
          'returns all the data from the api',
          () async {
            final apiResponse = await mockDatasource.sendGet(
                endpoint: '/recipes?ingredients=${mockIngredients.join(',')}');
            final datasourceResponse =
                await recipeDatasource.recipesForIngredients(mockIngredients);
            print(apiResponse.data.length);
            print(datasourceResponse.data.length);
            expect(
              datasourceResponse.data.length,
              apiResponse.data['data'].length,
            );
          },
        );
      },
    );
    test('returns error', () async {
      when(mockDatasource.sendGet(
              endpoint: '/recipes?ingredients=${mockIngredients.join(',')}'))
          .thenAnswer(
        (_) => Future.value(
          ApiResponse(
            error: ServerFailure(),
          ),
        ),
      );

      final apiResponse = await mockDatasource.sendGet(
          endpoint: '/recipes?ingredients=${mockIngredients.join(',')}');
      final datasourceResponse =
          await recipeDatasource.recipesForIngredients(mockIngredients);
      expect(datasourceResponse.hasError, isTrue);
      expect(
        datasourceResponse.error.runtimeType,
        apiResponse.error.runtimeType,
      );
    });
  });
}
