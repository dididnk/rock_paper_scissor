import 'dart:math';
import 'package:flutter/material.dart';

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> with SingleTickerProviderStateMixin {
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
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rock Leaf Scissor',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
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
        shadowColor: Colors.deepPurple.withOpacity(0.5),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade100,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Score Board
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.2),
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
                            "YOU",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "$userScore",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "ROUND",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "$roundsPlayed/$totalRounds",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "IA",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
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
                    ],
                  ),
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
                          Column(
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
                                      color: Colors.deepPurple.withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Image.asset(iaChoiceImage, height: 80, width: 80),
                              ),
                            ],
                          ),
                          
                          // VS Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "VS",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                          // User Choice
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepPurple.withOpacity(0.3),
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
                          ),
                        ],
                      ),
                      
                      // Result Overlay
                      if (_showResult)
                        Center(
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              decoration: BoxDecoration(
                                color: _resultColor,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: _resultColor.withOpacity(0.5),
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
                        ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildChoiceButton(rock, rockImage, Colors.grey),
                    _buildChoiceButton(leaf, leafImage, Colors.green),
                    _buildChoiceButton(scissor, scissorImage, Colors.blue),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Final Result
                if (isGameEnd)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: finalResult == "You Win!" ? Colors.green.shade100 : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      finalResult,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: finalResult == "You Win!" ? Colors.green.shade800 : Colors.red.shade800,
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

  Widget _buildChoiceButton(String choice, String image, Color color) {
    return GestureDetector(
      onTap: () => onButtonPressed(choice),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Image.asset(image, height: 40, width: 40),
      ),
    );
  }
}