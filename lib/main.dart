import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_routing/app_navigator.dart';
import 'app_routing/app_router.dart';
import 'base/view_base_classes/style/style.dart';
import 'utilities/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TechTask());
}

class TechTask extends StatelessWidget {
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
        primaryColor: themePrimaryColor,
        scaffoldBackgroundColor: backgroundWhite,
        splashColor: themeTextGrey.withOpacity(0.5),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: themeTextBodyColor,
          selectionColor: themePrimaryColor.withOpacity(0.35),
          selectionHandleColor: themeTextHeaderColor,
        ),
        textTheme: GoogleFonts.muliTextTheme(),
        dividerColor: const Color(0xFFECEBEB),
      ),
    );
  }
}
