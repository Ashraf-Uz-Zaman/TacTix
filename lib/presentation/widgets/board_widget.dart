import 'package:flutter/material.dart';
import 'package:tactix/core/locator/injection.dart';
import 'package:tactix/domain/entities/player.dart';
import 'package:tactix/presentation/resource/color_manager.dart';
import 'package:tactix/presentation/resource/values_manager.dart';
import 'cell_widget.dart';

class BoardWidget extends StatelessWidget {
  final List<Player> board;
  final Function(int) onCellTap;
  final double boardSize;
  final double padding;
  final double spacing;

  const BoardWidget({
    super.key,
    required this.board,
    required this.onCellTap,
    required this.boardSize,
    required this.padding, // New
    required this.spacing, // New
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final metrics = getIt<AppMetrics>();

    return SizedBox(
      height: boardSize,
      width: boardSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isDarkMode ? ColorManager.accent : ColorManager.lightAccent,
          borderRadius: BorderRadius.circular(metrics.r16), // This can be proportional too!
          // ... shadow
        ),
        child: GridView.count(
          padding: EdgeInsets.all(padding), // Use proportional padding
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: spacing,   // Use proportional spacing
          crossAxisSpacing: spacing, // Use proportional spacing
          children: List.generate(
            9,
                (index) => CellWidget(
              player: board[index],
              onTap: () => onCellTap(index),
            ),
          ),
        ),
      ),
    );
  }
}