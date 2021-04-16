import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tech_task/base/data_base_classes/api_response.dart';
import 'package:tech_task/base/data_base_classes/data_base_classes.dart';
import 'package:tech_task/base/view_model_base_classes/base_view_model.dart';
import 'package:tech_task/features/see_fridge_ingredients/data/fridge_ingredients_datasource.dart';
import 'package:tech_task/features/see_fridge_ingredients/models/ingredient_model.dart';
import 'package:tech_task/features/see_fridge_ingredients/view_models/fridge_view_model.dart';

class MockDatasource extends Mock implements FridgeIngredientsDatasource {}

void main() {
  final ingredientsListResponse = ApiResponse(
    data: List.generate(
        3,
        (index) => IngredientModel.fromJson({
              'title': '$index',
              'use-by': '2021-04-0$index',
            })),
  );

  final randomTestDate = DateTime(2020);
  final mockDatasource = MockDatasource();
  group('FridgeViewModel', () {
    when(mockDatasource.fridgeIngredients()).thenAnswer(
      (_) => Future.value(ingredientsListResponse),
    );
    final fridgeViewModel = FridgeViewModel(datasource: mockDatasource);
    group('On start', () {
      test('date is today', () {
        final date = fridgeViewModel.date;
        final dateDescription = fridgeViewModel.dateDescription;
        final showDateText = fridgeViewModel.showDateText;
        final today = DateTime.now();
        final dateIsToday = date.day == today.day &&
            date.month == today.month &&
            date.year == today.year;
        expect(dateIsToday, isTrue);
        expect(dateDescription, 'Today');
        expect(showDateText, false);
      });
    });
    group('On change date', () {
      test('date and date components change appropriately', () {
        fridgeViewModel.lunchDate = randomTestDate;
        final date = fridgeViewModel.date;
        final dateDescription = fridgeViewModel.dateDescription;
        final showDateText = fridgeViewModel.showDateText;

        expect(date, randomTestDate);
        expect(dateDescription,
            fridgeViewModel.makeDateDescription(randomTestDate));
        expect(showDateText, true);
      });
    });
    test('list of ingredients correct', () {
      final date = fridgeViewModel.date;
      final viewState = fridgeViewModel.viewState;
      final fridgeContent = fridgeViewModel.fridgeContent;

      final testCondition = viewState != ViewState.busy &&
          viewState != ViewState.error &&
          fridgeContent != null &&
          fridgeContent.availableIngredients
              .where((ingredient) => ingredient.finishedBy.isBefore(date))
              .isEmpty;

      expect(testCondition, isTrue);
    });
  });
}
