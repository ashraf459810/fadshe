import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, {String removeUntilName, dynamic arguments}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, (route) {
      if (removeUntilName != null)
        return route.settings.name == removeUntilName;
      else
        return false;
    }, arguments: arguments);
  }

  Future popAndPushNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState.popAndPushNamed(routeName, arguments: arguments);
  }

  void popUntil(String routeName) {
    return navigatorKey.currentState.popUntil((route) {
      print('Processing Route: $routeName == ${route.settings.name} : ${route.settings.name == routeName}');
      return route.settings.name == routeName;
    });
  }

  pop({dynamic argument}) => navigatorKey.currentState.pop(argument);
}
