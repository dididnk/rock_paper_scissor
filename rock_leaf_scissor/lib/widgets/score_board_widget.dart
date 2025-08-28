import 'package:flutter/material.dart';
import 'package:rock_leaf_scissor/l10n/app_localizations.dart';
import 'package:rock_leaf_scissor/utils/theme/app_colors.dart';

class ScoreBoardWidget extends StatelessWidget {
  final int userScore;
  final int iaScore;
  final int roundsPlayed;
  final Function()? resetGame;

  const ScoreBoardWidget({
    super.key,
    required this.userScore,
    required this.iaScore,
    required this.roundsPlayed,
    this.resetGame,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                l10n.player,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "$userScore",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(Icons.more_time_outlined, color: greyColor, size: 28),
              const SizedBox(height: 5),
              Text(
                "$roundsPlayed",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                l10n.ia,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "$iaScore",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Theme.of(context).colorScheme.error,
                width: 0.5,
              ),
            ),
            child: IconButton(
              onPressed: resetGame,
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context).colorScheme.error,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
