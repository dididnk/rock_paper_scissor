import 'package:flutter/material.dart';
import 'package:rock_leaf_scissor/l10n/app_localizations.dart';
import 'package:rock_leaf_scissor/utils/global_constances.dart';
import 'package:rock_leaf_scissor/utils/theme/app_colors.dart';

class FinalResultWidget extends StatelessWidget {
  final int userScore;
  final int iaScore;
  final VoidCallback resetGame;

  const FinalResultWidget({
    super.key,
    required this.userScore,
    required this.iaScore,
    required this.resetGame,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPlayerWin = userScore > iaScore;
    final String winnerImage = isPlayerWin ? userProfileUrl : iaProfileUrl;
    final l10n = AppLocalizations.of(context)!;

    Widget pillScore(String who, int score, Color color) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.6),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            Text(
              "$who : $score",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isPlayerWin
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.9)
            : Theme.of(context).colorScheme.error.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: greyColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(winnerImage, height: 80, width: 80),
          const SizedBox(height: 6),
          Text(
            isPlayerWin ? l10n.finalWin : l10n.finalLose,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 18),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pillScore(
                l10n.ia,
                iaScore,
                !(isPlayerWin) ? redColor : Colors.white,
              ),
              const SizedBox(height: 12),
              pillScore(
                l10n.player,
                userScore,
                isPlayerWin ? greenColor : Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
            ),
            onPressed: resetGame,
            child: Text(
              l10n.restart,
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
