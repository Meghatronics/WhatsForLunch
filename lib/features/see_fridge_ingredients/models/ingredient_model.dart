import 'package:meta/meta.dart';

//TODO
class IngredientModel {
  final String name;
  final DateTime finishedBy;

  IngredientModel({
    @required this.name,
    @required this.finishedBy,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        name: json['title'],
        finishedBy: _makeDateFromString(
          json['use-by'],
        ),
      );

  static DateTime _makeDateFromString(String dateString) {
    return DateTime.tryParse(dateString);
  }
}
