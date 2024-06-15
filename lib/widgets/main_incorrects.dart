/*
 * edit: 2024-04-01
 * 딩카 메인 화면 - 하단 메뉴 버튼(오답노트)
 */

import 'package:coding_cow_app/widgets/problem_multiple_choice.dart';
import 'package:flutter/material.dart';

class Main_Incorrects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( // Incorrects
      flex: 4, // 버튼(4):여백(2):버튼(4)
      child: TextButton(
        onPressed: () { // press event
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Problem_Multiple_Choice()), // 장면 이동
          );
        },
        style: TextButton.styleFrom( // theme
          backgroundColor: Color(0xff9bbb49),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(10), // 상하좌우 10px
        ),
        child: Row( // align (→)
          children: [
            Image( // icon
              image: AssetImage('icon/to-do-list.png'),
              width: 80,
            ),
            SizedBox( // 공백
              width: 20,
            ),
            Text( // text
              '오답\n노트',
              style: TextStyle(
                letterSpacing: -2,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ); // end of incorrects
  }
}