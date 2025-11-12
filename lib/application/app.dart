import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix/core/locator/injection.dart';
import 'package:tactix/presentation/bloc/game_bloc.dart';
import 'package:tactix/presentation/resource/routes_manager.dart';
import 'package:tactix/presentation/resource/strings_manager.dart';
import 'package:tactix/presentation/resource/theme_manager.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // You can get your services from getIt right here
    final navigationService = getIt<NavigationService>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GameBloc>(),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigationService.navigatorKey,
        theme: ThemeManager.lightTheme,
        darkTheme: ThemeManager.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }
}