import 'package:flutter/material.dart';

class Problem_Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // problem body
      child: Container( // background of problem body
        child: Stack(
          children: [
            Container(
              alignment: FractionalOffset(0.2, 0.01),
              child: FractionallySizedBox( // level
                child: Text(
                  "Lv.???",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ), // end of level
            ),
            Container( // problem type
              alignment: FractionalOffset(0.84, 0.16),
              child: FractionallySizedBox(
                child: Text(
                  "단답형 문제",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ), // end of problem type
            Container( // code part
              alignment: FractionalOffset(0.5, 0.85),
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.72,
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
                      fontSize: 20,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ), // end of code part
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('icon/problem_bg.png'),
            fit: BoxFit.contain,
          ),
        ),
      ), // end of background of problem body
    ); // end of problem body
  }
}