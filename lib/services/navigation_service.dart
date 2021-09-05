import 'package:event_app/constants/key_constants.dart';
import 'package:event_app/screens/event_details_page.dart';
import 'package:event_app/screens/home_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final _allRoutes = <String, Function(RouteSettings settings)>{
    HomePage.routeName: (setting) => HomePage(),
    EventDetailsPage.routeName: (setting) => EventDetailsPage(setting.arguments as EventDetailsPageArgs),
  };

  Route onGenerateRoute(RouteSettings settings) {
    final _builder = _allRoutes[settings.name!];

    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => _builder!(settings),
    );
  }
}

Future<T?> pushNamed<T extends Object?>(
  String routeName, {
  Object? arguments,
}) {
  return Keys.navKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
}

Future<T?> popAndPushNamed<T extends Object?>(String routeName, {Object? arguments}) async {
  pop();
  return pushNamed(routeName, arguments: arguments);
}

Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
  String routeName,
  RoutePredicate predicate, {
  Object? arguments,
}) {
  return Keys.navKey.currentState!.pushNamedAndRemoveUntil<T>(
    routeName,
    predicate,
    arguments: arguments,
  );
}

Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
  String routeName, {
  TO? result,
  Object? arguments,
}) {
  return Keys.navKey.currentState!.pushReplacementNamed<T, TO>(
    routeName,
    result: result,
    arguments: arguments,
  );
}

void pop<T extends Object?>([T? data]) {
  return Keys.navKey.currentState!.pop<T>(data);
}

void popUntil(bool Function(Route<dynamic>) predicate) {
  return Keys.navKey.currentState!.popUntil(predicate);
}

void popUntilRouteName(String routeName) {
  return Keys.navKey.currentState!.popUntil(
    ModalRoute.withName(routeName),
  );
}
