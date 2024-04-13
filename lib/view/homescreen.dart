import 'dart:async';
import 'dart:math';

import 'package:flightblueball/constants/colors.dart';
import 'package:flightblueball/tools/barriers.dart';
import 'package:flutter/material.dart';

import '../constants/sizes.dart';
import '../tools/blueball.dart';

// import 'dart:convert';
class HomeScreen extends StatefulWidget {
  // const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double blueBallX = 0.0,
      blueBallY = 0.0,
      time = 0,
      height = 0,
      initialHeight = 0;
  int score = 0, highScore = 0;
  static double barrierX = 1.0,
      barrierX2 = barrierX + 0.5,
      barrierX3 = barrierX + 1,
      barrierX4 = barrierX + 1.66,

      //barriersXYs
      barrierXY = 1.60,
      barrierXY2 = -1.80,
      barrierX2Y = 1.50,
      barrierX2Y2 = -1.80,
      barrierX3Y = 1.5,
      barrierX3Y2 = -1.30,
      barrierX4Y = 1.20,
      barrierX4Y2 = -2.0;
  bool gameHasStarted = false, gameOver = false;
  void jump() {
    setState(() {
      time = 0;
      initialHeight = blueBallY;
    });
  }

  void endGame(var timer) {
    gameOver = true;
    timer.cancel();
    // gameHasStarted = false;
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 80), (timer) {
      time += 0.05;
      height = -4.9 * pow(time, 2) + 2 * time;

      setState(() {
        blueBallY = initialHeight - height;

        if (barrierX <= -1.5)
          barrierX = 1.2;
        else
          barrierX -= 0.01;
        // print("barrierX = $barrierX");

        if (barrierX2 <= -1.5)
          barrierX2 = 1.2;
        else
          barrierX2 -= 0.01;
        // print("barrierX2 = $barrierX2");
        if (barrierX3 <= -1.5)
          barrierX3 = 1.2;
        else
          barrierX3 -= 0.01;
        print("barrierX3 = $barrierX3");
        //barrierX4
        if (barrierX4 <= -1.5)
          barrierX4 = 1.2;
        else
          barrierX4 -= 0.01;
        // print("barrierX4 = $barrierX4");

        //todo blueBallX

        if (((blueBallY <= barrierXY && blueBallY >= barrierXY2) &&
                (barrierX <= blueBallX && barrierX + 0.01 > blueBallX) ||
            (blueBallY <= barrierX2Y && blueBallY >= barrierX2Y2) &&
                (barrierX2 <= blueBallX && barrierX2 + 0.01 > blueBallX) ||
            (blueBallY <= barrierX3Y && blueBallY >= barrierX3Y2) &&
                (barrierX3 <= blueBallX && barrierX3 + 0.01 > blueBallX) ||
            (blueBallY <= barrierX4Y && blueBallY >= barrierX4Y2) &&
                (barrierX4 <= blueBallX && barrierX4 + 0.01 > blueBallX) &&
                (blueBallY <= barrierXY ||
                    blueBallY >= barrierXY2 ||
                    blueBallY <= barrierX2Y ||
                    blueBallY >= barrierX2Y2 ||
                    blueBallY <= barrierX3Y ||
                    blueBallY >= barrierX3Y2 ||
                    blueBallY <= barrierX4Y ||
                    blueBallY >= barrierX4Y2))) {
          score++;
          if (score > highScore) {
            highScore = score;
            //convert hig_score to stored_data.json
          }
        } else if (blueBallY < 1) {
        } else {
          print("blueBallX = $blueBallX ,blueBallY = $blueBallY");
          endGame(timer);
        }
        // endGame(timer);
        // if ((blueBallY >= barrierXY || blueBallY<=barrierXY2) &&
        //         (barrierX <= blueBallX && barrierX + 0.01 > blueBallX) ||
        //     (blueBallY <= barrierX2Y || blueBallY<=barrierX2Y2) &&
        //         (barrierX2 <= blueBallX && barrierX2 + 0.01 > blueBallX) ||
        //     (blueBallY >= barrierX3Y || blueBallY<=barrierX3Y2) &&
        //         (barrierX3 <= blueBallX && barrierX3 + 0.01 > blueBallX) ||
        //     (blueBallY <= barrierX4Y || blueBallY<=barrierX4Y2) &&
        //         (barrierX4 <= blueBallX && barrierX4 + 0.01 > blueBallX)) {
        //   endGame(timer);
        // }
      });

      if (blueBallY >= 1.0) {
        endGame(timer);
      }
      print("------------------------");
      print("blueBallY == barrierX3Y =${blueBallY == barrierX3Y}");
      print("blueBallY == barrierX4Y =${blueBallY == barrierX4Y}");
      // print("barrierX = $barrierX");
      // print("barrierX2 = $barrierX2");
      // print("barrierX3 = $barrierX3");
      // print("barrierX4 = $barrierX4");
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, blueBallY),
                    duration: Duration(milliseconds: 0),
                    color: Color.fromARGB(255, 241, 233, 159),
                    child: BlueBall(),
                  ),

                  //The First Barrier
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    //barraierXY = 1.11;
                    alignment: Alignment(barrierX, barrierXY),
                    child: Barrier(
                      size: 200.0,
                    ),
                  ),
                  //The Second Barrier
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    //barraierXY2 = -1.80;
                    alignment: Alignment(barrierX, barrierXY2),
                    child: Barrier(
                      size: 200.0,
                    ),
                  ),
                  //The Third Barrier
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    //barraierX2Y = 1.50;
                    alignment: Alignment(barrierX2, barrierX2Y),
                    child: Barrier(
                      size: 150.0,
                    ),
                  ),
                  //The Forth Barrier
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    //barrierX2Y2 = -1.80;
                    alignment: Alignment(barrierX2, barrierX2Y2),
                    child: Barrier(
                      size: 250.0,
                    ),
                  ),
                  //The Fifth Barrier
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    //barrierX3Y = 1.5;
                    alignment: Alignment(barrierX3, barrierX3Y),
                    child: Barrier(
                      size: 150.0,
                    ),
                  ),
                  //The Sixth Barrier
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    //barrierX3Y2 = -1.80
                    alignment: Alignment(barrierX3, barrierX3Y2),
                    child: Barrier(
                      size: 250.0,
                    ),
                  ),
                  //The Seventh Barrier
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    //barrierX4Y = 1.20
                    alignment: Alignment(barrierX4, barrierX4Y),
                    child: Barrier(
                      size: 150.0,
                    ),
                  ),
                  //The Eighth Barrier
                  AnimatedContainer(
                    duration: Duration(milliseconds: 0),
                    //barrierX4Y2 = -2.0
                    alignment: Alignment(barrierX4, barrierX4Y2),
                    child: Barrier(
                      size: 250.0,
                    ),
                  ),
                  if (gameHasStarted == false)
                    Container(
                        alignment: Alignment(0, -0.3),
                        child: Text(
                          "T A P  T O  P L A Y",
                          style: TextStyle(
                              fontSize: SECONDARY_FONT_SIZE,
                              color: PRIMARY_FONT_COLOR,
                              backgroundColor: BARRIER_COLOR),
                        )),
                  //gameOver ? "G A M E  O V E R"
                  if (gameOver == true)
                    Container(
                        alignment: Alignment(0, -0.3),
                        child: Text(
                          "G A M E  O V E R",
                          style: TextStyle(
                              fontSize: SECONDARY_FONT_SIZE,
                              color: PRIMARY_FONT_COLOR,
                              backgroundColor: BARRIER_COLOR),
                        )),
                ],
              )),
          Container(
            height: 10,
            color: BARRIER_COLOR,
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color.fromARGB(255, 95, 28, 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Score",
                        style: TextStyle(
                            fontSize: PRIMERY_FONT_SIZE,
                            color: PRIMARY_FONT_COLOR),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$score",
                        style: TextStyle(
                            fontSize: PRIMERY_FONT_SIZE,
                            color: PRIMARY_FONT_COLOR),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Best",
                        style: TextStyle(
                            fontSize: PRIMERY_FONT_SIZE,
                            color: PRIMARY_FONT_COLOR),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("$highScore",
                          style: TextStyle(
                              fontSize: PRIMERY_FONT_SIZE,
                              color: PRIMARY_FONT_COLOR))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
