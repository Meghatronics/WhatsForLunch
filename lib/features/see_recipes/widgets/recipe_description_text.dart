import 'package:flutter/material.dart';
import '../../../base/view_base_classes/style/style.dart';

class RecipeDescriptionText extends StatelessWidget {
  final List<String> ingredients;
  final String dateDescription;

  const RecipeDescriptionText({
    Key key,
    @required this.ingredients,
    @required this.dateDescription,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Here's a list of stuff you could eat from ",
        style: GoogleFonts.quicksand(
          color: textGreyColor,
          fontSize: 16,
        ),
        children: [
          for (var i = 0; i < ingredients.length; i++) ...[
            TextSpan(
              text: '${ingredients[i]}',
              style: const TextStyle(color: textBrownColor),
            ),
            if (i != ingredients.length - 2)
              const TextSpan(text: ', ')
            else
              const TextSpan(text: ' and ')
          ],
          TextSpan(
            text: '${dateDescription.toUpperCase()}',
          ),
        ],
      ),
    );
  }
}
