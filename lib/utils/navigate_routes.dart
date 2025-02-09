

import 'package:demo/ui/home_page/add_employee/add_employee_page.dart';
import 'package:demo/ui/home_page/home_page.dart';
import 'package:flutter/material.dart';

/// Class that holds both route names & generate methods.
/// Used by the Flutter routing system
class Routes {
  static get args => null;

  /// Methods that generate all routes
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      final Object? args = routeSettings.arguments;
      switch (routeSettings.name) {
        // LOGIN
        case HomePage.routeName:
          return MaterialPageRoute(
              builder: (_) => const HomePage(),
              settings: RouteSettings(
                  name: HomePage.routeName,
                  arguments: routeSettings.arguments));

          case AddEmployeePage.routeName:
          return MaterialPageRoute(
              builder: (_) =>  AddEmployeePage(),
              settings: RouteSettings(
                  name: AddEmployeePage.routeName,
                  arguments: routeSettings.arguments));

        default:
          return errorRoute(routeSettings);
      }
    } catch (_) {
      return errorRoute(routeSettings);
    }
  }

  /// Method that calls the error screen when necessary
  static Route<dynamic> errorRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      settings: RouteSettings(
          name: HomePage.routeName, arguments: routeSettings.arguments),
      builder: (_) => const HomePage(),
    );
  }
}
