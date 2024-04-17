import 'package:flutter/material.dart';

class Problem_Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // problem body
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('icon/problem_bg.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned( // level
            top: 10,
            left: 80,
            child: Text(
              "Lv.???",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ), // end of level
          Positioned( // problem type
            top: 85,
            left: 275,
            child: Text(
              "단답형 문제",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ), // end of problem type
          Positioned( // code part
            top: 125,
            left: 50,
            width: 310,
            height: 385,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                '''#include <stdio.h>
void main() {
  int n=3;
  if(   ) {
    printf("짝수");
  }
  else {
    printf("홀수");
  }
}
                ''',
                style: TextStyle(
                  // letterSpacing: -2,
                  fontSize: 20,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ), // end of code part
        ],
      ),
    ); // end of problem body
  }
}