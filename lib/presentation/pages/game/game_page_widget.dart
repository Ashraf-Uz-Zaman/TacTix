part of 'game_page.dart';

Widget _buildModeSelector(BuildContext context, GameMode currentGameMode) {
  return SegmentedButton<GameMode>(
    segments: const [
      ButtonSegment(
        value: GameMode.playerVsAi,
        label: Text(AppStrings.vsAi),
        icon: Icon(Icons.computer),
      ),
      ButtonSegment(
        value: GameMode.playerVsPlayer,
        label: Text(AppStrings.vsPlayer),
        icon: Icon(Icons.group),
      ),
    ],
    selected: {currentGameMode},
    onSelectionChanged: (newSelection) {
      context.read<GameBloc>().add(ChangeGameMode(newSelection.first));
    },
  );
}

Widget _buildStatusMessage(BuildContext context, GameState state) {
  String message;
  Color messageColor = ColorManager.text;
  IconData? messageIcon;
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

  if (state.winner != null) {
    message = 'Player ${state.winner == Player.X ? AppStrings.x : AppStrings.o} Wins!';
    messageColor =
    state.winner == Player.X ? ColorManager.playerX : ColorManager.playerO;
    messageIcon = Icons.emoji_events;
  } else if (state.isDraw) {
    message = AppStrings.draw;
    messageColor = Colors.grey[400]!;
    messageIcon = Icons.handshake;
  } else if (state.isAiThinking) {
    message = AppStrings.aiThinking;
    messageColor = isDarkMode ? ColorManager.text : ColorManager.lightText;
    messageIcon = Icons.hourglass_bottom;
  } else {
    message = 'Player ${state.currentPlayer == Player.X ? AppStrings.x : AppStrings.o}\'s Turn';
    messageColor = state.currentPlayer == Player.X
        ? ColorManager.playerX
        : ColorManager.playerO;
    messageIcon = Icons.touch_app;
  }
  final metrics = getIt<AppMetrics>();
  return AnimatedSwitcher(
    duration: const Duration(milliseconds: AppDuration.d300),
    transitionBuilder: (Widget child, Animation<double> animation) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    child: Container(
      key: ValueKey<String>(message),
      padding:  EdgeInsets.symmetric(
          vertical: metrics.p12, horizontal: metrics.p20),
      decoration: BoxDecoration(
        color:
        isDarkMode ? ColorManager.secondary : ColorManager.lightSecondary,
        borderRadius: BorderRadius.circular(metrics.r16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: metrics.p12,
        children: [

          Icon(messageIcon, color: messageColor, size: metrics.s24),
          Text(
            message,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: messageColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}