import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rock_leaf_scissor/l10n/app_localizations.dart';
import 'package:rock_leaf_scissor/utils/global_constances.dart';
import 'package:rock_leaf_scissor/widgets/custom_button.dart';
import 'package:rock_leaf_scissor/widgets/final_result_widget.dart';
import 'package:rock_leaf_scissor/widgets/language_widget.dart';
import 'package:rock_leaf_scissor/widgets/score_board_widget.dart';

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

  bool isGameEnd = false;
  bool showButtons = true;

  // Nouvelles variables pour l'animation et la gamification
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _showResult = false;
  String _roundResult = "";
  Color _resultColor = Colors.transparent;
  Color userChoiceColor = Colors.deepPurple;
  Color iaChoiceColor = Colors.deepPurple;

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
      userChoiceImage = questionImageUrl;
      iaChoiceImage = questionImageUrl;
      isGameEnd = false;
      _showResult = false;
      _roundResult = "";
      _resultColor = Colors.transparent;
      userChoiceColor = Colors.deepPurple;
      iaChoiceColor = Colors.deepPurple;
      showButtons = true;
    });
  }

  void onButtonPressed(String choice, Color color) {
    if (!isGameEnd && showButtons) {
      setUserChoice(choice, color);
      setIaChoice();
      playGame();
    }
  }

  void setUserChoice(String choice, Color color) {
    if (choice == rock) {
      setState(() {
        userChoice = rock;
        userChoiceImage = rockImageUrl;
      });
    } else if (choice == leaf) {
      setState(() {
        userChoice = leaf;
        userChoiceImage = leafImageUrl;
      });
    } else {
      setState(() {
        userChoice = scissor;
        userChoiceImage = scissorImageUrl;
      });
    }
    setState(() {
      userChoiceColor = color;
    });
  }

  void setIaChoice() {
    // generate IA choice
    int iaValue = Random().nextInt(3);
    // save IA choice as string
    if (iaValue == 0) {
      setState(() {
        iaChoice = rock;
        iaChoiceImage = rockImageUrl;
        iaChoiceColor = Colors.grey;
      });
    } else if (iaValue == 1) {
      setState(() {
        iaChoice = leaf;
        iaChoiceImage = leafImageUrl;
        iaChoiceColor = Colors.green;
      });
    } else {
      setState(() {
        iaChoice = scissor;
        iaChoiceImage = scissorImageUrl;
        iaChoiceColor = Colors.blue;
      });
    }
  }

  void playGame() {
    setState(() {
      showButtons = false;
    });

    // Vérification du cas nul
    if (iaChoice == userChoice) {
      setState(() {
        _roundResult = AppLocalizations.of(context)!.roundDraw;
        _resultColor = Colors.amber;
        _showResult = true;
      });

      _animationController.forward(from: 0.0).then((_) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _showResult = false;
            showButtons = true;
          });
        });
      });
      return;
    }

    // Vérification de la victoire de l'IA
    if ((iaChoice == rock && userChoice == scissor) ||
        (iaChoice == scissor && userChoice == leaf) ||
        (iaChoice == leaf && userChoice == rock)) {
      setState(() {
        iaScore++;
        _roundResult = AppLocalizations.of(context)!.iaWin;
        _resultColor = Colors.red;
        _showResult = true;
      });
    }
    // Cas de victoire du joueur
    else {
      setState(() {
        userScore++;
        _roundResult = AppLocalizations.of(context)!.userWin;
        _resultColor = Colors.green;
        _showResult = true;
      });
    }

    _animationController.forward(from: 0.0).then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _showResult = false;
          showButtons = true;
          roundsPlayed++;
          checkIsGameEnd();
        });
      });
    });
  }

  void checkIsGameEnd() {
    var gameEnd = iaScore == maxResult || userScore == maxResult;

    if (gameEnd) {
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
              resetGame: () {
                Navigator.of(context).pop();
                resetGame();
              },
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    Column iaChoiceWidget() {
      return Column(
        children: [
          Text(
            l10n.iaChoice,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: iaChoiceColor.withValues(alpha: 0.9),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Image.asset(iaChoiceImage, height: 60, width: 60),
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
                  color: userChoiceColor.withValues(alpha: 0.9),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Image.asset(userChoiceImage, height: 60, width: 60),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.userChoice,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
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
            image: rockImageUrl,
            color: Colors.grey,
            onTap: () => onButtonPressed(rock, Colors.grey),
          ),
          CustomButton(
            choice: leaf,
            image: leafImageUrl,
            color: Colors.green,
            onTap: () => onButtonPressed(leaf, Colors.green),
          ),
          CustomButton(
            choice: scissor,
            image: scissorImageUrl,
            color: Colors.blue,
            onTap: () => onButtonPressed(scissor, Colors.blue),
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
        title: Text(
          l10n.appTitle,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [LanguageWidget()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScoreBoardWidget(
                userScore: userScore,
                iaScore: iaScore,
                roundsPlayed: roundsPlayed,
                resetGame: resetGame,
              ),

              const SizedBox(height: 10),

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
                        Image.asset(vsImageUrl, height: 60, width: 60),
                        // User Choice
                        userChoiceWidget(),
                      ],
                    ),
                    // Result Overlay
                    if (_showResult) resultOverlay(),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Action Buttons
              if (showButtons) ...[
                actionButtons(),
              ] else ...[
                LoadingAnimationWidget.bouncingBall(
                  color: Color(0xFF8E24AA),
                  size: MediaQuery.of(context).size.height * 0.06,
                ),
              ],

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
