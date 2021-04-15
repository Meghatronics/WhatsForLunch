import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_routing/app_navigator.dart';
import 'app_routing/app_router.dart';
import 'base/view_base_classes/style/style.dart';
import 'utilities/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TechTask());
}

class TechTask extends StatelessWidget {
  const TechTask({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      //? ROUTING PARAMS
      navigatorKey: AppNavigator.key,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: welcomeViewRoute,
      //? THEMING
      theme: ThemeData(
        primaryColor: darkGreenColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        splashColor: strokeBrownColor.withOpacity(0.7),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: backgroundGreenColor,
          selectionColor: textBrownColor.withOpacity(0.35),
          selectionHandleColor: textBrownColor,
        ),
        textTheme: GoogleFonts.montserratTextTheme(),
        dividerColor: strokeBrownColor,
      ),
    );
  }
}
