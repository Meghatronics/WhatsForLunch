import 'package:flutter/material.dart';

import '../../../app_routing/app_navigator.dart';
import '../../../base/view_base_classes/style/style.dart';
import '../../../base/view_base_classes/widgets/simple_text.dart';

class EditRecipeButton extends StatelessWidget {
  const EditRecipeButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RawMaterialButton(
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      onPressed: AppNavigator.pop,
      shape: RoundedRectangleBorder(
          side: BorderSide(
        color: textBlackColor,
        width: 0.3,
      )),
      constraints: BoxConstraints.tightForFinite(),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: SimpleText(
        'Edit',
        color: textBlackColor,
        size: 16,
      ),
    );
  }
}
