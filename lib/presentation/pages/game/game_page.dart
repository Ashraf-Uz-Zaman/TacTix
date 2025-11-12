import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tactix/core/locator/injection.dart';
import 'package:tactix/domain/entities/game_mode.dart';
import 'package:tactix/domain/entities/player.dart';
import 'package:tactix/presentation/bloc/game_bloc.dart';
import 'package:tactix/presentation/resource/color_manager.dart';
import 'package:tactix/presentation/resource/strings_manager.dart';
import 'package:tactix/presentation/resource/values_manager.dart';
import 'package:tactix/presentation/widgets/board_widget.dart';
import 'package:tactix/presentation/widgets/winning_line_widget.dart';


part 'game_page_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with SingleTickerProviderStateMixin {
  late AnimationController _lineAnimationController;
  late Animation<double> _lineAnimation;
  final metrics = getIt<AppMetrics>();

  @override
  void initState() {
    super.initState();
    _lineAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppDuration.d500),
    );
    _lineAnimation = Tween<double>(begin: 0.001, end: 1.0).animate(
      CurvedAnimation(
        parent: _lineAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _lineAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: SafeArea(
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {
            if (state.winningLine != null &&
                !_lineAnimationController.isAnimating) {
              _lineAnimationController.forward(from: 0.0);
            } else if (state.winningLine == null &&
                _lineAnimationController.isCompleted) {
              _lineAnimationController.reset();
            }
          },
          builder: (context, state) {
            return Padding(
              padding:  EdgeInsets.all(metrics.p20),
              child: LayoutBuilder(
                builder: (context, constraints) {

                  final availableWidth = constraints.maxWidth;
                  final double boardSize = availableWidth * 0.96;
                  final double boardPadding = availableWidth * 0.03;
                  final double boardSpacing = availableWidth * 0.03;
                  final double lineThickness = availableWidth * 0.025;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: metrics.p12,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildModeSelector(context, state.gameMode),
                      SizedBox(height: metrics.p8),
                      _buildStatusMessage(context, state),

                      Center(
                        child:  Stack(
                          children: [
                            BoardWidget(
                              boardSize: boardSize,
                              board: state.board,
                              padding: boardPadding,
                              spacing: boardSpacing,
                              onCellTap: (index) {
                                context.read<GameBloc>().add(MakeMove(index));
                              },
                            ),
                            if (state.winningLine != null)
                              WinningLineWidget(
                                lineType: state.winningLine!,
                                boardSize: boardSize,
                                animation: _lineAnimation,
                                // Pass the *same* values
                                padding: boardPadding,
                                spacing: boardSpacing,
                                thickness: lineThickness,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: metrics.p8),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: AppDuration.d300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: state.isAiThinking
                            ? SizedBox(
                          key: const ValueKey(AppStrings.spinner),
                          height: metrics.s36,
                          width: metrics.s36,
                          child: const CircularProgressIndicator(
                            color: ColorManager.primary,
                            strokeWidth: 3.0,
                          ),
                        )
                            :  SizedBox(
                          key: ValueKey(AppStrings.emptyBox),
                          height: metrics.s36,
                        ),
                      ),
                      SizedBox(height: metrics.p8),
                      const _ResetButton(),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}


class _ResetButton extends StatelessWidget {
  const _ResetButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<GameBloc>().add(const ResetGame());
      },
      child: const Text(AppStrings.resetGame),
    );
  }
}