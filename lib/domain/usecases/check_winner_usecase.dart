import 'package:injectable/injectable.dart';
import '../entities/game_result.dart';
import '../entities/player.dart';

@lazySingleton
class CheckWinnerUseCase {
  // --- Define the lines and their types ---
  static const Map<WinningLineType, List<int>> _lines = {
    WinningLineType.row1: [0, 1, 2],
    WinningLineType.row2: [3, 4, 5],
    WinningLineType.row3: [6, 7, 8],
    WinningLineType.col1: [0, 3, 6],
    WinningLineType.col2: [1, 4, 7],
    WinningLineType.col3: [2, 5, 8],
    WinningLineType.diag1: [0, 4, 8],
    WinningLineType.diag2: [2, 4, 6],
  };

  /// Checks the board and returns a GameResult (winner and line).
  GameResult call(List<Player> board) {
    for (final entry in _lines.entries) {
      final lineType = entry.key;
      final line = entry.value;

      final p1 = board[line[0]];
      final p2 = board[line[1]];
      final p3 = board[line[2]];

      if (p1 != Player.none && p1 == p2 && p1 == p3) {
        return GameResult(winner: p1, lineType: lineType);
      }
    }
    return GameResult.noResult;
  }
}