part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
  @override
  List<Object> get props => [];
}

class ChangeGameMode extends GameEvent {
  final GameMode mode;
  const ChangeGameMode(this.mode);
  @override
  List<Object> get props => [mode];
}

class MakeMove extends GameEvent {
  final int index;
  const MakeMove(this.index);
  @override
  List<Object> get props => [index];
}

class ResetGame extends GameEvent {
  const ResetGame();
}

class _AiMoveMade extends GameEvent {
  final int index;
  const _AiMoveMade(this.index);
  @override
  List<Object> get props => [index];
}