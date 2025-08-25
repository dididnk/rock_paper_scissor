import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rock_leaf_scissor/utils/global_constances.dart';
import 'package:rock_leaf_scissor/widgets/custom_button.dart';
import 'package:rock_leaf_scissor/widgets/final_result_widget.dart';
import 'package:rock_leaf_scissor/widgets/score_board_widget.dart';
import 'package:rock_leaf_scissor/widgets/vs_badge.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
  bool isChecking = false;

  // Nouvelles variables pour l'animation et la gamification
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _showResult = false;
  String _roundResult = "";
  Color _resultColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

    // Configuration des animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
      _showResult = false;
      _roundResult = "";
      _resultColor = Colors.transparent;
    });
  }

  void onButtonPressed(String choice) {
    if (!checkIsGameEnd()) {
      setUserChoice(choice);
      setIaChoice();
      playGame();
    }
    setState(() {
      isChecking = false;
    });
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
    // generate IA choice
    int iaValue = Random().nextInt(3);
    // save IA choice as string
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
    setState(() {
      isChecking = false;
    });
    // check draw case
    if (iaChoice == userChoice) {
      setState(() {
        _roundResult = "Égalité!";
        _resultColor = Colors.amber;
        _showResult = true;
      });
      _animationController.forward(from: 0.0).then((_) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _showResult = false;
          });
        });
      });
      return;
    }

    // check ia win case
    if ((iaChoice == rock && userChoice == scissor) ||
        (iaChoice == scissor && userChoice == leaf) ||
        (iaChoice == leaf && userChoice == rock)) {
      setState(() {
        iaScore++;
        _roundResult = "IA gagne!";
        _resultColor = Colors.red;
        _showResult = true;
      });
    } else {
      setState(() {
        userScore++;
        _roundResult = "Vous gagnez!";
        _resultColor = Colors.green;
        _showResult = true;
      });
    }

    _animationController.forward(from: 0.0).then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _showResult = false;
        });
      });
    });

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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: FinalResultWidget(
              userScore: userScore,
              iaScore: iaScore,
              finalResult: finalResult,
              resetGame: () {
                Navigator.of(context).pop();
                resetGame();
              },
            ),
          );
        },
      );
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Column iaChoiceWidget() {
      return Column(
        children: [
          const Text(
            "IA CHOICE",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(iaChoiceImage, height: 80, width: 80),
          ),
        ],
      );
    }

    Column userChoiceWidget() {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(userChoiceImage, height: 80, width: 80),
          ),
          const SizedBox(height: 10),
          const Text(
            "YOUR CHOICE",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      );
    }

    Row actionButtons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
            choice: rock,
            image: rockImage,
            color: Colors.grey,
            onTap: () => onButtonPressed(rock),
          ),
          CustomButton(
            choice: leaf,
            image: leafImage,
            color: Colors.green,
            onTap: () => onButtonPressed(leaf),
          ),
          CustomButton(
            choice: scissor,
            image: scissorImage,
            color: Colors.blue,
            onTap: () => onButtonPressed(scissor),
          ),
        ],
      );
    }

    Widget resultOverlay() {
      return Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              color: _resultColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: _resultColor.withValues(alpha: 0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              _roundResult,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rock Leaf Scissor',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 24.0, color: Colors.white),
            onPressed: resetGame,
          ),
        ],
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        shadowColor: Colors.deepPurple.withValues(alpha: 0.5),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Score Board
              ScoreBoardWidget(
                userScore: userScore,
                iaScore: iaScore,
                roundsPlayed: roundsPlayed,
                totalRounds: totalRounds,
              ),

              const SizedBox(height: 30),

              // Game Area
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // IA Choice
                        iaChoiceWidget(),
                        // VS Badge
                        VsBadge(),
                        // User Choice
                        userChoiceWidget(),
                      ],
                    ),
                    // Result Overlay
                    if (_showResult) resultOverlay(),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Action Buttons
              if (!isChecking) actionButtons(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
