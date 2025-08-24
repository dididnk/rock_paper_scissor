import 'dart:math';
import 'package:flutter/material.dart';

class HomePageV3 extends StatefulWidget {
  const HomePageV3({super.key});

  @override
  State<HomePageV3> createState() => _HomePageV3State();
}

class _HomePageV3State extends State<HomePageV3> with TickerProviderStateMixin {
  // --- Logique inchangée ---
  final rock = "rock";
  final leaf = "leaf";
  final scissor = "scissor";

  final iaImage = "assets/images/ia.png";
  final userImage = "assets/images/user.png";

  final defaultImage = "assets/images/question.png";
  final rockImage = "assets/images/rock.png";
  final leafImage = "assets/images/leaf.png";
  final scissorImage = "assets/images/scissor.png";

  final totalRounds = 3;
  final maxResult = 3;

  int roundsPlayed = 0;

  int userScore = 0;
  int iaScore = 0;

  String userChoice = "";
  String iaChoice = "";

  String userChoiceImage = "assets/images/question.png";
  String iaChoiceImage = "assets/images/question.png";

  String finalResult = "";

  bool isGameEnd = false;

  void resetGame() {
    setState(() {
      roundsPlayed = 0;

      userScore = 0;
      iaScore = 0;

      userChoice = "";
      iaChoice = "";

      userChoiceImage = defaultImage;
      iaChoiceImage = defaultImage;

      finalResult = "";
      isGameEnd = false;
    });
  }

  void onButtonPressed(String choice) {
    if (!checkIsGameEnd()) {
      setUserChoice(choice);
      setIaChoice();
      playGame();
    }
  }

  void setUserChoice(String choice) {
    if (choice == rock) {
      setState(() {
        userChoice = rock;
        userChoiceImage = rockImage;
      });
    } else if (choice == leaf) {
      setState(() {
        userChoice = leaf;
        userChoiceImage = leafImage;
      });
    } else {
      setState(() {
        userChoice = scissor;
        userChoiceImage = scissorImage;
      });
    }
  }

  void setIaChoice() {
    int iaValue = Random().nextInt(3);
    if (iaValue == 0) {
      setState(() {
        iaChoice = rock;
        iaChoiceImage = rockImage;
      });
    } else if (iaValue == 1) {
      setState(() {
        iaChoice = leaf;
        iaChoiceImage = leafImage;
      });
    } else {
      setState(() {
        iaChoice = scissor;
        iaChoiceImage = scissorImage;
      });
    }
  }

  void playGame() {
    if (iaChoice == userChoice) return;
    if ((iaChoice == rock && userChoice == scissor) ||
        (iaChoice == scissor && userChoice == leaf) ||
        (iaChoice == leaf && userChoice == rock)) {
      setState(() {
        iaScore++;
      });
    } else {
      setState(() {
        userScore++;
      });
    }
    setState(() {
      roundsPlayed++;
    });
    checkIsGameEnd();
  }

  bool checkIsGameEnd() {
    if (iaScore == maxResult || userScore == maxResult) {
      if (iaScore > userScore) {
        setState(() {
          finalResult = "You lost!";
        });
      } else {
        setState(() {
          finalResult = "You Win!";
        });
      }
      setState(() {
        isGameEnd = true;
      });
      return true;
    }
    return false;
  }
  // --- Fin logique inchangée ---

  // --- UI helpers (visuel uniquement) ---
  LinearGradient get _bgGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
  );

  BoxDecoration get _glassCard => BoxDecoration(
    color: Colors.white.withOpacity(0.08),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );

  Widget _lifeBar({
    required String label,
    required String avatarImage,
    required double value, // 0..1
    required Color color,
    required int score,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _glassCard,
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withOpacity(0.12),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(avatarImage, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(label.toUpperCase()),
                      Text('Score: $score'),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: value.clamp(0, 1),
                    minHeight: 10,
                    backgroundColor: Colors.white.withOpacity(0.12),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _choiceReveal({required String title, required String imagePath}) {
    return Container(
      width: double.infinity,
      decoration: _glassCard,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, anim) => ScaleTransition(
              scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: Container(
              key: ValueKey(imagePath),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              child: Image.asset(imagePath, height: 72, width: 72),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundDots() {
    // Affiche 3 cercles de progression (maxResult)
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxResult, (i) {
        final active = (i < userScore || i < iaScore) && (userScore != iaScore);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? Colors.white : Colors.white.withOpacity(0.25),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.6),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
        );
      }),
    );
  }

  Widget _choiceCard({
    required String asset,
    required bool selected,
    required VoidCallback onTap,
    Color? tint,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              (tint ?? Colors.white).withOpacity(selected ? 0.22 : 0.12),
              (tint ?? Colors.white).withOpacity(selected ? 0.10 : 0.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(selected ? 0.35 : 0.18),
            width: selected ? 1.5 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: (tint ?? Colors.white).withOpacity(0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        child: AnimatedScale(
          scale: selected ? 1.08 : 1.0,
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutBack,
          child: Image.asset(asset, height: 48, width: 48),
        ),
      ),
    );
  }

  Widget _resultModal(BuildContext context) {
    if (!isGameEnd) return const SizedBox.shrink();
    final win = userScore > iaScore;
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.55)),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.84,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: win ? const Color(0xFF0E3B2E) : const Color(0xFF3B0E0E),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 30,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  win ? "VICTORY" : "DEFEAT",
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
                    _pillScore(
                      "YOU",
                      userScore,
                      win ? Colors.greenAccent : Colors.white,
                    ),
                    const SizedBox(width: 12),
                    _pillScore(
                      "IA",
                      iaScore,
                      !win ? Colors.redAccent : Colors.white,
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
      ),
    );
  }

  Widget _pillScore(String who, int score, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
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
                  color: color.withOpacity(0.6),
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

  // --- BUILD ---
  @override
  Widget build(BuildContext context) {
    final userProgress = userScore / maxResult;
    final iaProgress = iaScore / maxResult;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background
          Container(decoration: BoxDecoration(gradient: _bgGradient)),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Column(
                children: [
                  // App bar
                  Row(
                    children: [
                      const Icon(
                        Icons.sports_martial_arts,
                        color: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Rock • Leaf • Scissor",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Reset',
                        onPressed: resetGame,
                        icon: const Icon(Icons.refresh, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Best of 3 — No draws counted',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 14),

                  // Life bars
                  Row(
                    children: [
                      Expanded(
                        child: _lifeBar(
                          label: "IA",
                          avatarImage: iaImage,
                          value: iaProgress,
                          color: Colors.redAccent,
                          score: iaScore,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _lifeBar(
                          label: "YOU",
                          avatarImage: userImage,
                          value: userProgress,
                          color: Colors.greenAccent,
                          score: userScore,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Reveal cards
                  Expanded(
                    child: Container(
                      decoration: _glassCard,
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          // Round dots + rounds counter
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _roundDots(),
                              Text(
                                "Round ${roundsPlayed + 1} / $totalRounds",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: _choiceReveal(
                                    title: "IA CHOICE",
                                    imagePath: iaChoiceImage,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _choiceReveal(
                                    title: "YOUR CHOICE",
                                    imagePath: userChoiceImage,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Choice buttons (cards)
                          Row(
                            children: [
                              Expanded(
                                child: _choiceCard(
                                  asset: rockImage,
                                  selected: userChoice == rock,
                                  tint: const Color(0xFFB0B0B0),
                                  onTap: () => onButtonPressed(rock),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _choiceCard(
                                  asset: leafImage,
                                  selected: userChoice == leaf,
                                  tint: const Color(0xFFA7ECA8),
                                  onTap: () => onButtonPressed(leaf),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _choiceCard(
                                  asset: scissorImage,
                                  selected: userChoice == scissor,
                                  tint: const Color(0xFFA8D9FF),
                                  onTap: () => onButtonPressed(scissor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // End modal
          _resultModal(context),
        ],
      ),
    );
  }
}
