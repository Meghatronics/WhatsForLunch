import 'package:get_it/get_it.dart';

import 'base/view_model_base_classes/session_manager.dart';

// import 'package:location/location.dart' as location;
final locator = GetIt.instance;

class AppDependencies {
  static Future<void> reset() async {
    locator.reset();
    await register();
  }

  static Future<void> register() async {
   
  
  }

  /// _______
  /// __________________________________________________________________________
}
