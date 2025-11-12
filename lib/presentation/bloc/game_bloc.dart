import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tactix/domain/entities/game_mode.dart';
import 'package:tactix/domain/entities/game_result.dart';
import 'package:tactix/domain/entities/player.dart';
import 'package:tactix/domain/repositories/repository.dart';
import 'package:tactix/domain/usecases/check_winner_usecase.dart';
import 'package:tactix/domain/usecases/make_move_usecase.dart';


part 'game_event.dart';
part 'game_state.dart';

@injectable
class GameBloc extends Bloc<GameEvent, GameState> {
  final MakeMoveUseCase _makeMoveUseCase;
  final CheckWinnerUseCase _checkWinnerUseCase;
  final Repository _aiRepository;

  GameBloc(
      this._makeMoveUseCase,
      this._checkWinnerUseCase,
      this. _aiRepository,
      ) : super(GameState.initial()) {
    on<ChangeGameMode>(_onChangeGameMode);
    on<MakeMove>(_onMakeMove);
    on<ResetGame>(_onResetGame);
    on<_AiMoveMade>(_onAiMoveMade);
  }

  bool _isBoardFull(List<Player> board) {
    return board.every((p) => p != Player.none);
  }

  void _onChangeGameMode(ChangeGameMode event, Emitter<GameState> emit) {
    emit(GameState.initial().copyWith(gameMode: event.mode));
  }

  void _onResetGame(ResetGame event, Emitter<GameState> emit) {
    emit(GameState.initial().copyWith(gameMode: state.gameMode));
  }

  Future<void> _onMakeMove(MakeMove event, Emitter<GameState> emit) async {
    if (state.board[event.index] != Player.none ||
        state.winner != null ||
        state.isAiThinking) {
      return;
    }

    final newBoard =
    _makeMoveUseCase(state.board, event.index, state.currentPlayer);
    final GameResult result = _checkWinnerUseCase(newBoard);
    final isDraw = _isBoardFull(newBoard) && result.winner == null;

    if (state.gameMode == GameMode.playerVsPlayer) {
      final nextPlayer = (state.currentPlayer == Player.X) ? Player.O : Player.X;
      emit(state.copyWith(
        board: newBoard,
        currentPlayer: nextPlayer,
        winner: result.winner,
        winningLine: result.lineType,
        isDraw: isDraw,
      ));
    } else {
      emit(state.copyWith(
        board: newBoard,
        currentPlayer: Player.O,
        winner: result.winner,
        winningLine: result.lineType,
        isAiThinking: !isDraw && result.winner == null,
        isDraw: isDraw,
      ));

      if (result.winner != null || isDraw) {
        return;
      }

      try {
        final aiMoveIndex = await _aiRepository.getAiMove(newBoard);
        if (!isClosed) {
          add(_AiMoveMade(aiMoveIndex));
        }
      } catch (e) {
        // print("AI Error: ${e.toString()}");
        if (!isClosed) {
          emit(state.copyWith(isAiThinking: false));
        }
      }
    }
  }

  void _onAiMoveMade(_AiMoveMade event, Emitter<GameState> emit) {
    // Check if move is valid (e.g., if user reset game while AI was thinking)
    if (state.board[event.index] != Player.none) return;

    final aiBoard = _makeMoveUseCase(state.board, event.index, Player.O);
    final GameResult result = _checkWinnerUseCase(aiBoard);
    final isAiDraw = _isBoardFull(aiBoard) && result.winner == null;

    emit(state.copyWith(
      board: aiBoard,
      currentPlayer: Player.X,
      winner: result.winner,
      winningLine: result.lineType,
      isAiThinking: false,
      isDraw: isAiDraw,
    ));
  }
}