import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:tactix/domain/entities/player.dart';
import 'package:tactix/domain/repositories/repository.dart';


const int _none = 0;
const int _playerX = 1;
const int _playerO = 2;

int? _checkWinner(List<int> board) {
  const lines = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Cols
    [0, 4, 8], [2, 4, 6] // Diagonals
  ];
  for (final line in lines) {
    final p1 = board[line[0]];
    final p2 = board[line[1]];
    final p3 = board[line[2]];
    if (p1 != _none && p1 == p2 && p1 == p3) {
      return p1;
    }
  }
  return null;
}

int? _findCriticalMove(List<int> board, int player) {
  for (int i = 0; i < board.length; i++) {
    if (board[i] == _none) {
      final testBoard = List<int>.from(board);
      testBoard[i] = player;
      if (_checkWinner(testBoard) == player) {
        return i;
      }
    }
  }
  return null;
}

int _findTalentedMove(Map<String, dynamic> params) {
  // Read the simple integer data
  final List<int> board = params['board'];
  final int aiPlayer = params['aiPlayer'];
  final int humanPlayer = params['humanPlayer'];

  // --- Priority 1: Check for a winning move ---
  int? winningMove = _findCriticalMove(board, aiPlayer);
  if (winningMove != null) {
    return winningMove;
  }

  // --- Priority 2: Check for a blocking move ---
  int? blockingMove = _findCriticalMove(board, humanPlayer);
  if (blockingMove != null) {
    return blockingMove;
  }

  // --- Priority 3: Take the center ---
  if (board[4] == _none) {
    return 4;
  }

  // --- Priority 4: Take an empty corner ---
  final corners = [0, 2, 6, 8];
  final emptyCorners = <int>[];
  for (final index in corners) {
    if (board[index] == _none) {
      emptyCorners.add(index);
    }
  }
  if (emptyCorners.isNotEmpty) {
    return emptyCorners[Random().nextInt(emptyCorners.length)];
  }

  // --- Priority 5: Take any random empty spot ---
  final emptySpots = <int>[];
  for (int i = 0; i < board.length; i++) {
    if (board[i] == _none) {
      emptySpots.add(i);
    }
  }
  if (emptySpots.isNotEmpty) {
    return emptySpots[Random().nextInt(emptySpots.length)];
  }

  return 0;
}

// --- Implementation of the Repository ---

@LazySingleton(as: Repository)
class AiRepositoryImpl implements Repository {
  @override
  Future<int> getAiMove(List<Player> currentBoard) async {
    // Simulate thinking time
    await Future.delayed(const Duration(milliseconds: 400));

    final List<int> boardAsInts =
    currentBoard.map((player) => player.index).toList();

    final int bestMove = await compute(_findTalentedMove, {
      'board': boardAsInts,   // Pass List<int>
      'aiPlayer': _playerO,     // Pass 2
      'humanPlayer': _playerX,  // Pass 1
    });

    return bestMove;
  }
}