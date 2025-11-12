import 'package:injectable/injectable.dart';
import '../entities/player.dart';

@lazySingleton
class MakeMoveUseCase {
  /// Returns a *new* board list with the move applied.
  List<Player> call(List<Player> board, int index, Player player) {
    final newList = List<Player>.from(board);
    newList[index] = player;
    return newList;
  }
}