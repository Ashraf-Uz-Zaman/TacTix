import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tactix/application/app.dart';


import 'core/locator/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await configureDependencies();
  runApp(const MyApp());
}