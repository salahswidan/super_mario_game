import 'dart:async';

import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double MarioX = 0;
  double MarioY = 0;
  bool isLeft = false, isRun = false, isJump = false;
  void MarioRight() {
    setState(() {
      isLeft = false;
      isRun = true;
      MarioX -= 10;
    });
    Timer.periodic(
      Duration(milliseconds: 70),
      (timer) {
        setState(() {
          isRun = false;
          timer.cancel();
        });
      },
    );
  }

  void MarioLeft() {
    setState(() {
      isLeft = true;
      isRun = true;
      MarioX += 10;
    });
    Timer.periodic(
      Duration(milliseconds: 70),
      (timer) {
        setState(() {
          isRun = false;
          timer.cancel();
        });
      },
    );
  }

  void MarioJump() {
    setState(() {
      MarioY += 300;
      isJump = true;
    });
    Timer.periodic(
      Duration(milliseconds: 300),
      (timer) {
        if (MarioY != 0) {
          setState(() {
            MarioY = 0;
          });
        } else {
          setState(() {
            isJump = false;
            timer.cancel();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/back.png"), fit: BoxFit.cover)),
            child: Stack(
              children: [
                AnimatedPositioned(
                    bottom: MarioY,
                    right: MediaQuery.of(context).size.width / 2 - 25 + MarioX,
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          isJump ? 
                          isLeft ? 
                          "assets/jumpL.png":
                           "assets/jump.png":
                          isRun
                            ? isLeft
                                ? "assets/runL.png"
                                : "assets/run.png"
                            : isLeft
                                ? "assets/marioL.png"
                                : "assets/mario.png"),
                      )),
                    ),
                    duration: Duration(milliseconds: isJump ?300:70))
              ],
            ),
          )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/ground.png"), fit: BoxFit.cover)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: MarioLeft,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(206, 158, 158, 158),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                GestureDetector(
                  onTap: MarioJump,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(206, 158, 158, 158),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.arrow_upward),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                GestureDetector(
                  onTap: MarioRight,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(206, 158, 158, 158),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.arrow_forward),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}