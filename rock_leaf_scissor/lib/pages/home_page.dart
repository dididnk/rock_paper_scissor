import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    if (iaChoice == userChoice) return;
    // chack ia win case
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rock Leaf Scissor',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 24.0, color: Colors.white),
            onPressed: resetGame,
          ),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Infos Player IA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(iaImage, height: 64, width: 64),
                              const Text(
                                "IA",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Text(
                        "IA score: $iaScore",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // IA Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 176, 174, 174),
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              176,
                              174,
                              174,
                            ).withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Image.asset(rockImage, height: 32, width: 32),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 250, 185),
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              218,
                              250,
                              185,
                            ).withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Image.asset(leafImage, height: 32, width: 32),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 185, 229, 250),
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(
                              255,
                              185,
                              229,
                              250,
                            ).withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      child: Image.asset(scissorImage, height: 32, width: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Images
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(3),
                        spreadRadius: 5,
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Image.asset(iaChoiceImage, height: 64, width: 64),
                      const SizedBox(height: 24),
                      Image.asset(userChoiceImage, height: 64, width: 64),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // User Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => onButtonPressed(rock),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          176,
                          174,
                          174,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: Image.asset(rockImage, height: 32, width: 32),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => onButtonPressed(leaf),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          218,
                          250,
                          185,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: Image.asset(leafImage, height: 32, width: 32),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => onButtonPressed(scissor),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          185,
                          229,
                          250,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      child: Image.asset(scissorImage, height: 32, width: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Infos Player User
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(userImage, height: 32, width: 32),
                              const Text(
                                "YOU",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Text(
                        "your score: $userScore",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Infos general
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Rounds Played : $roundsPlayed",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: isGameEnd,
                      child: Column(
                        children: [
                          Text(
                            "Final Result",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            finalResult,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: iaScore > userScore
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
