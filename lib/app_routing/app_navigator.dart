export 'route_names.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();
  static final key = GlobalKey<NavigatorState>();

  static Future push(Widget page) {
    return key.currentState.push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future pushNamed(String route, {arguments}) {
    return key.currentState.pushNamed(route, arguments: arguments);
  }

  static Future pushReplacement(Widget page) {
    return key.currentState.pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future pushNamedReplacement(String route, {arguments}) {
    return key.currentState.pushReplacementNamed(route, arguments: arguments);
  }

  static Future pushAndClear(Widget page) {
    return key.currentState.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  static Future pushNamedAndClear(String route, {arguments}) {
    return key.currentState.pushNamedAndRemoveUntil(
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  static void pop([result]) {
    return key.currentState.pop(result);
  }
}
