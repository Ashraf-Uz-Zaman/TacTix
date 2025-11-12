import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tactix/domain/entities/game_result.dart';
import 'package:tactix/presentation/resource/color_manager.dart';



class WinningLineWidget extends StatelessWidget {
  final WinningLineType lineType;
  final double boardSize;
  final Animation<double> animation;
  final double padding;
  final double spacing;
  final double thickness;

  const WinningLineWidget({
    super.key,
    required this.lineType,
    required this.boardSize,
    required this.animation,
    required this.padding,
    required this.spacing,
    required this.thickness,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final double animationValue = animation.value;
        final Color lineColor = ColorManager.primary;

        final double cellSize = (boardSize - (padding * 2) - (spacing * 2)) / 3;


        final double halfCell = cellSize / 2;
        final double center1 = padding + halfCell;
        final double center2 = padding + cellSize + spacing + halfCell;
        final double center3 = padding + (cellSize * 2) + (spacing * 2) + halfCell;
        final double lineLength = (boardSize - (padding * 2)) * animationValue;

        final double diagLength = (boardSize * 1.414) * animationValue;


        double top = 0.0, left = 0.0, width = 0.0, height = 0.0, angle = 0.0;

        switch (lineType) {
          case WinningLineType.row1:
            width = lineLength;
            height = thickness;
            left = boardSize / 2 - width / 2; // Center the line
            top = center1 - height / 2;
            break;
          case WinningLineType.row2:
            width = lineLength;
            height = thickness;
            left = boardSize / 2 - width / 2;
            top = center2 - height / 2;
            break;
          case WinningLineType.row3:
            width = lineLength;
            height = thickness;
            left = boardSize / 2 - width / 2;
            top = center3 - height / 2;
            break;
          case WinningLineType.col1:
            width = thickness;
            height = lineLength;
            top = boardSize / 2 - height / 2; // Center the line
            left = center1 - width / 2;
            break;
          case WinningLineType.col2:
            width = thickness;
            height = lineLength;
            top = boardSize / 2 - height / 2;
            left = center2 - width / 2;
            break;
          case WinningLineType.col3:
            width = thickness;
            height = lineLength;
            top = boardSize / 2 - height / 2;
            left = center3 - width / 2;
            break;
          case WinningLineType.diag1:
            width = diagLength;
            height = thickness;
            top = boardSize / 2 - height / 2;
            left = boardSize / 2 - width / 2;
            angle = pi / 4;
            break;
          case WinningLineType.diag2:
            width = diagLength;
            height = thickness;
            top = boardSize / 2 - height / 2;
            left = boardSize / 2 - width / 2;
            angle = -pi / 4;
            break;
        }


        final Widget line = Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: lineColor,
            borderRadius: BorderRadius.circular(height / 2),
            // ... shadow
          ),
        );

        return Positioned(
          top: top,
          left: left,
          child: Transform.rotate(
            angle: angle,
            child: line,
          ),
        );
      },
    );
  }
}