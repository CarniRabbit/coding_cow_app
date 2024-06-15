/*
 * edit: 2024-05-01
 * 딩카 문제 화면 - 중앙
 */

import 'package:flutter/material.dart';
import 'package:coding_cow_app/widgets/problem_code_part.dart';

class Problem_Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Expanded( // problem body
      flex: 4,
      child: Container( // background of problem body
        child: Stack(
          // stack과 fractionalOffset을 이용하여 각기 다른 너비의 화면에서도 안꺠지게 배치
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
            Problem_Code_Part(), // 문제(code)가 출력되는 부분
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