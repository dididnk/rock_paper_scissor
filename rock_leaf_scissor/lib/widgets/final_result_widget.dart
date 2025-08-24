import 'package:flutter/material.dart';

class FinalResultWidget extends StatelessWidget {
  final int userScore;
  final int iaScore;
  final String finalResult;
  final VoidCallback resetGame;

  const FinalResultWidget({
    super.key,
    required this.userScore,
    required this.iaScore,
    required this.finalResult,
    required this.resetGame,
  });

  @override
  Widget build(BuildContext context) {
    Widget pillScore(String who, int score, Color color) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Row(
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
              "$who: $score",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    return Positioned.fill(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.84,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: userScore > iaScore
                ? Colors.deepPurple
                : Colors.red.shade800,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.2,
            ),
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
              Text(
                userScore > iaScore ? "VICTORY" : "DEFEAT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                finalResult,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pillScore(
                    "YOU",
                    userScore,
                    userScore > iaScore ? Colors.greenAccent : Colors.white,
                  ),
                  const SizedBox(width: 12),
                  pillScore(
                    "IA",
                    iaScore,
                    !(userScore > iaScore) ? Colors.redAccent : Colors.white,
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 22,
                  ),
                ),
                onPressed: resetGame,
                child: const Text(
                  "Play Again",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
