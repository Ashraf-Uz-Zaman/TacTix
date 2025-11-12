import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tactix/presentation/resource/assets_manager.dart';
import 'package:tactix/presentation/resource/color_manager.dart';
import 'package:tactix/presentation/resource/routes_manager.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {

  Timer? _timer;

  void _initData() async{

  }

  _startDelay(){
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }
  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.gameRoute) ;
  }

  @override
  void initState() {
    super.initState();
    _initData();
    _startDelay();

  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
        backgroundColor: ColorManager.lightSecondary,
        body:   Center(child: Image(image: AssetImage(ImageAssets.splashLogo),),)


    );
  }
}