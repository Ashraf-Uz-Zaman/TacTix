import 'package:equatable/equatable.dart';
import '../entities/player.dart';

// Represents the 8 possible winning lines
enum WinningLineType {
  row1, row2, row3,
  col1, col2, col3,
  diag1, diag2
}

class GameResult extends Equatable {
  final Player? winner;
  final WinningLineType? lineType;

  const GameResult({this.winner, this.lineType});

  // A 'no result' constant
  static const noResult = GameResult();

  @override
  List<Object?> get props => [winner, lineType];
}