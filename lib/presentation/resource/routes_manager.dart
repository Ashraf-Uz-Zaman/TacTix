import 'package:flutter/material.dart';
import 'package:tactix/presentation/pages/game/game_page.dart';
import 'package:tactix/presentation/pages/splash/splash_page.dart';
import 'package:tactix/presentation/resource/strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String gameRoute = "/game";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case Routes.gameRoute:
        return MaterialPageRoute(builder: (_) => const GamePage());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.noRouteFound),
          ),
          body: Center(child: const Text(AppStrings.noRouteFound)),
        ));
  }
}