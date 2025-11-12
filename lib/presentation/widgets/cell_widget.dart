import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tactix/core/locator/injection.dart';
import 'package:tactix/domain/entities/player.dart';
import 'package:tactix/presentation/resource/color_manager.dart';
import 'package:tactix/presentation/resource/strings_manager.dart';
import 'package:tactix/presentation/resource/values_manager.dart';



class CellWidget extends StatelessWidget {
  final Player player;
  final VoidCallback onTap;
  final metrics = getIt<AppMetrics>();

  CellWidget({
    super.key,
    required this.player,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color:
          isDarkMode ? ColorManager.secondary : ColorManager.lightSecondary,
          borderRadius: BorderRadius.circular(metrics.r12),
        ),
        // Use LayoutBuilder to get the cell's size
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Make icon size proportional (e.g., 70% of the cell's width)
            final double iconSize = constraints.maxWidth * 0.7;

            return Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: AppDuration.d300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: _buildPlayerIcon(player, iconSize), // Pass the size
              ),
            );
          },
        ),
      ),
    );
  }

  // Update _buildPlayerIcon to accept a size
  Widget _buildPlayerIcon(Player player, double iconSize) {
    switch (player) {
      case Player.X:
        return Icon(
          Icons.close,
          key: const ValueKey(AppStrings.x),
          size: iconSize,
          color: ColorManager.playerX,
        );
      case Player.O:
        return Icon(
          Icons.circle_outlined,
          key: const ValueKey(AppStrings.o),
          size: iconSize * 0.9, // O is slightly smaller, keep the ratio
          color: ColorManager.playerO,
        );

      default:
        return const SizedBox.shrink(key: ValueKey(AppStrings.none));
    }
  }
}