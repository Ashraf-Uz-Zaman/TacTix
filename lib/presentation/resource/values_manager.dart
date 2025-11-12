import 'package:injectable/injectable.dart';
import 'package:tactix/core/locator/injection.dart';


const double _baseWidth = 390.0;

@lazySingleton
class AppMetrics {
  final NavigationService _navigationService;

  AppMetrics(this._navigationService);

  double get _width => _navigationService.width ?? _baseWidth;

  double get _scale => _width / _baseWidth;


  // Replaces AppPadding
  double get p8 => 8.0 * _scale;
  double get p12 => 12.0 * _scale;
  double get p16 => 16.0 * _scale;
  double get p20 => 20.0 * _scale;
  double get p30 => 30.0 * _scale;
  double get p40 => 40.0 * _scale;

  // Replaces AppSize
  double get s10 => 10.0 * _scale;
  double get s24 => 24.0 * _scale;
  double get s28 => 28.0 * _scale;
  double get s36 => 36.0 * _scale;
  double get s60 => 60.0 * _scale;
  double get s70 => 70.0 * _scale;
  double get s320 => 320.0 * _scale;
  double get s400 => 400.0 * _scale;

  // Replaces AppSpacing
  double get v10 => 10.0 * _scale;
  double get v20 => 20.0 * _scale;
  double get v30 => 30.0 * _scale;

  // Replaces AppRadius
  double get r4 => 4 * _scale;
  double get r8 => 8 * _scale;
  double get r12 => 12 * _scale;
  double get r16 => 16 * _scale;

  // Replaces AppFontSize
  double get f12 => 12.0 * _scale;
  double get f14 => 14.0 * _scale;
  double get f16 => 16.0 * _scale;
  double get f18 => 18.0 * _scale;
  double get f20 => 20.0 * _scale;
  double get f22 => 22.0 * _scale;
  double get f28 => 28.0 * _scale;
  double get f40 => 40.0 * _scale;


}


class AppDuration {
  static const int d300 = 300;
  static const int d500 = 500;
}