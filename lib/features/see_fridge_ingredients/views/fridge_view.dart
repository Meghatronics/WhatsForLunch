import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/recipes_floating_action_button.dart';

import '../../../base/view_base_classes/style/style.dart';
import '../../../base/view_base_classes/widgets/custom_dot_widget.dart';
import '../../../base/view_base_classes/widgets/simple_text.dart';
import '../widgets/ingredient_list_tile.dart';

class FridgeView extends StatelessWidget {
  const FridgeView({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: RecipesFAB(onTap: () {}),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 500,
              maxHeight: MediaQuery.of(context).size.height.clamp(
                    500.0,
                    double.infinity,
                  ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: kToolbarHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    'In the fridge',
                    style: GoogleFonts.quicksand(
                      color: textBrownColor,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      const CustomDot(),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Today',
                          style: GoogleFonts.quicksand(
                            color: textBlackColor,
                            fontSize: 32,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      const SizedBox(width: 40),
                      InkWell(
                        onTap: () async {
                          final today = DateTime.now();
                          final dateSelected = await showDatePicker(
                            context: context,
                            initialDate: today,
                            firstDate: today,
                            lastDate: today.add(const Duration(days: 14)),
                          );
                          print('${dateSelected?.toIso8601String()}');
                        },
                        child: const Text(
                          'Check for another day',
                          style: TextStyle(
                            color: Color(0xFFB2B2B2),
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SimpleText(
                    '20-04-2021',
                    color: textBrownColor,
                    size: 12,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 24,
                      bottom: 16,
                      right: 56,
                    ),
                    child: SimpleText(
                      'Select some stuff, '
                      'let’s tell you what you could make with ‘em',
                      color: textGreyColor,
                      size: 16,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return IngredientListTile(
                          ingredient: 'Ham',
                          selected: Random().nextBool(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
