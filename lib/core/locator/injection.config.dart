// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repositories/repository_impl.dart' as _i64;
import '../../domain/repositories/repository.dart' as _i735;
import '../../domain/usecases/check_winner_usecase.dart' as _i454;
import '../../domain/usecases/make_move_usecase.dart' as _i681;
import '../../presentation/bloc/game_bloc.dart' as _i229;
import '../../presentation/resource/values_manager.dart' as _i565;
import 'injection.dart' as _i464;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i464.NavigationService>(() => _i464.NavigationService());
  gh.lazySingleton<_i454.CheckWinnerUseCase>(() => _i454.CheckWinnerUseCase());
  gh.lazySingleton<_i681.MakeMoveUseCase>(() => _i681.MakeMoveUseCase());
  gh.lazySingleton<_i565.AppMetrics>(
    () => _i565.AppMetrics(gh<_i464.NavigationService>()),
  );
  gh.lazySingleton<_i735.Repository>(() => _i64.AiRepositoryImpl());
  gh.factory<_i229.GameBloc>(
    () => _i229.GameBloc(
      gh<_i681.MakeMoveUseCase>(),
      gh<_i454.CheckWinnerUseCase>(),
      gh<_i735.Repository>(),
    ),
  );
  return getIt;
}
