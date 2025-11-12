import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async => init(getIt);

@lazySingleton
class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get currentContext => navigatorKey.currentContext;


  Size? get screenSize {
    if (currentContext != null) {
      return MediaQuery.of(currentContext!).size;
    }
    return null;
  }

  double? get width => screenSize?.width;
  double? get height => screenSize?.height;
}