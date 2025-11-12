import '../entities/player.dart';

abstract class Repository {
  /// Takes the current board state and returns the AI's chosen move (index).
  Future<int> getAiMove(List<Player> currentBoard);
}