part of 'game_bloc.dart';

class GameState extends Equatable {
  final GameMode gameMode;
  final List<Player> board;
  final Player currentPlayer;
  final Player? winner;
  final WinningLineType? winningLine;
  final bool isAiThinking;
  final bool isDraw;

  const GameState({
    required this.gameMode,
    required this.board,
    required this.currentPlayer,
    this.winner,
    this.winningLine,
    this.isAiThinking = false,
    this.isDraw = false,
  });

  factory GameState.initial() {
    return  GameState(
      gameMode: GameMode.playerVsAi,
      board: List.filled(9, Player.none),
      currentPlayer: Player.X,
      winner: null,
      winningLine: null,
      isAiThinking: false,
      isDraw: false,
    );
  }

  GameState copyWith({
    GameMode? gameMode,
    List<Player>? board,
    Player? currentPlayer,
    Player? winner,
    WinningLineType? winningLine,
    bool? isAiThinking,
    bool? isDraw,
    bool clearWinner = false,
  }) {
    return GameState(
      gameMode: gameMode ?? this.gameMode,
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      winner: clearWinner ? null : (winner ?? this.winner),
      winningLine: clearWinner ? null : (winningLine ?? this.winningLine),
      isAiThinking: isAiThinking ?? this.isAiThinking,
      isDraw: isDraw ?? this.isDraw,
    );
  }

  @override
  List<Object?> get props => [
    gameMode,
    board,
    currentPlayer,
    winner,
    winningLine,
    isAiThinking,
    isDraw
  ];
}